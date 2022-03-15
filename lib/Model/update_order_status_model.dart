// To parse this JSON data, do
//
//     final updateStatusModel = updateStatusModelFromJson(jsonString);

import 'dart:convert';

UpdateStatusModel updateStatusModelFromJson(String str) => UpdateStatusModel.fromJson(json.decode(str));

String updateStatusModelToJson(UpdateStatusModel data) => json.encode(data.toJson());

class UpdateStatusModel {
  UpdateStatusModel({
    this.statusCode,
    this.message,
    this.status,
    this.data,
  });

  int statusCode;
  String message;
  String status;
  dynamic data;

  factory UpdateStatusModel.fromJson(Map<String, dynamic> json) => UpdateStatusModel(
    statusCode: json["statusCode"],
    message: json["message"],
    status: json["status"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "message": message,
    "status": status,
    "data": data,
  };
}
