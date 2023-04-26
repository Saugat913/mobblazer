import 'package:flutter/material.dart';
import 'package:mobblazers/components/snackbar.dart';
import 'package:mobblazers/models/appstate.dart';
import 'package:mobblazers/screen/LogIn.dart';

void sessionExpired(BuildContext context) {
  showSnackBar(context, "Session Expired");
  final shareInstance = AppState.getInstance().sharePreference;
  shareInstance!.setBool("isLogin", false);
  shareInstance.setString("authcode", "");
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => LogInPage()));
}
