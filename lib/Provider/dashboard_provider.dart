import 'package:flutter/cupertino.dart';
import 'package:haji_baba_manager/Model/dashboard_model.dart';
import 'package:haji_baba_manager/Model/order_detail_model.dart';
import 'package:haji_baba_manager/Widgets/connection_checker_dialog.dart';
import 'package:haji_baba_manager/services/connection_checker.dart';
import 'package:haji_baba_manager/services/dashboard_api.dart';
import 'package:haji_baba_manager/services/order_detial_api.dart';

class DashboardProvider extends ChangeNotifier{

// OrderDetailApi is the instance of orderDetailApi class
// DashboardApi is the instance of dashboardApi class
// todayOrderList is to store the list of today order which is present in the map of the dashboard
// dashboardDetailData is to store all the data of which is get from the api
// isLoading is used to wait when the data is in loading form
//  loading method is used to update the isLoading variable in running time

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
  //getDashboardDetail method is used to get the dashboard data from the api

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