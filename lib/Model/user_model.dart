
class UserModel {
  UserModel({
    this.statusCode,
    this.message,
    this.status,
    this.data,
  });
  int statusCode;
  String message;
  String status;
  Data data;


  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    statusCode: json["statusCode"],
    message: json["message"],
    status: json["status"],
    data: Data.fromJson(json["data"]
    ),
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
    this.id,
    this.name,
    this.deviceId,
    this.phoneNumber,
    this.storeName,
    this.storeAddress,
  });

  int id;
  String name;
  String deviceId;
  String phoneNumber;
  String storeName;
  String storeAddress;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    deviceId: json["deviceId"],
    phoneNumber: json["phoneNumber"],
    storeName: json["storeName"],
    storeAddress: json["storeAddress"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "deviceId": deviceId,
    "phoneNumber": phoneNumber,
    "storeName": storeName,
    "storeAddress": storeAddress,
  };
}
