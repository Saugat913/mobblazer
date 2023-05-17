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
  String? passwordErrorText;
  String? emailErrorText;
  bool isValidatedGoneWrong = false;
  String? errorMessage;

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
    isValidatedGoneWrong = !isValid;
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
                    onChanged: (value) {
                      if (isValidatedGoneWrong && value.isValidEmail()) {
                        setState(() {
                          emailErrorText = null;
                        });
                      }
                    },
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
                    onChanged: (value) {
                      if (isValidatedGoneWrong && value.isNotEmpty) {
                        setState(() {
                          passwordErrorText = null;
                        });
                      }
                    },
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
                height: MediaQuery.of(context).size.height / 21,
              ),
              Center(
                child: Visibility(
                    visible: errorMessage == null ? false : true,
                    child: Text(
                      errorMessage ?? "",
                      style: const TextStyle(fontSize: 17, color: Color(0xFFFC2626)),
                    )),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 21,
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
                        Timer(const Duration(seconds: 4),(){
                          setState(() {
                            errorMessage=null;
                          });
                        });
                        setState(() {
                          errorMessage = user!.message;
                        });
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
              SizedBox(
                height: MediaQuery.of(context).size.height / 30,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 0, bottom: 0, right: 30, top: 0),
                child: Row(
                  children: [
                    const Spacer(),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: ((context) =>
                                  const ResetPasswordPage())));
                        },
                        child: const Text(
                          "Forget Password?",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16.0,
                          ),
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              Center(
                child: Column(
                  children: const [
                    Text("Not a member?"),
                    SizedBox(
                      height: 5,
                    ),
                    Text("Contact us for an account."),
                    SizedBox(
                      height: 5,
                    ),
                    Text("sales@mapblazers.com")
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
