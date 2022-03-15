import 'dart:convert';
import 'package:haji_baba_manager/Model/all_status_list_model.dart';
import 'package:haji_baba_manager/Model/order_detail_model.dart';
import 'package:haji_baba_manager/Model/update_order_status_model.dart';
import 'package:haji_baba_manager/Utils/api_url.dart';
import 'package:http/http.dart'as http;
class OrderStatusApi{

AllStatusListModel allStatusListModel;
UpdateStatusModel updateStatusModel;

Future<AllStatusListModel> getAllStatusList(context) async {
    try {
      String url = ApiUrl.allOrderStatusUrl;
      final headers = {"Content-Type": 'application/json; charset=UTF-8'};
      final response = await http.get(Uri.parse(url),headers: headers);
      if (response.statusCode == 200 &&
          response.body.contains("Found")) {
        final responseBody = response.body;
        final decodeResponse = jsonDecode(responseBody);
        allStatusListModel = AllStatusListModel.fromJson(decodeResponse);
        return allStatusListModel;
      }
      else {
        print("No List Found");
      }
    }catch(e){
      print("the error is :$e");
    }
    return allStatusListModel;
  }

Future<UpdateStatusModel> updateStatusById(
    int statusId, String orderId) async {
  try {
    String url = ApiUrl.updateStatusUrl;
    final data = {'orderStatusId': statusId, 'orderId': orderId};
    final headers = {"Content-Type": 'application/json; charset=UTF-8'};
    final body = jsonEncode(data);
    final response = await http.post(Uri.parse(url), headers: headers, body: body,);
    if (response.statusCode == 200 &&
        response.body.contains( "Order Order Status Updated!")) {
      final responseBody = response.body;
      final decodeResponse = jsonDecode(responseBody);
      updateStatusModel = UpdateStatusModel.fromJson(decodeResponse);
      print("decode response is :                   $decodeResponse");
      return updateStatusModel;
    }
    else {
      print("order not updated");
    }
  }catch(e){
    print("the error is : $e");
  }
  return updateStatusModel;
}


}