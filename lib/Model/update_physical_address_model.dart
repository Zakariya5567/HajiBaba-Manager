// To parse this JSON data, do
//
//     final updatePhysicalAddressModel = updatePhysicalAddressModelFromJson(jsonString);

import 'dart:convert';

UpdatePhysicalAddressModel updatePhysicalAddressModelFromJson(String str) => UpdatePhysicalAddressModel.fromJson(json.decode(str));

String updatePhysicalAddressModelToJson(UpdatePhysicalAddressModel data) => json.encode(data.toJson());

class UpdatePhysicalAddressModel {
  UpdatePhysicalAddressModel({
    this.statusCode,
    this.message,
    this.status,
    this.data,
  });

  int statusCode;
  String message;
  String status;
  Data data;

  factory UpdatePhysicalAddressModel.fromJson(Map<String, dynamic> json) => UpdatePhysicalAddressModel(
    statusCode: json["statusCode"] == null ? null : json["statusCode"],
    message: json["message"] == null ? null : json["message"],
    status: json["status"] == null ? null : json["status"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode == null ? null : statusCode,
    "message": message == null ? null : message,
    "status": status == null ? null : status,
    "data": data == null ? null : data.toJson(),
  };
}

class Data {
  Data({
    this.id,
    this.name,
    this.email,
    this.password,
    this.phoneNumber,
    this.isDeleted,
    this.isEnable,
    this.isStoreUser,
    this.storeId,
    this.roleId,
    this.registerationDate,
    this.firebaseDeviceId,
    this.isAndroid,
    this.devicePhysicalAddress,
    this.role,
    this.store,
  });

  int id;
  String name;
  String email;
  String password;
  String phoneNumber;
  bool isDeleted;
  bool isEnable;
  bool isStoreUser;
  dynamic storeId;
  int roleId;
  DateTime registerationDate;
  dynamic firebaseDeviceId;
  bool isAndroid;
  String devicePhysicalAddress;
  dynamic role;
  dynamic store;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    email: json["email"] == null ? null : json["email"],
    password: json["password"] == null ? null : json["password"],
    phoneNumber: json["phoneNumber"] == null ? null : json["phoneNumber"],
    isDeleted: json["isDeleted"] == null ? null : json["isDeleted"],
    isEnable: json["isEnable"] == null ? null : json["isEnable"],
    isStoreUser: json["isStoreUser"] == null ? null : json["isStoreUser"],
    storeId: json["storeId"],
    roleId: json["roleId"] == null ? null : json["roleId"],
    registerationDate: json["registerationDate"] == null ? null : DateTime.parse(json["registerationDate"]),
    firebaseDeviceId: json["firebaseDeviceId"],
    isAndroid: json["isAndroid"] == null ? null : json["isAndroid"],
    devicePhysicalAddress: json["devicePhysicalAddress"] == null ? null : json["devicePhysicalAddress"],
    role: json["role"],
    store: json["store"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "email": email == null ? null : email,
    "password": password == null ? null : password,
    "phoneNumber": phoneNumber == null ? null : phoneNumber,
    "isDeleted": isDeleted == null ? null : isDeleted,
    "isEnable": isEnable == null ? null : isEnable,
    "isStoreUser": isStoreUser == null ? null : isStoreUser,
    "storeId": storeId,
    "roleId": roleId == null ? null : roleId,
    "registerationDate": registerationDate == null ? null : registerationDate.toIso8601String(),
    "firebaseDeviceId": firebaseDeviceId,
    "isAndroid": isAndroid == null ? null : isAndroid,
    "devicePhysicalAddress": devicePhysicalAddress == null ? null : devicePhysicalAddress,
    "role": role,
    "store": store,
  };
}
