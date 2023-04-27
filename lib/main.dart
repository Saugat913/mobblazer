import 'package:flutter/material.dart';
import 'package:mobblazers/models/appstate.dart';
import 'package:mobblazers/screen/DashBoard.dart';
import 'package:mobblazers/screen/GetStarted.dart';
import 'package:mobblazers/screen/LogIn.dart';

import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedInstance = await SharedPreferences.getInstance();
  AppState.getInstance().sharePreference = sharedInstance;
  var checkedWidget = await checker();
  runApp(MyApp(checkedWidget: checkedWidget));
}

Future<Widget> checker() async {
  final appState = AppState.getInstance();
  bool? isVisitedStatus = appState.sharePreference!.getBool("isVisited");
  bool? isLoginStatus = appState.sharePreference!.getBool("isLogin");
  String? authCode = appState.sharePreference!.getString("authcode");

  if (isVisitedStatus == null || isVisitedStatus == false) {
    return GetStarted();
  }
  if (isLoginStatus != null && isLoginStatus == true && authCode != null) {
    appState.authentationCode = authCode;
    return DashBoard();
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
