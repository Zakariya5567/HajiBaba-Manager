import 'package:flutter/material.dart';
import 'package:haji_baba_manager/Model/all_status_list_model.dart';
import 'package:haji_baba_manager/Model/update_order_status_model.dart';
import 'package:haji_baba_manager/Widgets/connection_checker_dialog.dart';
import 'package:haji_baba_manager/services/connection_checker.dart';
import 'package:haji_baba_manager/services/order_status_api.dart';
class StatusProvider extends ChangeNotifier{

  //OrderStatusApi is the instance of theOrderStatusApi class
  //statusList is a list to store the data of the status
  //selectedValue is the current value(name) of the selected value of the dropdown
  // change value is used to update the value on run time when the user select any status
  //isLoading and loading will used when the data is loading from api
  // id is the id of dropdown in the list it will change on run time when the user click
  // on the item and the change id  method is used to update

  OrderStatusApi orderStatusApi=OrderStatusApi();

  List statusList=[];

  String selectedValue='';

  int isLoading=0;

  int id=0;

  loading(int load){
    isLoading=load;
    notifyListeners();
  }

  changeValue(String newValue){
    selectedValue=newValue;
    notifyListeners();
  }

  changeId(int newId){
    id=newId;
    notifyListeners();
  }

  //Connection checker is the instance of connection checker class
  // in which we are listening that the internet in connected or not
  //ConnectionCheckerDialog is the instance of ConnectionCheckerDialog class
  // if the network is not connected the alert dialog will be popup
  //getAllStatus method is to call the api and get the status
  //updateOrderStatus method is used to call the api and update the status of order

  ConnectionChecker connectionChecker=ConnectionChecker();
  ConnectionCheckerDialog connectionCheckerDialog=ConnectionCheckerDialog();


  getAllStatus(context) async {
    bool connection=await connectionChecker.checkNetwork();
    if(connection==true){
      AllStatusListModel statusListModel =await orderStatusApi.getAllStatusList(context);
      Map data=statusListModel.toJson();
      List list =data['data'];
      statusList=list.toList(growable: true);
      notifyListeners();
      return statusListModel;
    }
    else{
      connectionCheckerDialog.showConnectionDialog(context);
    }
  }


  updateOrderStatus(int statusId ,String orderId, BuildContext context) async {
    bool connection=await connectionChecker.checkNetwork();
    if(connection==true){
     UpdateStatusModel updateOrderStatusModel =
     await orderStatusApi.updateStatusById(statusId, orderId);
      notifyListeners();
      return updateOrderStatusModel;
    }
    else{
      connectionCheckerDialog.showConnectionDialog(context);
    }

  }

}
