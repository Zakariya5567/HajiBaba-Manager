import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haji_baba_manager/Screens/Order_Screen/portrait/portrait_order_screen.dart';

import 'landscape/landscape_order_screen.dart';
class OrderScreen extends StatelessWidget {
  const OrderScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxHeight > constraints.maxWidth) {
        return  PortraitOrderScreen();
      }
      else {
        return  LandscapeOrderScreen();
      }
    });

  }
  }

