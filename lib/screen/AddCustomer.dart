import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobblazers/components/snackbar.dart';
import 'package:mobblazers/models/appstate.dart';
import 'package:mobblazers/services/email_validator.dart';
import 'package:mobblazers/services/phone_number_formatter.dart';
import 'package:mobblazers/services/rest_service.dart';

class AddCustomerPage extends StatefulWidget {
  const AddCustomerPage({super.key});

  @override
  State<AddCustomerPage> createState() => _AddCustomerPageState();
}

class _AddCustomerPageState extends State<AddCustomerPage> {
  final _formKey = GlobalKey<FormState>();
  List<TextEditingController> textEditControllerList = [
    TextEditingController(), //firstName controller
    TextEditingController(), //lastName controller
    TextEditingController(), //emailAdress Controller
    TextEditingController() //phoneNumber Controller
  ];
  List<String?> errorMessage = List<String?>.generate(4, (index) => null);
  List<String> formFieldName = [
    "First Name",
    "Last Name",
    "Email address",
    "Phone Number"
  ];

  List<IconData> formFieldIcon = [
    Icons.account_circle,
    Icons.account_circle,
    Icons.email,
    Icons.phone
  ];

  bool isValidatedGoneWrong = false;

  void validator() {
    if (!textEditControllerList.elementAt(2).text.isValidEmail()) {
      isValidatedGoneWrong = true;
      errorMessage[2] = "Please provide the valid email";
    }
    for (var i = 0; i < textEditControllerList.length; i++) {
      if (textEditControllerList.elementAt(i).text.isEmpty) {
        isValidatedGoneWrong = true;
        setState(() {
          errorMessage[i] = "Please provide the ${formFieldName.elementAt(i)}";
        });
      }
    }
  }

  @override
  void dispose() {
    for (var element in textEditControllerList) {
      element.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: const Text(
              "Add Customer",
              style: TextStyle(color: Colors.black),
            )),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.only(
                    left: screenWidth * 0.07,
                    right: screenWidth * 0.07,
                    top: screenHeight * 0.1),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ...List.generate(textEditControllerList.length, (index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              formFieldName.elementAt(index),
                              style: const TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            TextFormField(
                                controller:
                                    textEditControllerList.elementAt(index),
                                keyboardType:
                                    index == 3 ? TextInputType.number : null,
                                inputFormatters: index == 3
                                    ? [
                                        LengthLimitingTextInputFormatter(17),
                                        PhoneNumberFormatter()
                                      ]
                                    : null,
                                onChanged: (value) {
                                  if (value.isNotEmpty) {
                                    setState(() {
                                      errorMessage[index] = null;
                                    });
                                  }
                                  if (index == 2 &&
                                      value.isNotEmpty &&
                                      !value.isValidEmail()) {
                                    setState(() {
                                      errorMessage[index] =
                                          "Please enter the valid email";
                                    });
                                  }
                                },
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    contentPadding: const EdgeInsets.only(
                                        left: 24, right: 24),
                                    prefixIcon:
                                        Icon(formFieldIcon.elementAt(index)),
                                    errorText: errorMessage.elementAt(index))
                                // validator: (value) {
                                //   if (value == null || value.isEmpty) {
                                //     return "Please provide the ${formFieldName.elementAt(index)}";
                                //   }
                                //   if (index == 2 && !value.isValidEmail()) {
                                //     return "Please provide valid email";
                                //   }
                                //   return null;
                                // },
                                ),
                            SizedBox(
                              height: screenHeight * 0.04,
                            )
                          ],
                        );
                      }),

                      //seperate the form with add button
                      SizedBox(
                        height: screenHeight * 0.1,
                      ),

                      GestureDetector(
                          child: Container(
                              height: 45,
                              width: screenWidth / 1.3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(19),
                                gradient: const LinearGradient(
                                  begin: Alignment(0, -1),
                                  end: Alignment(0, 1),
                                  colors: <Color>[
                                    Color(0xffe91d26),
                                    Color(0xfff36622)
                                  ],
                                  stops: <double>[0, 1],
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  "Add Customer",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )),
                          onTap: () async {
                            validator();
                            if (!isValidatedGoneWrong) {
                              String? errorMsg;

                              //print(textEditControllerList[3].text);
                              //print(formatPhoneNumber(textEditControllerList[3].text));

                              // //check the input email is valid or not
                              // if (!textEditControllerList[2]
                              //     .text
                              //     .isValidEmail()) {
                              //   errorMsg = "Please enter the valid email!!";
                              // }

                              var customer = await RestService.addCustomer(
                                  textEditControllerList.elementAt(0).text,
                                  textEditControllerList.elementAt(1).text,
                                  textEditControllerList.elementAt(2).text,
                                  textEditControllerList.elementAt(3).text,
                                  authentationCode:
                                      AppState.getInstance().authentationCode!);
                              if (customer.status != 200) {
                                errorMsg = customer.message;
                              }

                              if (errorMsg != null) {
                                showSnackBar(context,
                                    "OOps error occured during adding user\n$errorMsg");
                              } else {
                                showSnackBar(context, customer.message);
                              }
                            }
                          }),
                    ],
                  ),
                )),
          ),
        ));
  }
}
