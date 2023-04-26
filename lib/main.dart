import 'package:flutter/material.dart';
import 'package:mobblazers/models/appstate.dart';
import 'package:mobblazers/screen/DashBoard.dart';
import 'package:mobblazers/screen/GetStarted.dart';
import 'package:mobblazers/screen/LogIn.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  final sharedInstance = await SharedPreferences.getInstance();
  AppState.getInstance().sharePreference = sharedInstance;
  var checkedWidget = checker();
  runApp(MyApp(checkedWidget: checkedWidget));
}

Widget checker()  {
  bool? isVisitedStatus =
      AppState.getInstance().sharePreference!.getBool("isVisited");
  bool? isLoginStatus =
      AppState.getInstance().sharePreference!.getBool("isLogin");
  String? authCode =
      AppState.getInstance().sharePreference!.getString("authcode");

  if (isVisitedStatus == null || isVisitedStatus == false) {
    return GetStarted();
  }
  if (isLoginStatus != null && isLoginStatus == true && authCode != null) {
    AppState.getInstance().authentationCode = authCode;
    return DashBoard(authentationCode: authCode);
  }
  return LogInPage();
}

class MyApp extends StatelessWidget {
  Widget checkedWidget;

  MyApp({super.key, required this.checkedWidget});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: checkedWidget);
  }
}
