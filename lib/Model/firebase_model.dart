class FirebaseModel {
  FirebaseModel({
    this.statusCode,
    this.message,
    this.status,
    this.data,
  });

  int statusCode;
  String message;
  String status;
  Data data;

  factory FirebaseModel.fromJson(Map<String, dynamic> json) => FirebaseModel(
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
  int storeId;
  int roleId;
  DateTime registerationDate;
  String firebaseDeviceId;
  dynamic role;
  dynamic store;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    password: json["password"],
    phoneNumber: json["phoneNumber"],
    isDeleted: json["isDeleted"],
    isEnable: json["isEnable"],
    isStoreUser: json["isStoreUser"],
    storeId: json["storeId"],
    roleId: json["roleId"],
    registerationDate: DateTime.parse(json["registerationDate"]),
    firebaseDeviceId: json["firebaseDeviceId"],
    role: json["role"],
    store: json["store"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "password": password,
    "phoneNumber": phoneNumber,
    "isDeleted": isDeleted,
    "isEnable": isEnable,
    "isStoreUser": isStoreUser,
    "storeId": storeId,
    "roleId": roleId,
    "registerationDate": registerationDate.toIso8601String(),
    "firebaseDeviceId": firebaseDeviceId,
    "role": role,
    "store": store,
  };
}
