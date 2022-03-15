import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haji_baba_manager/Utils/images.dart';
import 'package:haji_baba_manager/services/shared_preferences.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {

  // login function is used to check the user is already login or not
  // if the user is already login it will navigate to the dashboard
  // or if the user is not login it will navigate to the login screen
  // duration is the time for splach screen

   SharedPreferencesData sharedPreferencesData =SharedPreferencesData();

   void login()async{
     bool login=await sharedPreferencesData.loginBool();
     Timer(
         const Duration(seconds: 5),()=>
            login==true?
          Navigator.of(context).pushReplacementNamed('/dashBoardScreen')
                : Navigator.of(context).pushReplacementNamed('/loginScreen')
     );
   }

  @override
  void initState() {
    super.initState();
    login();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
       height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(ConstImages.splashImage)
          )
        ),
    );
  }
}

