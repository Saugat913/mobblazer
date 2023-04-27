import 'package:flutter/material.dart';
import 'package:mobblazers/components/snackbar.dart';
import 'package:mobblazers/models/appstate.dart';
import 'package:mobblazers/screen/LogIn.dart';
import 'package:mobblazers/screen/loadingPage.dart';


class SessionExpired extends StatelessWidget {
  const SessionExpired({super.key});

  Future<bool> wait(BuildContext context) async {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => showSnackBar(context, "Session Expired"));
    final shareInstance = AppState.getInstance().sharePreference;
    shareInstance!.setBool("isLogin", false);
    shareInstance.setString("authcode", "");
    await Future.delayed(const Duration(seconds: 2));
    WidgetsBinding.instance.addPostFrameCallback((_) => Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) {
          return LogInPage();
        })));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: wait(context),
        builder: ((context, snapshot) {
          return const LoadingPage();
        }));
  }
}
