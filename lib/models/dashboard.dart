

import 'dart:convert';

Dashboardmodel dashboardmodelFromJson(String str) => Dashboardmodel.fromJson(json.decode(str));

String dashboardmodelToJson(Dashboardmodel data) => json.encode(data.toJson());

class Dashboardmodel {
    Dashboardmodel({
        required this.status,
        required this.data,
    });

    int status;
    Data data;

    factory Dashboardmodel.fromJson(Map<String, dynamic> json) => Dashboardmodel(
        status: json["status"],
        data: json["data"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
    };
}

class Data {
    Data({
        required this.customer,
        required this.location,
        required this.business,
    });

    String customer;
    String location;
    String business;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        customer: json["customer"],
        location: json["location"],
        business: json["business"],
    );

    Map<String, dynamic> toJson() => {
        "customer": customer,
        "location": location,
        "business": business,
    };
}
