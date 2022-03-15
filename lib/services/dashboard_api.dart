import 'dart:convert';
import 'package:haji_baba_manager/Model/dashboard_model.dart';
import 'package:haji_baba_manager/Utils/api_url.dart';
import 'package:haji_baba_manager/services/shared_preferences.dart';
import 'package:http/http.dart'as http;


class DashboardApi{

  DashboardModel dashboardModel;

  Future<DashboardModel> storeDashboard(context) async {

    SharedPreferencesData sharedPreferencesData=SharedPreferencesData();
    final data= await sharedPreferencesData.getFirebaseData();
    int id=data['data']['storeId'];
    String storeId=id.toString();
    try {
      String url = ApiUrl.dashboardUrl;
      final headers = {"Content-Type": 'application/json; charset=UTF-8'};
      final response = await http.get(Uri.parse(url+storeId),headers: headers);
      if (response.statusCode == 200 &&
          response.body.contains("Store Dashboard Data!")) {
        final responseBody = response.body;
        final decodeResponse = jsonDecode(responseBody);
        dashboardModel = DashboardModel.fromJson(decodeResponse);
        return dashboardModel;
      }
      else {
        print("No Dashboard data");
      }
    }catch(e){
      print(e);
    }
    return dashboardModel;
  }

}