import 'package:flutter/material.dart';
import 'package:mobblazers/components/snackbar.dart';
import 'package:mobblazers/screen/verification_page.dart';
import 'package:mobblazers/services/email_validator.dart';
import 'package:mobblazers/services/rest_service.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  bool validationChecker() {
    if (_emailController.text.isEmpty) {
      setState(() {
        emailErrorMessage="Please provide the email";
      });
      return false;
    }
    if (!_emailController.text.isValidEmail()) {
      setState(() {
        emailErrorMessage="Please provide valid email";
      });
      return false;
    }
    return true;
  }

  String? emailErrorMessage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ));
        }),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(17.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 8,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Reset Password",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Please enter your email address to request a password reset.",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.2),
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
                        controller: _emailController,
                        onChanged: (value){
                          if(value.isNotEmpty && !value.isValidEmail()){
                            setState(() {
                              emailErrorMessage="Please provide valid email";
                            });
                          }
                          if(value.isValidEmail()){
                            setState(() {
                              emailErrorMessage=null;
                            });
                          }
                        },
                        decoration: InputDecoration(
                          errorText: emailErrorMessage,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14)),
                          hintText: "Enter the email",
                          labelText: "Email",
                          contentPadding:
                              const EdgeInsets.only(left: 24, right: 24),
                          suffixIcon: const Icon(Icons.email_outlined),
                        ),
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Please enter the email';
                        //   }
                        //   if (!value.isValidEmail()) {
                        //     return 'Please enter valid email';
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
                  if (validationChecker()) {
                    var status =
                        await RestService.forgetPassword(_emailController.text);
                    if (status.status == 404) {
                      showSnackBar(context, status.message);
                    } else {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => const VerificationPage())));
                    }
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
                        "SEND",
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
