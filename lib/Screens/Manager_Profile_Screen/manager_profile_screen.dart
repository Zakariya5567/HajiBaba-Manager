
import 'package:flutter/material.dart';
import 'package:haji_baba_manager/Screens/DashBoard_screen/portrait/dash_board_screen_portrait.dart';
import 'package:haji_baba_manager/Screens/Login_Form_Screen/portrait/login_form_screen_portrait.dart';
import 'package:haji_baba_manager/Screens/Manager_Profile_Screen/portrait/manager_profile_screen_portrait.dart';

import 'landscape/manager_profile_screen_landscape.dart';

class ManagerProfileScreen extends StatelessWidget {
  const ManagerProfileScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  LayoutBuilder(builder: (context,constraints){
      if(constraints.maxHeight>constraints.maxWidth){
        return   PortraitManagerProfileScreen();
      }
      else{
        return LandscapeManagerProfileScreen() ;//LandscapeLoginFormScreen();
      }
    });
  }
}

