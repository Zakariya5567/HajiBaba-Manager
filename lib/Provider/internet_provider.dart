import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haji_baba_manager/Provider/order_screen_provider.dart';
import 'package:haji_baba_manager/Utils/const_style.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:overlay_support/overlay_support.dart';

class InternetProvider extends ChangeNotifier{

  bool connection=false;
  internetChecker(BuildContext context) {


    notifyListeners();
    if (InternetConnectionStatus.connected ==
        InternetConnectionStatus.connected) {
      print("ddd connected");
    }
    else if
    (InternetConnectionStatus.disconnected ==
        InternetConnectionStatus.disconnected) {
      print("not ddd connected");

      // }
      // InternetConnectionChecker().onStatusChange.listen((status) {
      //   switch(status) {
      //     case InternetConnectionStatus.connected:
      //       connection=true;
      //       notifyListeners();
      //       print('connected');
      //       showSimpleNotification(
      //         const Text('Internet Connected',style: TextStyle(
      //             color: Colors.white,fontSize: 36
      //         ),),
      //         background: Colors.green
      //       );
      //       break;
      //     case InternetConnectionStatus.disconnected:
      //       connection=false;
      //       notifyListeners();
      //       showConnectionDialog(context);
      //       print('disconnected');
      //       showSimpleNotification(
      //         const Text('No Internet Connection',style: TextStyle(
      //             color: Colors.white,fontSize: 36,
      //         ),),
      //         background:Colors.red
      //       );
      //       break;
      //   }
      // });
    }
  }
  // showConnectionDialog(BuildContext context, ) {
  //   AlertDialog alert = AlertDialog(
  //     backgroundColor: ConstStyle.cardGreyColor,
  //     shape: RoundedRectangleBorder(
  //       borderRadius:BorderRadius.circular(20.sp),
  //     ),
  //     title:   Padding(
  //       padding: EdgeInsets.all(80.sp),
  //       child:
  //               Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: [
  //                   SizedBox(height: 100.sp,),
  //                   Image.asset('assets/images/errorImage.png',
  //                     height: 100.sp,width:100.sp ,),
  //                   SizedBox(height: 80.sp,),
  //                   Text("Network Error",style:TextStyle(
  //                       fontSize: 50.w,color: Colors.red,
  //                       fontWeight: FontWeight.w700
  //                   )),
  //                   SizedBox(height: 80.sp,),
  //                   Text("Check your internet connection",style:TextStyle(
  //                     fontSize: 40.w,color: Colors.red,
  //                     fontWeight: FontWeight.w500
  //                   )),
  //                   SizedBox(height:80.sp),
  //                   GestureDetector(
  //                     child: Container(
  //                       height: 110.sp,
  //                       width: 500.sp,
  //                       decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(50.sp),
  //                         color: ConstStyle.orangeColor,
  //                       ),
  //                       child: Center(child: Text("Ok",
  //                         style: TextStyle(
  //                           color: Colors.white,
  //                           fontSize: 50.sp,
  //                           fontWeight: FontWeight.w500,
  //                           fontFamily: ConstStyle.poppins,
  //                         ),)),
  //                     ),
  //                     onTap: (){
  //                       Navigator.of(context).pop();
  //                     },
  //                   ),
  //                   SizedBox(height: 100.sp,),
  //
  //                 ],
  //               ),
  //     ),
  //   );
  //
  //   // show the dialog
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  // }

}