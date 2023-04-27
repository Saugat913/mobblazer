import 'package:flutter/material.dart';
import 'package:mobblazers/models/appstate.dart';
import 'package:mobblazers/screen/DashBoard.dart';
import 'package:mobblazers/screen/ResetPassword.dart';
import 'package:mobblazers/services/email_validator.dart';
import 'package:mobblazers/services/rest_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/login.dart';

class LogInPage extends StatelessWidget {
  LogInPage({super.key});
  User? user;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14)),
                          hintText: "Enter the email",
                          labelText: "Email",
                          contentPadding: const EdgeInsets.only(left: 24, right: 24),
                          suffixIcon: const Icon(Icons.email_outlined),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the email';
                          }
                          if (!value.isValidEmail()) {
                            return 'Please enter valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14)),
                            hintText: "Password",
                            labelText: "Password",
                            contentPadding:
                                const EdgeInsets.only(left: 24, right: 24),
                            suffixIcon: const Icon(Icons.remove_red_eye)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the password';
                          }
                          return null;
                        },
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
                  if (_formKey.currentState!.validate()) {
                    user = await RestService.logIn(
                        emailController.text, passwordController.text);

                    if (user != null && user!.status == 200) {
                      final appInstance = AppState.getInstance();
                      appInstance.authentationCode = user!.data!.token;
                      final sharedInstance =
                          await SharedPreferences.getInstance();
                      sharedInstance.setBool("isLogin", true);
                      sharedInstance.setString("authcode", user!.data!.token);
                      sharedInstance.setString("userName",user!.data!.userInfo.firstName);
                      sharedInstance.setString("userEmail",user!.data!.userInfo.email);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: ((context) =>
                              const DashBoard())));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          behavior: SnackBarBehavior.floating,
                          content: Container(
                            height: 75,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: Colors.red),
                            child: Center(
                                child: Text(
                              user!.message,
                              style: const TextStyle(color: Colors.white),
                            )),
                          )));
                    }
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
