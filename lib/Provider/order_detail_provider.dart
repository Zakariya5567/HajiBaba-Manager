import 'package:flutter/cupertino.dart';
import 'package:haji_baba_manager/Model/order_detail_model.dart';
import 'package:haji_baba_manager/Widgets/connection_checker_dialog.dart';
import 'package:haji_baba_manager/services/connection_checker.dart';
import 'package:haji_baba_manager/services/order_detial_api.dart';

class OrderDetailProvider extends ChangeNotifier{

  // OrderDetailApi is the instance of OrderDetailApi class
// productDetailList is to store the list of productDetailList
// which is present in the map of the order detail
// isLoading is used to wait when the data is in loading form
//  loading method is used to update the isLoading variable in running time

  OrderDetailApi orderDetailApi=OrderDetailApi();
  List productDetailList=[];
  Map orderDetail={};

  int isLoading=0;

  loading(int load){
    isLoading=load;
    notifyListeners();
  }

  //Connection checker is the instance of connection checker class
  // in which we are listening that the internet in connected or not
  //ConnectionCheckerDialog is the instance of ConnectionCheckerDialog class
  // if the network is not connected the alert dialog will be popup
  // getOrderDetail method is call the api and get the order detail from the api

  ConnectionChecker connectionChecker=ConnectionChecker();
  ConnectionCheckerDialog connectionCheckerDialog=ConnectionCheckerDialog();

  getOrderDetail(context,orderId) async {
    bool connection=await connectionChecker.checkNetwork();
    if(connection==true){
      OrderDetailModel orderDetailModel =await orderDetailApi.getOrderDetailData(context,orderId);
      Map orderDetailData=orderDetailModel.toJson();
      orderDetail=orderDetailData['data'];
      productDetailList=orderDetail['productsList'];
      notifyListeners();
      return orderDetailModel;
    }
    else{
      connectionCheckerDialog.showConnectionDialog(context);
    }
  }

}

