class StoreManagerById {
  StoreManagerById({
    this.statusCode,
    this.message,
    this.status,
    this.data,
  });

  int statusCode;
  String message;
  String status;
  Data data;

  factory StoreManagerById.fromJson(Map<String, dynamic> json) => StoreManagerById(
    statusCode: json["statusCode"] ,
    message: json["message"] ,
    status: json["status"] ,
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
    this.id,
    this.name,
    this.deviceId,
    this.storePhoneNumber,
    this.storeExtensionNumber,
    this.storeName,
    this.storeAddress,
    this.managerRole,
  });

  int id;
  String name;
  String deviceId;
  String storePhoneNumber;
  String storeExtensionNumber;
  String storeName;
  String storeAddress;
  String managerRole;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    deviceId: json["deviceId"],
    storePhoneNumber: json["storePhoneNumber"],
    storeExtensionNumber: json["storeExtensionNumber"] == null ? null : json["storeExtensionNumber"],
    storeName: json["storeName"],
    storeAddress: json["storeAddress"],
    managerRole: json["managerRole"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "deviceId": deviceId,
    "storePhoneNumber": storePhoneNumber,
    "storeExtensionNumber": storeExtensionNumber == null ? null : storeExtensionNumber,
    "storeName": storeName,
    "storeAddress": storeAddress,
    "managerRole": managerRole,
  };
}
