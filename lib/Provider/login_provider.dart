import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:haji_baba_manager/Model/user_model.dart';
import 'package:haji_baba_manager/Widgets/connection_checker_dialog.dart';
import 'package:haji_baba_manager/services/connection_checker.dart';
import 'package:haji_baba_manager/services/login_api.dart';

class LoginProvider extends ChangeNotifier  {

    UserModel userData=UserModel();

    int loading=0;

    loadingData(int number){
        notifyListeners();
        loading=number;

    }

    //Connection checker is the instance of connection checker class
    // in which we are listening that the internet in connected or not
    //ConnectionCheckerDialog is the instance of ConnectionCheckerDialog class
    // if the network is not connected the alert dialog will be popup

    ConnectionChecker connectionChecker=ConnectionChecker();
    ConnectionCheckerDialog connectionCheckerDialog=ConnectionCheckerDialog();

    postLogin(String email ,String password,BuildContext context) async {
        bool connection=await connectionChecker.checkNetwork();
        if(connection==true){
            userData =await LoginApi().storeManagerLogin(email, password, context);
            notifyListeners();
            return userData;
        }
        else{
            connectionCheckerDialog.showConnectionDialog(context);
        }


    }
}
