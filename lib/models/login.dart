

class User {
    User({
        required this.status,
        required this.data,
        required this.message,
    });

    int status;
    Data? data;
    String message;

    factory User.fromJson(Map<String, dynamic> json) => User(
        status: json["status"],
        data: json["status"] ==200?Data.fromJson(json["data"]):null,
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": status != 200 ? null : data!.toJson(),
        "message": message,
    };
}

class Data {
    Data({
        required this.userInfo,
        required this.token,
    });

    UserInfo userInfo;
    String token;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        userInfo: UserInfo.fromJson(json["userInfo"]),
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "userInfo": userInfo.toJson(),
        "token": token,
    };
}

class UserInfo {
    UserInfo({
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
    });

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

    factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
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
    };
}
