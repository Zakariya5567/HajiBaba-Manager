import 'package:flutter/cupertino.dart';
import 'package:haji_baba_manager/Model/dashboard_model.dart';
import 'package:haji_baba_manager/Model/order_detail_model.dart';
import 'package:haji_baba_manager/Widgets/connection_checker_dialog.dart';
import 'package:haji_baba_manager/services/connection_checker.dart';
import 'package:haji_baba_manager/services/dashboard_api.dart';
import 'package:haji_baba_manager/services/order_detial_api.dart';

class DashboardProvider extends ChangeNotifier{

  OrderDetailApi orderDetailApi=OrderDetailApi();
  DashboardApi dashboardApi=DashboardApi();
  List todayOrderList=[];
  Map dashboardDetailData={};

  int isLoading=0;

  loading(int load){
    isLoading=load;
    notifyListeners();
  }

  //Connection checker is the instance of connection checker class
  // in which we are listening that the internet in connected or not
  //ConnectionCheckerDialog is the instance of ConnectionCheckerDialog class
  // if the network is not connected the alert dialog will be popup

  ConnectionChecker connectionChecker=ConnectionChecker();
  ConnectionCheckerDialog connectionCheckerDialog=ConnectionCheckerDialog();


  getDashboardDetail(context) async {
    bool connection=await connectionChecker.checkNetwork();
    if(connection==true){
      DashboardModel dashboardModel =await dashboardApi.storeDashboard(context);
      Map dashboardData=dashboardModel.toJson();
      dashboardDetailData=dashboardData['data'];
      todayOrderList =dashboardDetailData['productsList'];
      notifyListeners();
      return dashboardModel;
    }
    else{
      connectionCheckerDialog.showConnectionDialog(context);
    }


  }



}