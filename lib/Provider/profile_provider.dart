import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:haji_baba_manager/Model/reset_password_model.dart';
import 'package:haji_baba_manager/Model/store_manager_by_id.dart';
import 'package:haji_baba_manager/Widgets/connection_checker_dialog.dart';
import 'package:haji_baba_manager/services/connection_checker.dart';
import 'package:haji_baba_manager/services/profile_data_api.dart';
import 'package:haji_baba_manager/services/shared_preferences.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:overlay_support/overlay_support.dart';
class ProfileProvider extends ChangeNotifier{

 ProfileApi profileApi=ProfileApi();
 Map profileData={};
 int isLoading=0;

 String email;
 bool connection=false;


 Future<void> userEmail()async{
   SharedPreferencesData sharedPreferencesData=SharedPreferencesData();
   final data= await sharedPreferencesData.getFirebaseData();
   email=data['data']['email'];
 }


 loading(int load){
   isLoading=load;
   notifyListeners();
 }
 //Connection checker is the instance of connection checker class
 // in which we are listening that the internet in connected or not
 //ConnectionCheckerDialog is the instance of ConnectionCheckerDialog class
 // if the network is not connected the alert dialog will be popup

 ConnectionChecker connectionChecker=ConnectionChecker();
 ConnectionCheckerDialog connectionCheckerDialog=ConnectionCheckerDialog();

 getProfileData(context)async{
   bool connection=await connectionChecker.checkNetwork();
   if(connection==true){
     if(profileData.isEmpty){
       StoreManagerById storeManagerById =await profileApi.getStoreManagerById(context);
       profileData=storeManagerById.data.toJson();
       //    ==null?null:storeManagerById.data.toJson();
       notifyListeners();
       return storeManagerById;
     }else{
       profileData = profileData;
       notifyListeners();
       return profileData;
     }
   }
   else{
     connectionCheckerDialog.showConnectionDialog(context);
   }

 }

 restPassword(context)async{
   bool connection=await connectionChecker.checkNetwork();
   if(connection==true){
     ResetPasswordModel resetPasswordModel =await profileApi.requestResetPassword(context);
     notifyListeners();
     return resetPasswordModel;
   }
   else{
     connectionCheckerDialog.showConnectionDialog(context);
   }


 }


}