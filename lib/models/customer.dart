
import 'dart:convert';

CustomerData customerDataFromJson(String str) => CustomerData.fromJson(json.decode(str));

String customerDataToJson(CustomerData data) => json.encode(data.toJson());

class CustomerData {
    int status;
    List<Datum> data;

    CustomerData({
        required this.status,
        required this.data,
    });

    factory CustomerData.fromJson(Map<String, dynamic> json) => CustomerData(
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
    String firstName;
    String lastName;
    String email;
    String password;
    bool status;
    String userType;
    String phoneNo;
    DateTime createdAt;
    DateTime updatedAt;
    List<UserLocation> userLocations;

    Datum({
        required this.id,
        required this.firstName,
        required this.lastName,
        required this.email,
        required this.password,
        required this.status,
        required this.userType,
        required this.phoneNo,
        required this.createdAt,
        required this.updatedAt,
        required this.userLocations,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        password: json["password"],
        status: json["status"],
        userType: json["userType"],
        phoneNo: json["phoneNo"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        userLocations: List<UserLocation>.from(json["user_locations"].map((x) => UserLocation.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "password": password,
        "status": status,
        "userType": userType,
        "phoneNo": phoneNo,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "user_locations": List<dynamic>.from(userLocations.map((x) => x.toJson())),
    };
}

class UserLocation {
    int id;
    bool? review;
    DateTime createdAt;
    DateTime updatedAt;
    int userId;
    int businessLocationId;

    UserLocation({
        required this.id,
        this.review,
        required this.createdAt,
        required this.updatedAt,
        required this.userId,
        required this.businessLocationId,
    });

    factory UserLocation.fromJson(Map<String, dynamic> json) => UserLocation(
        id: json["id"],
        review: json["review"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        userId: json["userId"],
        businessLocationId: json["businessLocationId"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "review": review,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "userId": userId,
        "businessLocationId": businessLocationId,
    };
}
