import 'dart:convert';
import 'package:haji_baba_manager/Model/reset_password_model.dart';
import 'package:haji_baba_manager/Model/store_manager_by_id.dart';
import 'package:haji_baba_manager/Utils/api_url.dart';
import 'package:haji_baba_manager/services/shared_preferences.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfileApi{

  //  StoreManagerById is the instance of  storeManagerById class;
  //   ResetPasswordModel is the instance of resetPasswordModel class;
  //  getStoreManagerById method is use to get store manger data from the api
  //  requestResetPassword method request to reset the manger password

  StoreManagerById storeManagerById;
  ResetPasswordModel resetPasswordModel;

  Future<StoreManagerById> getStoreManagerById(context) async {

    SharedPreferencesData sharedPreferencesData=SharedPreferencesData();
    int id=await sharedPreferencesData.getId();
    String userId="?Id=${id.toString()}";
    print("id is $id");

    try {
      String url = ApiUrl.getStoreManagerById;
      final headers = {"Content-Type": 'application/json; charset=UTF-8'};
      final response = await http.get(Uri.parse(url+userId),headers: headers);
      if (response.statusCode == 200 &&
          response.body.contains("Store Manager Found!")) {
        final responseBody = response.body;
        final decodeResponse = jsonDecode(responseBody);
        storeManagerById = StoreManagerById.fromJson(decodeResponse);
             return storeManagerById;
      }
      else {
        print("Profile Store Manager not found");
      }
    }catch(e){
      print("the error is :$e");
    }
    return storeManagerById;
  }

  Future<ResetPasswordModel> requestResetPassword(context) async {

    SharedPreferencesData sharedPreferencesData=SharedPreferencesData();
    final data= await sharedPreferencesData.getFirebaseData();
    String id=data['data']['storeId'].toString();
    print('id $id');

    try {
      String url = ApiUrl.resetPasswordUrl+id;
      final headers = {"Content-Type": 'application/json; charset=UTF-8'};
      final response = await http.get(Uri.parse(url),headers: headers);
      if (response.statusCode == 200 &&
          response.body.contains("Found")) {
        final responseBody = response.body;
        print("reset body is $responseBody");
        final decodeResponse = jsonDecode(responseBody);
        resetPasswordModel = ResetPasswordModel.fromJson(decodeResponse);
        print("reset decode is $decodeResponse");
        return resetPasswordModel;
      }
      else {
        print("user not found");
      }
    }catch(e){
      print("the error is :$e");
    }
    return resetPasswordModel;
  }
}