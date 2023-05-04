import 'dart:convert';
import 'package:mobblazers/models/addcustomer.dart';
import 'package:mobblazers/models/business.dart';
import 'package:mobblazers/models/customer.dart';
import 'package:mobblazers/models/dashboard.dart';
import 'package:mobblazers/models/responseStatus.dart';
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
      {required String authentationCode}) async {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Authorization': authentationCode
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
      {required String authentationCode}) async {
    final headers = <String, String>{"Authorization": authentationCode};
    late Dashboardmodel dashboardmodel;

    var response = await client.get(
        Uri.parse("http://103.90.84.130/api/user/get-all-stats"),
        headers: headers);

    // why check header because if error it doesnot sent json but html file
    //so we have to check for error instead of parsing json
    if (response.headers["Content-Type"] == "text/html") {
      return null;
    }
    //print(response.body.toString());
    //try {
      dashboardmodel = Dashboardmodel.fromJson(json.decode(response.body));

   // } catch (e) {
    //  return null;
    //}
      
    return dashboardmodel;
  }

  static Future<BusinessData?> getAllBusinessData(
      {required String authentationCode}) async {
    final headers = <String, String>{"Authorization": authentationCode};
    late BusinessData businessData;
    var response = await client
        .get(Uri.parse("http://103.90.84.130/api/business"), headers: headers);
   // print(response.body.toString());
    try {
      businessData = BusinessData.fromJson(json.decode(response.body));
    } catch (e) {
      return null;
    }

    return businessData;
  }

  static Future<LocationData?> getAllLocationData(
      {required String authentationCode}) async {
    final headers = <String, String>{"Authorization": authentationCode};
    late LocationData locationData;
    var response = await client.get(
        Uri.parse("http://103.90.84.130/api/location/find-all"),
        headers: headers);
    print(response.body.toString());
    try {
      locationData = LocationData.fromJson(json.decode(response.body));
    } catch (e) {
      return null;
    }

    return locationData;
  }

  static Future<LocationByBusiness> getLocationByBusinessData(int businessId,
      {required String authentationCode}) async {
    final headers = <String, String>{"Authorization": authentationCode};
    var response = await client.get(
        Uri.parse("http://103.90.84.130/api/location/business/$businessId"),
        headers: headers);
    LocationByBusiness locationData =
        LocationByBusiness.fromJson(json.decode(response.body));
    return locationData;
  }

  static Future<ResponseStatus> forgetPassword(String email) async {
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };
    final body = json.encode(<String, String>{
      'email': email,
    });
    var response = await client.post(
        Uri.parse("http://103.90.84.130/api/user/restore-password"),
        body: body,
        headers: headers);
    ResponseStatus status = ResponseStatus.fromJson(json.decode(response.body));
    return status;
  }

  static Future<ResponseStatus> verifyToken(String token) async {
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };
    final body = json.encode(<String, String>{
      'token': token,
    });
    var response = await client.post(
        Uri.parse("http://103.90.84.130/api/user/verify-token"),
        body: body,
        headers: headers);
    ResponseStatus status = ResponseStatus.fromJson(json.decode(response.body));
    return status;
  }

  static Future<ResponseStatus> resetPasswordFromOutSide(
      String token, String newPassword) async {
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };
    final body =
        json.encode(<String, String>{'token': token, 'password': newPassword});

    var response = await client.post(
        Uri.parse("http://103.90.84.130/api/user/reset-password"),
        body: body,
        headers: headers);
    ResponseStatus status = ResponseStatus.fromJson(json.decode(response.body));
    return status;
  }

  static Future<ResponseStatus?> resetPasswordFromInside(
      String currentPassword, String newPassword) async {
    late ResponseStatus status;
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };
    final body = json.encode(<String, String>{
      "currentPassword": currentPassword,
      "newPassword": newPassword
    });
    try {
      var response = await client.post(
          Uri.parse("http://103.90.84.130/api/user/reset-password"),
          body: body,
          headers: headers);

      status = ResponseStatus.fromJson(json.decode(response.body));
    } catch (e) {
      return null;
    }
    return status;
  }

  static Future<CustomerData> getCustomer(
      String authcode, int locationId) async {
    // final headers = <String, String>{
    //   'Content-Type': 'application/json',
    // };

    var response = await client.get(
      Uri.parse("http://103.90.84.130/api/user/location/$locationId"),
    );
    var customerData = CustomerData.fromJson(json.decode(response.body));
    return customerData;
  }
}
