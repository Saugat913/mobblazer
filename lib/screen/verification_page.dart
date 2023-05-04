import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobblazers/components/snackbar.dart';
import 'package:mobblazers/screen/create_new_pass.dart';
import 'package:mobblazers/services/rest_service.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key});

  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  List<TextEditingController> code = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];
  final _formKey = GlobalKey<FormState>();
  bool isResendDisabled = true;
  int _counter = 20;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_counter < 1) {
            isResendDisabled = false;
            timer.cancel();
          } else {
            _counter = _counter - 1;
          }
        },
      ),
    );
  }

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
                Icons.arrow_back_ios_new,
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
                height: MediaQuery.of(context).size.height / 12,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Verifcation",
                  style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "We've sent you the verification code in your email",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.2),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Form(
                    key: _formKey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 68,
                          width: 64,
                          child: TextFormField(
                            controller: code[0],
                            onChanged: (value) {
                              if (value.length == 1) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14)),
                              hintText: "0",
                            ),
                            textAlign: TextAlign.center,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the pin';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 68,
                          width: 64,
                          child: TextFormField(
                            controller: code[1],
                            onChanged: (value) {
                              if (value.length == 1) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14)),
                              hintText: "0",
                            ),
                            textAlign: TextAlign.center,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the pin';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 68,
                          width: 64,
                          child: TextFormField(
                            controller: code[2],
                            onChanged: (value) {
                              if (value.length == 1) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14)),
                              hintText: "0",
                            ),
                            textAlign: TextAlign.center,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the pin';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 68,
                          width: 64,
                          child: TextFormField(
                            controller: code[3],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14)),
                              hintText: "0",
                            ),
                            textAlign: TextAlign.center,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the pin';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    )),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 30,
              ),
              GestureDetector(
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    String token = "";
                    for (var element in code) {
                      token += element.text;
                    }
                    var status = await RestService.verifyToken(token);
                    if (status.status == 404) {
                      showSnackBar(context, status.message);
                    } else {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: ((context) =>
                              NewPasswordPage(token: token))));
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
                        "VERIFY",
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 25,
              ),
              Center(
                child: Text(
                  'Re-send code in 0:$_counter ',
                  style: const TextStyle(
                    fontSize: 15,
                    letterSpacing: 1.3,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Center(
                child: TextButton(
                    onPressed: isResendDisabled
                        ? null
                        : () {
                            _counter = 20;
                            isResendDisabled = true;
                            _startTimer();
                          },
                    child: const Text(
                      "Re-Send",
                      style: TextStyle(decoration: TextDecoration.none),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    for (var element in code) {
      element.dispose();
    }
    super.dispose();
  }
}
