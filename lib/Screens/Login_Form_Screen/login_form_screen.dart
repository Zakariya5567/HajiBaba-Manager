
import 'package:flutter/material.dart';
import 'package:haji_baba_manager/Screens/Login_Form_Screen/portrait/login_form_screen_portrait.dart';

import 'landscape/login_form_screen_landscape.dart';

class LoginFormScreen extends StatelessWidget {
  const LoginFormScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  LayoutBuilder(builder: (context,constraints){
      if(constraints.maxHeight>constraints.maxWidth){
        return  PortraitLoginFormScreen();
      }
      else{
        return  LandscapeLoginFormScreen();
      }
    });
  }
  }

