import 'dart:convert';
import 'package:haji_baba_manager/Model/firebase_model.dart';
import 'package:haji_baba_manager/Model/store_manager_by_id.dart';
import 'package:haji_baba_manager/Utils/images.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesData {

  Future<bool> loginBool()async{
    SharedPreferences sharedPreferences= await SharedPreferences.getInstance();
    bool login = sharedPreferences.getBool('login');
    return login;

  }

  Future<int> getId()async{
    SharedPreferences sharedPreferences= await SharedPreferences.getInstance();
    int id = sharedPreferences.getInt('id');
    return id;
  }

  getFirebaseData()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map json = jsonDecode(pref.getString('firebaseData'));
    var user = FirebaseModel.fromJson(json);
    var  firebaseData=user.toJson();
    return firebaseData;
  }

  void  clearData()async{
    SharedPreferences sharedPreferences= await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    sharedPreferences.setBool("login", false);

  }

}