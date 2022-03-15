import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haji_baba_manager/Screens/Order_Detail_Screen/portrait/portrait_order_detail_screen.dart';
import 'landscape/landscape_order_detail_screen.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxHeight > constraints.maxWidth) {
        return PortraitOrderDetailScreen();
      }
      else {
        return LandscapeOrderDetailScreen();
      }
    });
  }
}
