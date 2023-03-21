import 'package:flutter/material.dart';
//import 'package:mobblazers/screen/AddCustomer.dart';
//import 'package:mobblazers/screen/CustomerList.dart';
import 'package:mobblazers/screen/GetStarted.dart';
//import 'package:mobblazers/screen/LocationList.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:GetStarted()
      //home: LocationListPage(),
      //home: AddCustomerPage(),
      //home: CustomerListPage(),
    );
  }
}