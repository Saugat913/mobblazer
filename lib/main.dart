import 'package:flutter/material.dart';
import 'package:mobblazers/models/appstate.dart';
import 'package:mobblazers/screen/DashBoard.dart';
import 'package:mobblazers/screen/GetStarted.dart';
import 'package:mobblazers/screen/LogIn.dart';
import 'package:mobblazers/screen/loadingPage.dart';

import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedInstance = await SharedPreferences.getInstance();
  AppState.getInstance().sharePreference = sharedInstance;
  runApp(const MyApp());
}

Future<Widget> checker() async {
  final appState = AppState.getInstance();
  bool? isVisitedStatus = appState.sharePreference!.getBool("isVisited");
  bool? isLoginStatus = appState.sharePreference!.getBool("isLogin");
  String? authCode = appState.sharePreference!.getString("authcode");

  if (isVisitedStatus == null || isVisitedStatus == false) {
    return const GetStarted();
  }
  if (isLoginStatus != null && isLoginStatus == true && authCode != null) {
    appState.authentationCode = authCode;
    return const DashBoard();
  }
  return const LogInPage();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
          future: checker(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingPage();
            }
            return snapshot.data!;
          },
        ));
  }
}
