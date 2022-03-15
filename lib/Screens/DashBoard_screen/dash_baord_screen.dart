
import 'package:flutter/material.dart';
import 'package:haji_baba_manager/Screens/DashBoard_screen/portrait/dash_board_screen_portrait.dart';
import 'package:haji_baba_manager/Screens/Login_Form_Screen/portrait/login_form_screen_portrait.dart';

import 'landscape/dash_board_screen_landscape.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  LayoutBuilder(builder: (context,constraints){
      if(constraints.maxHeight>constraints.maxWidth){
        return  PortraitDashBoardScreen();
      }
      else{
        return  LandscapeDashBoardScreen();//LandscapeLoginFormScreen();
      }
    });
  }
}

