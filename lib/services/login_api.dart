import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:haji_baba_manager/Model/firebase_model.dart';
import 'package:haji_baba_manager/Model/update_order_status_model.dart';
import 'package:haji_baba_manager/Model/update_physical_address_model.dart';
import 'package:haji_baba_manager/Model/user_model.dart';
import 'package:haji_baba_manager/Utils/api_url.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginApi{
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  UserModel userData;
  FirebaseModel firebaseData;
  UpdatePhysicalAddressModel updatePhysicalAddressModel;
  bool isAndroid;
  int userid;


 Future physicalAddress()async{

    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) { // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      var deviceId=iosDeviceInfo.identifierForVendor;
      isAndroid=false;
     return deviceId; // unique ID on iOS
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      var deviceId=androidDeviceInfo.androidId;
      isAndroid=true;
     return deviceId; // unique ID on Android
    }
  }


  Future<UpdatePhysicalAddressModel> updatePhysicalAddress(int id)async{
   dynamic devicePhysicalAddress=await physicalAddress();

    try {
      String url = ApiUrl.updatePhysicalAddressUrl;
      final data = {
        "id": id,
        "devicePhysicalAddress": devicePhysicalAddress,
        "isAndroid": isAndroid,
      };
      final headers = {"Content-Type": 'application/json; charset=UTF-8'};
      final body = jsonEncode(data);
      var response = await http.post(
          Uri.parse(url), body: body, headers: headers);

      if (response.statusCode == 200) {
        final responseBody = response.body;
        final decodeResponse = jsonDecode(responseBody);
        updatePhysicalAddressModel = UpdatePhysicalAddressModel.fromJson(decodeResponse);
      }
      else{
        print("device physical address not found");
      }
    }catch(e){
      print("the error is :$e");
    }
  }

  Future<FirebaseModel> updateStoreManagerFirebaseId(int userId, String deviceId)async{
    try {
      String url = ApiUrl.updateStoreManagerFirebaseId;
      final data = {'id': userId, 'firebaseDeviceId': deviceId};
      final headers = {"Content-Type": 'application/json; charset=UTF-8'};
      final body = jsonEncode(data);
      var response = await http.post(
          Uri.parse(url), body: body, headers: headers);

      if (response.statusCode == 200) {
        final responseBody = response.body;
        final decodeResponse = jsonDecode(responseBody);

        firebaseData = FirebaseModel.fromJson(decodeResponse);
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setInt('id', userId);

        SharedPreferences preferences=await SharedPreferences.getInstance();
        preferences.setBool("login",true);

        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        Map json = jsonDecode(responseBody);
        String user = jsonEncode(FirebaseModel.fromJson(json));
        sharedPreferences.setString('firebaseData', user);
        return firebaseData;
      }
      else{
        print("Store manager not found");
      }
    }catch(e){
      print("the error is :$e");
    }
  }

  Future<UserModel> storeManagerLogin(
      String email, String password, BuildContext context) async {
    try {
      String url = ApiUrl.storeMangerLogin;
      final data = {'email': email, 'password': password};
      final headers = {"Content-Type": 'application/json; charset=UTF-8'};
      final body = jsonEncode(data);
      final response = await http.post(Uri.parse(url), headers: headers, body: body,
      );

      if (response.statusCode == 200 &&
          response.body.contains("Store Manager Found!")) {
        final responseBody = response.body;
        final decodeResponse = jsonDecode(responseBody);
        userData = UserModel.fromJson(decodeResponse);
         int id=userData.data.id;

         // to update the firebase token use this method

            await Firebase.initializeApp();
            FirebaseMessaging.instance.getToken().then((value) async {
              String token = value;
             //calling method to update the firebase token
              updateStoreManagerFirebaseId(id, token);

            });

            //to update the device physical address use this function

            updatePhysicalAddress(id);

            Navigator.of(context).pushNamed('/dashBoardScreen');

        return userData;
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Store Manager not found",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black,
            fontSize: 30,
            ),),
           backgroundColor: Colors.grey,
           duration: Duration(seconds: 1),


        ));

      }
    }catch(e){
      print("the error is : $e");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Error!",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black,
            fontSize: 30,
          ),),
        backgroundColor: Colors.grey,
        duration: Duration(seconds: 1),


      ));
    }
    return userData;
  }


}