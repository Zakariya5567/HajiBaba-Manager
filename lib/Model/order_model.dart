// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

OrderModel orderModelFromJson(String str) => OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  OrderModel({
    this.data,
    this.totalItems,
    this.currentPage,
    this.pageSize,
    this.totalPages,
  });

  List<Datum> data;
  int totalItems;
  int currentPage;
  int pageSize;
  int totalPages;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    totalItems: json["totalItems"] == null ? null : json["totalItems"],
    currentPage: json["currentPage"] == null ? null : json["currentPage"],
    pageSize: json["pageSize"] == null ? null : json["pageSize"],
    totalPages: json["totalPages"] == null ? null : json["totalPages"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    "totalItems": totalItems == null ? null : totalItems,
    "currentPage": currentPage == null ? null : currentPage,
    "pageSize": pageSize == null ? null : pageSize,
    "totalPages": totalPages == null ? null : totalPages,
  };
}

class Datum {
  Datum({
    this.id,
    this.discontInPercent,
    this.discount,
    this.grandTotal,
    this.orderTime,
    this.refNumber,
    this.name,
    this.storeOrderNumber,
    this.total,
    this.items,
  });

  String id;
  double discontInPercent;
  double discount;
  double grandTotal;
  DateTime orderTime;
  RefNumber refNumber;
  Name name;
  int storeOrderNumber;
  double total;
  int items;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    discontInPercent: json["discontInPercent"] == null ? null : json["discontInPercent"].toDouble(),
    discount: json["discount"] == null ? null : json["discount"].toDouble(),
    grandTotal: json["grandTotal"] == null ? null : json["grandTotal"].toDouble(),
    orderTime: json["orderTime"] == null ? null : DateTime.parse(json["orderTime"]),
    refNumber: json["refNumber"] == null ? null : refNumberValues.map[json["refNumber"]],
    name: json["name"] == null ? null : nameValues.map[json["name"]],
    storeOrderNumber: json["storeOrderNumber"] == null ? null : json["storeOrderNumber"],
    total: json["total"] == null ? null : json["total"].toDouble(),
    items: json["items"] == null ? null : json["items"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "discontInPercent": discontInPercent == null ? null : discontInPercent,
    "discount": discount == null ? null : discount,
    "grandTotal": grandTotal == null ? null : grandTotal,
    "orderTime": orderTime == null ? null : orderTime.toIso8601String(),
    "refNumber": refNumber == null ? null : refNumberValues.reverse[refNumber],
    "name": name == null ? null : nameValues.reverse[name],
    "storeOrderNumber": storeOrderNumber == null ? null : storeOrderNumber,
    "total": total == null ? null : total,
    "items": items == null ? null : items,
  };
}

enum Name { PENDING, PROCESSING, COMPLETED, READY_FOR_COLLECTION }

final nameValues = EnumValues({
  "Completed": Name.COMPLETED,
  "Pending": Name.PENDING,
  "Processing": Name.PROCESSING,
  "Ready For Collection": Name.READY_FOR_COLLECTION
});

enum RefNumber { HB_1001 }

final refNumberValues = EnumValues({
  "HB-1001": RefNumber.HB_1001
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}











// // To parse this JSON data, do
// //
// //     final orderModel = orderModelFromJson(jsonString);
//
// import 'dart:convert';
//
// OrderModel orderModelFromJson(String str) => OrderModel.fromJson(json.decode(str));
//
// String orderModelToJson(OrderModel data) => json.encode(data.toJson());
//
// class OrderModel {
//   OrderModel({
//     this.data,
//     this.totalItems,
//     this.currentPage,
//     this.pageSize,
//     this.totalPages,
//   });
//
//   List<Datum> data;
//   int totalItems;
//   int currentPage;
//   int pageSize;
//   int totalPages;
//
//   factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
//     data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//     totalItems: json["totalItems"],
//     currentPage: json["currentPage"],
//     pageSize: json["pageSize"],
//     totalPages: json["totalPages"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "data": List<dynamic>.from(data.map((x) => x.toJson())),
//     "totalItems": totalItems,
//     "currentPage": currentPage,
//     "pageSize": pageSize,
//     "totalPages": totalPages,
//   };
// }
//
// class Datum {
//   Datum({
//     this.id,
//     this.discontInPercent,
//     this.discount,
//     this.grandTotal,
//     this.orderTime,
//     this.refNumber,
//     this.name,
//     this.storeOrderNumber,
//     this.total,
//     this.items,
//   });
//
//   String id;
//   double discontInPercent;
//   double discount;
//   double grandTotal;
//   DateTime orderTime;
//   RefNumber refNumber;
//   Name name;
//   int storeOrderNumber;
//   double total;
//   int items;
//
//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//     id: json["id"],
//     discontInPercent: json["discontInPercent"].toDouble(),
//     discount: json["discount"],
//     grandTotal: json["grandTotal"].toDouble(),
//     orderTime: DateTime.parse(json["orderTime"]),
//     refNumber: refNumberValues.map[json["refNumber"]],
//     name: nameValues.map[json["name"]],
//     storeOrderNumber: json["storeOrderNumber"],
//     total: json["total"],
//     items: json["items"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "discontInPercent": discontInPercent,
//     "discount": discount,
//     "grandTotal": grandTotal,
//     "orderTime": orderTime.toIso8601String(),
//     "refNumber": refNumberValues.reverse[refNumber],
//     "name": nameValues.reverse[name],
//     "storeOrderNumber": storeOrderNumber,
//     "total": total,
//     "items": items,
//   };
// }
//
// enum Name { PENDING, COMPLETED, PROCESSING }
//
// final nameValues = EnumValues({
//   "Completed": Name.COMPLETED,
//   "Pending": Name.PENDING,
//   "Processing": Name.PROCESSING
// });
//
// enum RefNumber { HB_1001 }
//
// final refNumberValues = EnumValues({
//   "HB-1001": RefNumber.HB_1001
// });
//
// class EnumValues<T> {
//   Map<String, T> map;
//   Map<T, String> reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     if (reverseMap == null) {
//       reverseMap = map.map((k, v) => new MapEntry(v, k));
//     }
//     return reverseMap;
//   }
// }
