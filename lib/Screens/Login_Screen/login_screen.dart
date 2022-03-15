import 'package:flutter/material.dart';
import 'package:haji_baba_manager/Screens/Login_Screen/portrait/login_screen_portrait.dart';
import 'landscape/login_screen_landscape.dart';
class LoginScreen extends StatelessWidget {
  const LoginScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return
      LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxHeight > constraints.maxWidth) {
        return  PortraitLoginScreen();
      }
      else {
        return const LandscapeLoginScreen();
      }
    });
  }

}