import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:haji_baba_manager/Model/order_model.dart';
import 'package:haji_baba_manager/Utils/api_url.dart';
import 'package:haji_baba_manager/services/shared_preferences.dart';
import 'package:http/http.dart'as http;


class OrderApi{

  // this class is used to get orders(all,pending,processing,complete,ready, order) form api
  // OrderModel is the instance of Order model class
  // getAllOrderById function is used to get all order from api

  // getPendingOrderById function is used to get pending order from api
  // getProcessingOrderById function is used to get processing order from api
  // getReadyForCollectionOrderById function is used to get ready for collection order from api
  // getCompleteOrderById function is used to get complete order from api
  // getCompleteOrderById function is used to get complete order from api

  OrderModel orderModel;

  Future<OrderModel> getAllOrderById(context, int allCurrentPage, String searchTerm) async {

    SharedPreferencesData sharedPreferencesData=SharedPreferencesData();

    final data= await sharedPreferencesData.getFirebaseData();
    String id=data['data']['storeId'].toString();
    String page=allCurrentPage.toString();
    String moreData= '$id&page=$page&size=20&SearchTerm=$searchTerm';

    try {
      String url = ApiUrl.allOrderUrl+moreData;
      final headers = {"Content-Type": 'application/json; charset=UTF-8'};
      final response = await http.get(Uri.parse(url),headers: headers);
        final responseBody = response.body;
        final decodeResponse = jsonDecode(responseBody);
        print(decodeResponse);
        orderModel = OrderModel.fromJson(decodeResponse);
        return orderModel;

    }catch(e){
      print("the error is :$e");
    }
    return orderModel;
  }

  Future<OrderModel> getPendingOrderById(context, int pendingCurrentPage, String searchTerm) async {

    SharedPreferencesData sharedPreferencesData=SharedPreferencesData();
    final data= await sharedPreferencesData.getFirebaseData();
    String id=data['data']['storeId'].toString();
    String page=pendingCurrentPage.toString();
    String moreData='$id&page=$page&size=20&SearchTerm=$searchTerm';
    try {
      String url = ApiUrl.pendingOrderUrl+moreData;
      final headers = {"Content-Type": 'application/json; charset=UTF-8'};
      final response = await http.get(Uri.parse(url),headers: headers);
      final responseBody = response.body;
      final decodeResponse = jsonDecode(responseBody);
      print(decodeResponse);
      orderModel = OrderModel.fromJson(decodeResponse);
      return orderModel;

    }catch(e){
      print("the error is :$e");
    }
    return orderModel;
  }

  Future<OrderModel> getProcessingOrderById(context, int processingCurrentPage, String searchTerm) async {

    SharedPreferencesData sharedPreferencesData=SharedPreferencesData();

    final data= await sharedPreferencesData.getFirebaseData();
    String id=data['data']['storeId'].toString();
    String page=processingCurrentPage.toString();
    String moreData= '$id&page=$page&size=20&SearchTerm=$searchTerm';
    try {
      String url = ApiUrl.processingOrderUrl+moreData;
      final headers = {"Content-Type": 'application/json; charset=UTF-8'};
      final response = await http.get(Uri.parse(url),headers: headers);
      final responseBody = response.body;
      final decodeResponse = jsonDecode(responseBody);
      orderModel = OrderModel.fromJson(decodeResponse);
      return orderModel;

    }catch(e){
      print("the error is :$e");
    }
    return orderModel;
  }

  Future<OrderModel> getReadyForCollectionOrderById(context, int readyCurrentPage, String searchTerm) async {


    SharedPreferencesData sharedPreferencesData=SharedPreferencesData();

    final data= await sharedPreferencesData.getFirebaseData();

    String id=data['data']['storeId'].toString();
    String page=readyCurrentPage.toString();
    String moreData= '$id&page=$page&size=20&SearchTerm=$searchTerm';
    try {
      String url = ApiUrl.readyForCollectionUrl+moreData;
      final headers = {"Content-Type": 'application/json; charset=UTF-8'};
      final response = await http.get(Uri.parse(url),headers: headers);
      final responseBody = response.body;
      final decodeResponse = jsonDecode(responseBody);
      print(decodeResponse);
      orderModel = OrderModel.fromJson(decodeResponse);
      return orderModel;

    }catch(e){
      print("the error is :$e");
    }
    return orderModel;
  }

  Future<OrderModel> getCompleteOrderById(context, int completeCurrentPage, String searchTerm) async {

    SharedPreferencesData sharedPreferencesData=SharedPreferencesData();

    final data= await sharedPreferencesData.getFirebaseData();
    String id=data['data']['storeId'].toString();
    String page=completeCurrentPage.toString();
    String moreData= '$id&page=$page&size=20&SearchTerm=$searchTerm';
    try {
      String url = ApiUrl.completeOrderUrl+moreData;
      final headers = {"Content-Type": 'application/json; charset=UTF-8'};
      final response = await http.get(Uri.parse(url),headers: headers);
      final responseBody = response.body;
      final decodeResponse = jsonDecode(responseBody);
      orderModel = OrderModel.fromJson(decodeResponse);
      return orderModel;

    }catch(e){
      print("the error is :$e");
    }
    return orderModel;
  }

  Future<OrderModel> getTodayOrderById(context, int todayCurrentPage, String searchTerm) async {

    SharedPreferencesData sharedPreferencesData=SharedPreferencesData();
    final data= await sharedPreferencesData.getFirebaseData();
    String id=data['data']['storeId'].toString();
    String page=todayCurrentPage.toString();
    String moreData= '$id&page=$page&size=20&SearchTerm=$searchTerm';
    try {
      String url = ApiUrl.todayOrderUrl+moreData;
      final headers = {"Content-Type": 'application/json; charset=UTF-8'};
      final response = await http.get(Uri.parse(url),headers: headers);
      final responseBody = response.body;
      final decodeResponse = jsonDecode(responseBody);
      orderModel = OrderModel.fromJson(decodeResponse);
      return orderModel;

    }catch(e){
      print("the error is :$e");
    }
    return orderModel;
  }

}