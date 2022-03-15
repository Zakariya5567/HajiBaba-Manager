// To parse this JSON data, do
//
//     final orderDetailModel = orderDetailModelFromJson(jsonString);

import 'dart:convert';

OrderDetailModel orderDetailModelFromJson(String str) => OrderDetailModel.fromJson(json.decode(str));

String orderDetailModelToJson(OrderDetailModel data) => json.encode(data.toJson());

class OrderDetailModel {
  OrderDetailModel({
    this.statusCode,
    this.message,
    this.status,
    this.data,
  });

  int statusCode;
  String message;
  String status;
  Data data;

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) => OrderDetailModel(
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
    this.refNumber,
    this.grandTotal,
    this.orderStatus,
    this.orderTime,
    this.paymentMethod,
    this.total,
    this.discount,
    this.discontInPercent,
    this.customerName,
    this.customerPhone,
    this.customerEmail,
    this.street,
    this.code,
    this.city,
    this.country,
    this.address,
    this.addressType,
    this.productsList,
  });

  String id;
  String refNumber;
  double grandTotal;
  String orderStatus;
  DateTime orderTime;
  String paymentMethod;
  double total;
  double discount;
  double discontInPercent;
  String customerName;
  String customerPhone;
  String customerEmail;
  String street;
  String code;
  String city;
  String country;
  String address;
  String addressType;
  List<ProductsList> productsList;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    refNumber: json["refNumber"],
    grandTotal: json["grandTotal"],
    orderStatus: json["orderStatus"],
    orderTime: DateTime.parse(json["orderTime"]),
    paymentMethod: json["paymentMethod"],
    total: json["total"],
    discount: json["discount"],
    discontInPercent: json["discontInPercent"].toDouble(),
    customerName: json["customerName"],
    customerPhone: json["customerPhone"],
    customerEmail: json["customerEmail"],
    street: json["street"],
    code: json["code"],
    city: json["city"],
    country: json["country"],
    address: json["address"],
    addressType: json["addressType"],
    productsList: List<ProductsList>.from(json["productsList"].map((x) => ProductsList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "refNumber": refNumber,
    "grandTotal": grandTotal,
    "orderStatus": orderStatus,
    "orderTime": orderTime.toIso8601String(),
    "paymentMethod": paymentMethod,
    "total": total,
    "discount": discount,
    "discontInPercent": discontInPercent,
    "customerName": customerName,
    "customerPhone": customerPhone,
    "customerEmail": customerEmail,
    "street": street,
    "code": code,
    "city": city,
    "country": country,
    "address": address,
    "addressType": addressType,
    "productsList": List<dynamic>.from(productsList.map((x) => x.toJson())),
  };
}

class ProductsList {
  ProductsList({
    this.prodcutImg,
    this.productTitle,
    this.isVariableProduct,
    this.quanitty,
    this.price,
    this.expiryDiscountApplied,
    this.bulkDiscountApplied,
    this.discountedPrice,
    this.discountInPercent,
  });

  String prodcutImg;
  String productTitle;
  bool isVariableProduct;
  int quanitty;
  double price;
  bool expiryDiscountApplied;
  bool bulkDiscountApplied;
  double discountedPrice;
  double discountInPercent;

  factory ProductsList.fromJson(Map<String, dynamic> json) => ProductsList(
    prodcutImg: json["prodcutImg"],
    productTitle: json["productTitle"],
    isVariableProduct: json["isVariableProduct"],
    quanitty: json["quanitty"],
    price: json["price"],
    expiryDiscountApplied: json["expiryDiscountApplied"],
    bulkDiscountApplied: json["bulkDiscountApplied"],
    discountedPrice: json["discountedPrice"],
    discountInPercent: json["discountInPercent"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "prodcutImg": prodcutImg,
    "productTitle": productTitle,
    "isVariableProduct": isVariableProduct,
    "quanitty": quanitty,
    "price": price,
    "expiryDiscountApplied": expiryDiscountApplied,
    "bulkDiscountApplied": bulkDiscountApplied,
    "discountedPrice": discountedPrice,
    "discountInPercent": discountInPercent,
  };
}
