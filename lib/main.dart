import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:haji_baba_manager/Provider/internet_provider.dart';
import 'package:haji_baba_manager/Provider/manager_profile_provider.dart';
import 'package:haji_baba_manager/Provider/order_detail_provider.dart';
import 'package:haji_baba_manager/Provider/status_provider.dart';
import 'package:haji_baba_manager/Screens/DashBoard_screen/dash_baord_screen.dart';
import 'package:haji_baba_manager/Screens/Manager_Profile_Screen/manager_profile_screen.dart';
import 'package:haji_baba_manager/Screens/Order_Detail_Screen/order_detail_screen.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'Provider/dashboard_provider.dart';
import 'Provider/login_provider.dart';
import 'Provider/order_screen_provider.dart';
import 'Provider/profile_provider.dart';
import 'Screens/Login_Screen/login_screen.dart';
import 'Screens/Order_Screen/order_screen.dart';
import 'Screens/Splash_Screen/splash_screen.dart';
import 'Screens/Login_Form_Screen/login_form_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


// for push notification
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications',// title
 // 'This channel is used for important notifications.', // description
  importance: Importance.max,
  playSound: true,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();


Future<void> backgroundHandler(RemoteMessage message) async{
  await Firebase.initializeApp();
}

Future<void> main()async{

  // this steps is use to get the firebase token
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

//====================================================================================
  // use for push notifications
  // when the app is closed running on background
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true, // Required to display a heads up notification
    badge: true,
    sound: true,
  );
  // to get the firebase token use this function
  FirebaseMessaging.instance.getToken().then((value) {
    String token = value;
    print("firebase token is :${token}");
  });
//====================================================================================
  // this steps is used to get the device physical address

    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) { // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      var deviceId=iosDeviceInfo.identifierForVendor;
      print(" ios device : ${deviceId}");
    //  return deviceId; // unique ID on iOS
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      var deviceId=androidDeviceInfo.androidId;
      print("android device ${deviceId}");
    //  return deviceId; // unique ID on Android
    }


  runApp(
      MultiProvider(providers: [
        ChangeNotifierProvider<LoginProvider>(create: (context)=>LoginProvider()),
        ChangeNotifierProvider<ProfileProvider>(create: (context)=>ProfileProvider()),
        ChangeNotifierProvider<OrderProvider>(create: (context)=>OrderProvider()),
        ChangeNotifierProvider<OrderDetailProvider>(create: (context)=>OrderDetailProvider()),
        ChangeNotifierProvider<DashboardProvider>(create: (context)=>DashboardProvider()),
        ChangeNotifierProvider<ManagerProfileProvider>(create: (context)=>ManagerProfileProvider()),
        ChangeNotifierProvider<InternetProvider>(create: (context)=>InternetProvider()),
        ChangeNotifierProvider<StatusProvider>(create: (context)=>StatusProvider()),


      ],
        child:const MyApp() ,
      )
  );
}
class MyApp extends StatefulWidget {
   const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;

      // If `onMessage` is triggered with a notification, construct our own
      // local notification to show to users using the created channel.
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
               // channel.description,
                icon: '@mipmap/ic_launcher',
                // other properties...
              ),
            ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      //The design size is used for tablet
      designSize: const Size(1200, 2000),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: () =>  OverlaySupport.global(
        child: MaterialApp(
            builder: (context, widget) {
              ScreenUtil.setContext(context);
              return MediaQuery(
                //Setting font does not change with system font size
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: widget,
              );
            },
            debugShowCheckedModeBanner: false,
            title: "Haji Baba Halal Meat Counter",
            initialRoute: '/',
            routes: {
              '/': (context) => const SplashScreen(),
              '/loginScreen': (context) => const LoginScreen(),
              '/loginFormScreen': (context) => const LoginFormScreen(),
              '/orderScreen': (context) =>  const OrderScreen(),
              '/orderDetailScreen': (context) => const OrderDetailScreen(),
              '/dashBoardScreen':(context)=> DashBoardScreen(),
              '/managerProfileScreen':(context)=> ManagerProfileScreen(),
            },
          ),
      ),

    );
  }
}
