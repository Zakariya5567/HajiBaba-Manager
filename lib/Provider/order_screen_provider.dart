import 'package:flutter/material.dart';
import 'package:haji_baba_manager/Model/order_model.dart';
import 'package:haji_baba_manager/Widgets/connection_checker_dialog.dart';
import 'package:haji_baba_manager/services/connection_checker.dart';
import 'package:haji_baba_manager/services/order_api.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
class OrderProvider extends ChangeNotifier{

  //OrderApi is the instance of OrderApi class
  // pendingList is a list to store the list data of pending orders
  // processingList is a list to store the list data of processing orders
  // readyForCollectionList is a list to store the list ready for collection of pending orders
  // completeList is a list to store the list data of complete orders
  // allOrderList is a list to store the list data of all  orders
  // todayList is a list to store the list data of today orders

  // isLoading and loading is used for the wait one the api data is loading

  OrderApi orderApi=OrderApi();

  List pendingList=[];
  List processingList=[];
  List readyForCollectionList=[];
  List completeList=[];
  List allOrderList=[];
  List todayList=[];

  int isLoading=0;

  loading(int load){
    isLoading=load;
    notifyListeners();
  }

  // =================================================================================
  // to change the color of button in sidebar
  // the function is used the update variable is runtime
  bool pendingColor=false;
  bool processingColor=false;
  bool readyColor=false;
  bool completeColor=false;
  bool allColor=false;

  buttonAllColor(bool changeColor){
    notifyListeners();
    allColor=changeColor;
  }

  buttonPendingColor(bool changeColor){
    notifyListeners();
    pendingColor=changeColor;
  }

  buttonProcessingColor(bool changeColor){
    notifyListeners();
    processingColor=changeColor;
  }

  buttonReadyColor(bool changeColor){
    notifyListeners();
    readyColor=changeColor;
  }

  buttonCompleteColor(bool changeColor){
    notifyListeners();
    completeColor=changeColor;
  }

  // =================================================================================
  // this function is used to change th method(pending,all,completed,ready,processing)
  // showOrders is to store the the name of the screen on run time when the user navigate
  // from one screen to another

  String showOrders="";

  pageController(String order){
    showOrders=order;
    notifyListeners();
  }
  // =================================================================================
  // this function is used to change the  method(pending,all,completed,ready,processing)
  // current page is use for pagination
  // total page is used for pagination
  // refresh controller is used for pagination and the instance of refresh controller
  // search page is used to set on which page the user is searching for data
  // search data is used to store the text inside the search field which the user want to search

  int allCurrentPage=1, pendingCurrentPage=1, processingCurrentPage=1,
      readyCurrentPage=1,completeCurrentPage=1,todayCurrentPage=1;
  int totalPages;

  RefreshController refresh;

  String searchTerm;
  String searchPage;

  searchPageData(String newPage){
    searchPage=newPage;
    notifyListeners();
  }

  searchData(String newSearchTerm){
    searchTerm=newSearchTerm;
    notifyListeners();
  }


  //Connection checker is the instance of connection checker class
  // in which we are listening that the internet in connected or not
  //ConnectionCheckerDialog is the instance of ConnectionCheckerDialog class
  // if the network is not connected the alert dialog will be popup

  // getAllOrder method to call the api and get all order list from api
  // getPendingOrder method to call the api and get pending order list from api
  // getProcessingOrder method to call the api and get processing order list from api
  // getReadyForCollectionOrder method to call the api and ready order list from api
  // getCompleteOrder method to call the api and get complete list from api
  // getTodayOrder method to call the api and get all today list from api

 ConnectionChecker connectionChecker=ConnectionChecker();
  ConnectionCheckerDialog connectionCheckerDialog=ConnectionCheckerDialog();

