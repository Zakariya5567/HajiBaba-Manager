import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';

class ConnectionChecker{

  // the connection class is to check the connection when the user
  // want to access data from the api

  Future<bool> checkNetwork() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network,
      // make sure there is actually a net connection.
      if (await DataConnectionChecker().hasConnection) {
        // Mobile data detected & internet connection confirmed.
        print("mobile Connected");
        return true;
      } else {
        // Mobile data detected but no internet connection found.
        print("mobile not Connected");
        return false;
      }
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a WIFI network, make sure there is actually a net connection.
      if (await DataConnectionChecker().hasConnection) {
        // Wifi detected & internet connection confirmed.
        print("wifi Connected");
        return true;
      } else {
        // Wifi detected but no internet connection found.
        print("wifi Connected");
        return false;
      }
    } else {
      // Neither mobile data or WIFI detected, not internet connection found.
      print("not Connected");
      return false;
    }
  }

}