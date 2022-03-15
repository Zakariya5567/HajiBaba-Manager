import 'dart:convert';

import 'package:haji_baba_manager/Model/order_detail_model.dart';
import 'package:haji_baba_manager/Utils/api_url.dart';
import 'package:http/http.dart'as http;
class OrderDetailApi{
  //OrderDetailModel is the instance of OrderDetailModel class
  //getOrderDetailData is a function to get order detail from the api

  OrderDetailModel orderDetailModel;

  Future<OrderDetailModel> getOrderDetailData(context, id) async {
   String orderId=id;
    try {
      String url = ApiUrl.orderDetailUrl;
      final headers = {"Content-Type": 'application/json; charset=UTF-8'};
      final response = await http.get(Uri.parse(url+orderId),headers: headers);
      if (response.statusCode == 200 &&
          response.body.contains("Order Found!")) {
        final responseBody = response.body;
        final decodeResponse = jsonDecode(responseBody);
        orderDetailModel = OrderDetailModel.fromJson(decodeResponse);
        print(decodeResponse);
        return orderDetailModel;
      }
      else {
        print("No Order found");
      }
    }catch(e){
      print("the error is :$e");
    }
    return orderDetailModel;
  }
}