  getAllOrder(context) async {
     bool connection=await connectionChecker.checkNetwork();
     if(connection==true){

       OrderModel orderModel =await orderApi.getAllOrderById(context,allCurrentPage,searchTerm);
       Map data=orderModel.toJson();
       List list =data['data'];
       totalPages=orderModel.totalPages;

       if(allCurrentPage==1){
         allOrderList=list;
       }else {
         if (allCurrentPage <= totalPages) {
           allOrderList.addAll(list);
           refresh.loadComplete();
         }
         else {
           refresh.loadNoData();
         }
       }
       notifyListeners();
       return orderModel;
     }
     else{
       connectionCheckerDialog.showConnectionDialog(context);
     }
  }

  getPendingOrder(context) async {
    bool connection=await connectionChecker.checkNetwork();
    if(connection==true){

      OrderModel orderModel =await orderApi.getPendingOrderById(context,pendingCurrentPage,searchTerm);
      Map data=orderModel.toJson();
      List list =data['data'];

      totalPages=orderModel.totalPages;

      if(pendingCurrentPage==1){
        pendingList=list;
      }else {
        if (pendingCurrentPage <= totalPages) {
          pendingList.addAll(list);
          refresh.loadComplete();
        }
        else {
          refresh.loadNoData();
        }
      }
      notifyListeners();
      return orderModel;
    }
    else{
      connectionCheckerDialog.showConnectionDialog(context);
    }

  }

  getProcessingOrder(context) async {
    bool connection=await connectionChecker.checkNetwork();
    if(connection==true){

      OrderModel orderModel =await orderApi.getProcessingOrderById
        (context,processingCurrentPage,searchTerm);
      Map data=orderModel.toJson();
      List list =data['data'];
      totalPages=orderModel.totalPages;

      if(processingCurrentPage==1){
        processingList=list;
      }else {
        if (processingCurrentPage <= totalPages) {
          processingList.addAll(list);
          refresh.loadComplete();
        }
        else {
          refresh.loadNoData();
        }
      }

      notifyListeners();
      return orderModel;
    }
    else{
      connectionCheckerDialog.showConnectionDialog(context);
    }

  }

  getReadyForCollectionOrder(context) async {
    bool connection=await connectionChecker.checkNetwork();
    if(connection==true){

      OrderModel orderModel =await orderApi.getReadyForCollectionOrderById
        (context,readyCurrentPage,searchTerm);
      Map data=orderModel.toJson();
      List list =data['data'];

      totalPages=orderModel.totalPages;

      if(readyCurrentPage==1){
        readyForCollectionList=list;
      }else {
        if (readyCurrentPage <= totalPages) {
          readyForCollectionList.addAll(list);
          refresh.loadComplete();
        }
        else {
          refresh.loadNoData();
        }
      }

      notifyListeners();
      return orderModel;
    }
    else{
      connectionCheckerDialog.showConnectionDialog(context);
    }

  }

  getCompleteOrder(context) async {
    bool connection=await connectionChecker.checkNetwork();
    if(connection==true){

      OrderModel orderModel =await orderApi.getCompleteOrderById
        (context,completeCurrentPage,searchTerm);
      Map data=orderModel.toJson();
      List list =data['data'];
      totalPages=orderModel.totalPages;

      if(completeCurrentPage==1){
        completeList=list;
      }else {
        if (completeCurrentPage <= totalPages) {
          completeList.addAll(list);
          refresh.loadComplete();
        }
        else {
          refresh.loadNoData();
        }
      }
      // completeList =list.toList(growable: true);
      notifyListeners();
      return orderModel;
    }
    else{

      connectionCheckerDialog.showConnectionDialog(context);
    }

  }

  getTodayOrder(context) async {
    bool connection=await connectionChecker.checkNetwork();
    if(connection==true){
      OrderModel orderModel =await orderApi.getTodayOrderById
        (context,todayCurrentPage,searchTerm);
        Map data=orderModel.toJson();
        List list =data['data'];
        totalPages=orderModel.totalPages;

      if(todayCurrentPage==1){
        todayList=list;
      }else {
        if (todayCurrentPage <= totalPages) {
          todayList.addAll(list);
          refresh.loadComplete();
        }
        else {
          refresh.loadNoData();
        }
      }

      notifyListeners();
      return orderModel;
    }
    else{
      connectionCheckerDialog.showConnectionDialog(context);
    }

  }

}
