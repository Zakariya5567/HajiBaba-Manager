import 'package:flutter/foundation.dart';
import 'package:haji_baba_manager/Model/store_manager_by_id.dart';
import 'package:haji_baba_manager/services/profile_data_api.dart';
class ManagerProfileProvider extends ChangeNotifier{
  //
  // ProfileApi profileApi=ProfileApi();
  // Map profileData={};
  //
  // bool connection=false;
  //
  // internetChecker(){
  //   notifyListeners();
  //   InternetConnectionChecker().onStatusChange.listen((status) {
  //     switch(status) {
  //       case InternetConnectionStatus.connected:
  //         connection=true;
  //         notifyListeners();
  //         print('connected');
  //         showSimpleNotification(
  //             const Text('Internet Connected',style: TextStyle(
  //                 color: Colors.white,fontSize: 36
  //             ),),
  //             background: Colors.green
  //         );
  //         break;
  //       case InternetConnectionStatus.disconnected:
  //         connection=false;
  //         notifyListeners();
  //         print('disconnected');
  //         showSimpleNotification(
  //             const Text('No Internet Connection',style: TextStyle(
  //               color: Colors.white,fontSize: 36,
  //             ),),
  //             background:Colors.red
  //         );
  //         break;
  //     }
  //   });
  // }
  //
  // int isLoading=0;
  //
  // loading(int load){
  //   isLoading=load;
  //   notifyListeners();
  // }

}