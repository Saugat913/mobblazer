import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobblazers/components/snackbar.dart';
import 'package:mobblazers/models/appstate.dart';
import 'package:mobblazers/screen/DashBoard.dart';
import 'package:mobblazers/screen/ResetPassword.dart';
import 'package:mobblazers/services/email_validator.dart';
import 'package:mobblazers/services/rest_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/login.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  User? user;

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  //final _formKey = GlobalKey<FormState>();
  bool isObscure = true;
  IconData passwordStateIcon = Icons.visibility_off;
  bool isThereInternet = true;
  String? passwordErrorText = null;
  String? emailErrorText = null;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool validator() {
    bool isValid = true;

    if (emailController.text.isEmpty) {
      isValid = false;
      setState(() {
        emailErrorText = 'This field is required';
      });
    }

    if (!emailController.text.isValidEmail()) {
      isValid = false;
      setState(() {
        emailErrorText = 'Please enter valid email';
      });
    }

    if (passwordController.text.isEmpty) {
      isValid = false;
      setState(() {
        passwordErrorText = 'This field is required';
      });
    }
    Timer(Duration(seconds: 3), () {
      setState(() {
        emailErrorText = null;
        passwordErrorText = null;
      });
    });
    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(17.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 5,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Log In",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Form(
                  // key: _formKey,
                  child: Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      errorText: emailErrorText,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14)),
                      hintText: "Enter the email",
                      labelText: "Email",
                      contentPadding:
                          const EdgeInsets.only(left: 24, right: 24),
                      suffixIcon: const Icon(Icons.email_outlined),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    controller: passwordController,
                    obscureText: isObscure,
                    obscuringCharacter: "*",
                    decoration: InputDecoration(
                        errorText: passwordErrorText,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14)),
                        hintText: "Password",
                        labelText: "Password",
                        contentPadding:
                            const EdgeInsets.only(left: 24, right: 24),
                        suffixIcon: IconButton(
                          icon: Icon(passwordStateIcon),
                          onPressed: () {
                            setState(() {
                              isObscure = isObscure ? false : true;
                              passwordStateIcon = isObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility;
                            });
                          },
                        )),
                  ),
                ],
              )),
              SizedBox(
                height: MediaQuery.of(context).size.height / 14,
              ),
              Row(
                children: [
                  const Spacer(),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) => const ResetPasswordPage())));
                      },
                      child: const Text(
                        "Forget Password?",
                        style: TextStyle(decoration: TextDecoration.underline),
                      )),
                ],
              ),
              const SizedBox(
                height: 18,
              ),
              GestureDetector(
                onTap: () async {
                  if (validator()) {
                    try {
                      user = await RestService.logIn(
                          emailController.text, passwordController.text);
                    } catch (e) {
                      isThereInternet = false;
                      showSnackBar(context, e.toString());
                    }
                    if (isThereInternet) {
                      if (user != null && user!.status == 200) {
                        final appInstance = AppState.getInstance();
                        appInstance.authentationCode = user!.data!.token;
                        final sharedInstance =
                            await SharedPreferences.getInstance();
                        sharedInstance.setBool("isLogin", true);
                        sharedInstance.setString("authcode", user!.data!.token);
                        sharedInstance.setString(
                            "userName", user!.data!.userInfo.firstName);
                        sharedInstance.setString(
                            "userEmail", user!.data!.userInfo.email);
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: ((context) => const DashBoard())));
                      } else {
                        showSnackBar(context, user!.message);
                      }
                    }
                    isThereInternet = true;
                  }
                },
                child: Center(
                  child: Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width / 1.3,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment(0, -1),
                          end: Alignment(0, 1),
                          colors: <Color>[Color(0xffe91d26), Color(0xfff36622)],
                          stops: <double>[0, 1],
                        ),
                        borderRadius: BorderRadius.circular(19)),
                    child: const Center(
                      child: Text(
                        "LOG IN",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
