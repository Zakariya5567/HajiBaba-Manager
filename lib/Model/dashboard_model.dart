// To parse this JSON data, do
//
//     final dashboardModel = dashboardModelFromJson(jsonString);

import 'dart:convert';

DashboardModel dashboardModelFromJson(String str) => DashboardModel.fromJson(json.decode(str));

String dashboardModelToJson(DashboardModel data) => json.encode(data.toJson());

class DashboardModel {
  DashboardModel({
    this.statusCode,
    this.message,
    this.status,
    this.data,
  });

  int statusCode;
  String message;
  String status;
  Data data;

  factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
    statusCode: json["statusCode"],
    message: json["message"],
    status: json["status"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "message": message,
    "status": status,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.allOrders,
    this.allPendingOrders,
    this.allProcessingOrders,
    this.allReadyToCollectOrders,
    this.allCompletedOrders,
    this.allRefundedOrders,
    this.todayOrders,
  });

  int allOrders;
  int allPendingOrders;
  int allProcessingOrders;
  int allReadyToCollectOrders;
  int allCompletedOrders;
  int allRefundedOrders;
  List<dynamic> todayOrders;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    allOrders: json["allOrders"],
    allPendingOrders: json["allPendingOrders"],
    allProcessingOrders: json["allProcessingOrders"],
    allReadyToCollectOrders: json["allReadyToCollectOrders"],
    allCompletedOrders: json["allCompletedOrders"],
    allRefundedOrders: json["allRefundedOrders"],
    todayOrders: List<dynamic>.from(json["todayOrders"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "allOrders": allOrders,
    "allPendingOrders": allPendingOrders,
    "allProcessingOrders": allProcessingOrders,
    "allReadyToCollectOrders": allReadyToCollectOrders,
    "allCompletedOrders": allCompletedOrders,
    "allRefundedOrders": allRefundedOrders,
    "todayOrders": List<dynamic>.from(todayOrders.map((x) => x)),
  };
}
