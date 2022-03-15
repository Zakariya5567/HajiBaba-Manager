import 'dart:convert';
import 'package:haji_baba_manager/Model/firebase_model.dart';
import 'package:haji_baba_manager/Model/store_manager_by_id.dart';
import 'package:haji_baba_manager/Utils/images.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesData {

  // login bool is use for login when the login is true the user will be login
  // if false the user is logout
  // get data use to get the id of the user
  // get firebase data is to get the data of the user
  // clear data is use to clear the data which is store in shared pref
  // normally used for logout

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