

import 'dart:convert';

LocationByBusiness locationByBusinessFromJson(String str) => LocationByBusiness.fromJson(json.decode(str));

String locationByBusinessToJson(LocationByBusiness data) => json.encode(data.toJson());

class LocationByBusiness {
    int status;
    List<Datum> data;

    LocationByBusiness({
        required this.status,
        required this.data,
    });

    factory LocationByBusiness.fromJson(Map<String, dynamic> json) => LocationByBusiness(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    int id;
    String locationName;
    String address;
    String phoneNumber;
    String reviewUrl;
    String subject;
    String emailBody;
    String textTemplate;
    DateTime createdAt;
    DateTime updatedAt;
    int businessId;
    List<UserLocation> userLocations;
    Business business;

    Datum({
        required this.id,
        required this.locationName,
        required this.address,
        required this.phoneNumber,
        required this.reviewUrl,
        required this.subject,
        required this.emailBody,
        required this.textTemplate,
        required this.createdAt,
        required this.updatedAt,
        required this.businessId,
        required this.userLocations,
        required this.business,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        locationName: json["locationName"],
        address: json["address"],
        phoneNumber: json["phoneNumber"],
        reviewUrl: json["reviewUrl"],
        subject: json["subject"],
        emailBody: json["emailBody"],
        textTemplate: json["textTemplate"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        businessId: json["businessId"],
        userLocations: List<UserLocation>.from(json["user_locations"].map((x) => UserLocation.fromJson(x))),
        business: Business.fromJson(json["business"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "locationName": locationName,
        "address": address,
        "phoneNumber": phoneNumber,
        "reviewUrl": reviewUrl,
        "subject": subject,
        "emailBody": emailBody,
        "textTemplate": textTemplate,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "businessId": businessId,
        "user_locations": List<dynamic>.from(userLocations.map((x) => x.toJson())),
        "business": business.toJson(),
    };
}

class Business {
    int id;
    String businessName;
    String contactName;
    String contactNumber;
    bool status;
    String websiteUrl;
    DateTime createdAt;
    DateTime updatedAt;
    int userId;

    Business({
        required this.id,
        required this.businessName,
        required this.contactName,
        required this.contactNumber,
        required this.status,
        required this.websiteUrl,
        required this.createdAt,
        required this.updatedAt,
        required this.userId,
    });

    factory Business.fromJson(Map<String, dynamic> json) => Business(
        id: json["id"],
        businessName: json["businessName"],
        contactName: json["contactName"],
        contactNumber: json["contactNumber"],
        status: json["status"],
        websiteUrl: json["websiteUrl"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        userId: json["userId"],
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
    };
}

class UserLocation {
    int id;

    UserLocation({
        required this.id,
    });

    factory UserLocation.fromJson(Map<String, dynamic> json) => UserLocation(
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
    };
}
