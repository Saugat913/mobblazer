import 'dart:convert';

class BusinessData {
  BusinessData({
    required this.status,
    required this.data,
    required this.message,
  });

  int status;
  List<Datum> data;
  String message;

  factory BusinessData.fromJson(Map<String, dynamic> json) => BusinessData(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class Datum {
  Datum({
    required this.id,
    required this.businessName,
    required this.contactName,
    required this.contactNumber,
    required this.status,
    required this.websiteUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    required this.user,
  });

  int id;
  String businessName;
  String contactName;
  String contactNumber;
  bool status;
  String websiteUrl;
  DateTime createdAt;
  DateTime updatedAt;
  int userId;
  User user;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        businessName: json["businessName"],
        contactName: json["contactName"],
        contactNumber: json["contactNumber"],
        status: json["status"],
        websiteUrl: json["websiteUrl"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        userId: json["userId"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "businessName": businessName,
        "contactName": contactName,
        "contactNumber": contactNumber,
        "status": status,
        "websiteUrl": websiteUrl,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "userId": userId,
        "user": user.toJson(),
      };
}

class User {
  User({
    required this.email,
  });

  String email;

  factory User.fromJson(Map<String, dynamic> json) => User(
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
      };
}
