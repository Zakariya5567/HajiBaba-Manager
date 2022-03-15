import 'dart:convert';

AllStatusListModel allStatusListModelFromJson(String str) => AllStatusListModel.fromJson(json.decode(str));

String allStatusListModelToJson(AllStatusListModel data) => json.encode(data.toJson());

class AllStatusListModel {
  AllStatusListModel({
    this.statusCode,
    this.message,
    this.status,
    this.data,
  });

  int statusCode;
  String message;
  String status;
  List<Datum> data;

  factory AllStatusListModel.fromJson(Map<String, dynamic> json) => AllStatusListModel(
    statusCode: json["statusCode"],
    message: json["message"],
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "message": message,
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.orderStatusList,
  });

  int id;
  String orderStatusList;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    orderStatusList: json["orderStatusList"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "orderStatusList": orderStatusList,
  };
}
