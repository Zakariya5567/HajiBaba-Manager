import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haji_baba_manager/Widgets/side_menu_bar/portrait_side_bar/portrait_side_bar.dart';

import 'landscape_side_bar/landscape_side_bar.dart';
class SideMenuBar extends StatelessWidget {
 const SideMenuBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  LayoutBuilder(builder: (context,constraints){
      if(constraints.maxHeight>constraints.maxWidth){
        return const PortraitSideBar();
      }
      else{
        return const LandscapeSideBar();
      }
    });
  }
}
