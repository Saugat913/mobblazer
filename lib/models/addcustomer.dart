import 'dart:convert';

Customer CustomerFromJson(String str) => Customer.fromJson(json.decode(str));

String CustomerToJson(Customer data) => json.encode(data.toJson());

class Customer {
    Customer({
        required this.status,
        required this.data,
        this.message,
    });

    int status;
    Data? data;
    dynamic message;

    factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        status: json["status"],
        data: json["status"]==200?Data.fromJson(json["data"]):null,
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": status==200?data?.toJson():null,
        "message": message,
    };
}

class Data {
    Data({
        required this.id,
        required this.password,
        required this.firstName,
        required this.lastName,
        required this.email,
        required this.phoneNo,
        required this.status,
        required this.userType,
        required this.updatedAt,
        required this.createdAt,
    });

    int id;
    String password;
    String firstName;
    String lastName;
    String email;
    String phoneNo;
    bool status;
    String userType;
    DateTime updatedAt;
    DateTime createdAt;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        password: json["password"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        phoneNo: json["phoneNo"],
        status: json["status"],
        userType: json["userType"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        createdAt: DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "password": password,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phoneNo": phoneNo,
        "status": status,
        "userType": userType,
        "updatedAt": updatedAt.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
    };
}
