import 'package:flutter/material.dart';
import 'package:mobblazers/components/snackbar.dart';
import 'package:mobblazers/screen/session.dart';
import 'package:mobblazers/services/rest_service.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String? _oldPasswordError;
  String? _newPasswordError;
  String? _confirmPasswordError;
  bool _obscureOldPassword = true;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool isValidationGoneWrong = false;

  bool validator() {
    bool isValid = true;
    if (_oldPasswordController.text.isEmpty) {
      setState(() {
        _oldPasswordError = "Please provide the field";
      });
      isValid = false;
    }
    if (_passwordController.text.isEmpty) {
      setState(() {
        _newPasswordError = "Please provide the field";
      });
      isValid = false;
    }
    if (_confirmPasswordController.text.isEmpty) {
      setState(() {
        _confirmPasswordError = "Please provide the field";
      });
      isValid = false;
    }
    if (_confirmPasswordController.text.isNotEmpty &&
        _confirmPasswordController.text != _passwordController.text) {
      setState(() {
        _confirmPasswordError = "Please enter same password as above";
      });
      isValid = false;
    }
    isValidationGoneWrong = !isValid;
    return isValid;
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:
            //  Builder(builder: (context) {
            //   return
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                )),
        // }),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 30,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Change Password",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.07),
              Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Original Password",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: _oldPasswordController,
                        obscureText: _obscureOldPassword,
                        onChanged: (value) {
                          if (isValidationGoneWrong == true &&
                              _oldPasswordController.text.isNotEmpty) {
                            setState(() {
                              _oldPasswordError = null;
                            });
                          }
                        },
                        decoration: InputDecoration(
                          errorText: _oldPasswordError,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14)),
                          hintText: "password",
                          labelText: "Password",
                          suffixIcon: IconButton(
                            icon: Icon(_obscureOldPassword
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _obscureOldPassword = !_obscureOldPassword;
                              });
                            },
                          ),
                          contentPadding:
                              const EdgeInsets.only(left: 24, right: 24),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "New Password",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        onChanged: (value) {
                          if (isValidationGoneWrong == true &&
                              _passwordController.text.isNotEmpty) {
                            setState(() {
                              _newPasswordError = null;
                            });
                          }
                        },
                        decoration: InputDecoration(
                          errorText: _newPasswordError,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14)),
                          hintText: "new password",
                          labelText: "Password",
                          suffixIcon: IconButton(
                            icon: Icon(_obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                          contentPadding:
                              const EdgeInsets.only(left: 24, right: 24),
                        ),
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Please enter the password';
                        //   }
                        //   return null;
                        // },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Confirm Password",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: _obscureConfirmPassword,
                        onChanged: (value) {
                          if (isValidationGoneWrong == true &&
                              _confirmPasswordController.text.isNotEmpty) {
                            if (_confirmPasswordController.text ==
                                _passwordController.text) {
                              setState(() {
                                _confirmPasswordError = null;
                              });
                            } else {
                              setState(() {
                                _confirmPasswordError =
                                    "Please enter same password as above";
                              });
                            }
                          }
                        },
                        decoration: InputDecoration(
                          errorText: _confirmPasswordError,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14)),
                          hintText: "confirm password",
                          labelText: "Password",
                          suffixIcon: IconButton(
                            icon: Icon(_obscureConfirmPassword
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _obscureConfirmPassword =
                                    !_obscureConfirmPassword;
                              });
                            },
                          ),
                          contentPadding:
                              const EdgeInsets.only(left: 24, right: 24),
                        ),
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Please enter the password';
                        //   }
                        //   if (value != _passwordController.text) {
                        //     return 'Please enter the same password!!';
                        //   }
                        //   return null;
                        // },
                      ),
                    ],
                  )),
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
              ),
              GestureDetector(
                onTap: () async {
                  if (validator()) {
                    var status = await RestService.resetPasswordFromInside(
                        _oldPasswordController.text,
                        _confirmPasswordController.text);
                    if (status == null) {
                      const SessionExpired();
                    }
                    showSnackBar(context, status!.message);
                    // if (status!.status != 404) {
                    //   Navigator.of(context).push(MaterialPageRoute(
                    //       builder: ((context) => LogInPage())));
                    // }
                  }
                },
                child: Center(
                  child: Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width / 1.4,
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
                        "CHANGE PASSWORD",
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 1.5,
                        ),
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
