import 'dart:convert';
import 'package:mobblazers/models/addcustomer.dart';
import 'package:mobblazers/models/business.dart';
import 'package:mobblazers/models/dashboard.dart';
import 'package:mobblazers/models/location.dart';
import 'package:mobblazers/models/locationbybusiness.dart';
import "package:mobblazers/models/login.dart" as login;
import 'package:http/http.dart' as http;

class RestService {
  static http.Client client = http.Client();

// used for login purpose
  static Future<login.User> logIn(String email, String password) async {
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };
    final body = json.encode(<String, String>{
      'email': email,
      'password': password,
    });
    var response = await client.post(
        Uri.parse("http://103.90.84.130/api/login"),
        body: body,
        headers: headers);
    login.User user = login.User.fromJson(json.decode(response.body));
    return user;
  }

  static Future<Customer> addCustomer(
      String firstName, String lastName, String email, String phoneNo,
      {String authentationCode =
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImN1c3RvbWVyQHlvcG1haWwuY29tIiwidXNlcklkIjo0NCwidHlwZSI6IkNVU1RPTUVSIiwiaWF0IjoxNjgxNzQ5NDU1LCJleHAiOjE2ODE3Njc0NTV9.SFxK1nOH3w3O9P_jkPcONs8bO4rZzvrirUIqaSdV0kk"}) async {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Authorization':
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImN1c3RvbWVyQHlvcG1haWwuY29tIiwidXNlcklkIjo0NCwidHlwZSI6IkNVU1RPTUVSIiwiaWF0IjoxNjgxNjE3OTUyLCJleHAiOjE2ODE2MzU5NTJ9.O7g95U4jFG40R7mr77KDIhdIcS8HkUj9Yi3dR3aWwCw'
    };
    final body = json.encode(<String, String>{
      'password': "test@123",
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "phoneNo": phoneNo,
      "status": "true",
      "userType": "CUSTOMER",
      "locationId": "14"
    });
    var response = await client.post(Uri.parse("http://103.90.84.130/api/user"),
        body: body, headers: headers);
    Customer customer = Customer.fromJson(json.decode(response.body));
    return customer;
  }

  static Future<Dashboardmodel?> getDashBoardData(
      {String authentationCode =
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImN1c3RvbWVyQHlvcG1haWwuY29tIiwidXNlcklkIjo0NCwidHlwZSI6IkNVU1RPTUVSIiwiaWF0IjoxNjgxNzg5NTIxLCJleHAiOjE2ODE4MDc1MjF9.J-CAXcvV3bRlSOy14GS39Wo-sOMGM3j95BB4Dkt_F20"}) async {
    final headers = <String, String>{"Authorization": authentationCode};

    var response = await client.get(
        Uri.parse("http://103.90.84.130/api/user/get-all-stats"),
        headers: headers);

    // why check header because if error it doesnot sent json but html file
    //so we have to check for error instead of parsing json
    if (response.headers["Content-Type"] == "text/html") {
      return null;
    }
    print(response.body.toString());
    Dashboardmodel dashboardmodel =
        Dashboardmodel.fromJson(json.decode(response.body));
    return dashboardmodel;
  }

  static Future<BusinessData> getAllBusinessData(
      {String authentationCode =
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImN1c3RvbWVyQHlvcG1haWwuY29tIiwidXNlcklkIjo0NCwidHlwZSI6IkNVU1RPTUVSIiwiaWF0IjoxNjgxNzQ5NDU1LCJleHAiOjE2ODE3Njc0NTV9.SFxK1nOH3w3O9P_jkPcONs8bO4rZzvrirUIqaSdV0kk"}) async {
    final headers = <String, String>{"Authorization": authentationCode};

    var response = await client
        .get(Uri.parse("http://103.90.84.130/api/business"), headers: headers);
    BusinessData businessData =
        BusinessData.fromJson(json.decode(response.body));
    return businessData;
  }

  static Future<LocationData> getAllLocationData(
      {String authentationCode =
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImN1c3RvbWVyQHlvcG1haWwuY29tIiwidXNlcklkIjo0NCwidHlwZSI6IkNVU1RPTUVSIiwiaWF0IjoxNjgxNzQ5NDU1LCJleHAiOjE2ODE3Njc0NTV9.SFxK1nOH3w3O9P_jkPcONs8bO4rZzvrirUIqaSdV0kk"}) async {
    final headers = <String, String>{"Authorization": authentationCode};

    var response = await client.get(
        Uri.parse("http://103.90.84.130/api/location/find-all"),
        headers: headers);
    LocationData locationData =
        LocationData.fromJson(json.decode(response.body));
    return locationData;
  }

  static Future<LocationByBusiness> getLocationByBusinessData(
      {String authentationCode =
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImN1c3RvbWVyQHlvcG1haWwuY29tIiwidXNlcklkIjo0NCwidHlwZSI6IkNVU1RPTUVSIiwiaWF0IjoxNjgxNzQ5NDU1LCJleHAiOjE2ODE3Njc0NTV9.SFxK1nOH3w3O9P_jkPcONs8bO4rZzvrirUIqaSdV0kk"}) async {
    final headers = <String, String>{"Authorization": authentationCode};
    var response = await client.get(
        Uri.parse("http://103.90.84.130/api/location/find-all"),
        headers: headers);
    LocationByBusiness locationData =
        LocationByBusiness.fromJson(json.decode(response.body));
    return locationData;
  }
}
