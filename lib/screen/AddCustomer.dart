import 'package:flutter/material.dart';
import 'package:mobblazers/components/snackbar.dart';
import 'package:mobblazers/services/email_validator.dart';
import 'package:mobblazers/services/rest_service.dart';

class AddCustomerPage extends StatefulWidget {
  AddCustomerPage({super.key, required this.authentationCode});
  String authentationCode;

  @override
  State<AddCustomerPage> createState() => _AddCustomerPageState();
}

class _AddCustomerPageState extends State<AddCustomerPage> {
  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     // Your state update code here
  //     setState(() {
  //       // Update your widget's state here
  //     });
  //   });
  // }

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

  List<TextEditingController> textEditControllerList = [
    TextEditingController(), //firstName controller
    TextEditingController(), //lastName controller
    TextEditingController(), //emailAdress Controller
    TextEditingController() //phoneNumber Controller
  ];

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: Text(
              "Add Customer",
              style: TextStyle(color: Colors.black),
            )),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.only(
                    left: screenWidth * 0.07,
                    right: screenWidth * 0.07,
                    top: screenWidth * 0.07),
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
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w500),
                          ),
                          TextFormField(
                            controller: textEditControllerList.elementAt(index),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                contentPadding:
                                    EdgeInsets.only(left: 24, right: 24),
                                prefixIcon:
                                    Icon(formFieldIcon.elementAt(index))),
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
                              gradient: LinearGradient(
                                begin: Alignment(0, -1),
                                end: Alignment(0, 1),
                                colors: <Color>[
                                  Color(0xffe91d26),
                                  Color(0xfff36622)
                                ],
                                stops: <double>[0, 1],
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "Add Customer",
                                style: TextStyle(color: Colors.white),
                              ),
                            )),
                        onTap: () async {
                          String? errorMsg = null;
                          //validate that all input is taken if not show user error by using snacker
                          for (var i = 0;
                              i < textEditControllerList.length;
                              i++) {
                            if (textEditControllerList[i].text == "") {
                              errorMsg = "Enter all the field";
                              break;
                            }
                          }
                          //check the input email is valid or not
                          if (!textEditControllerList[2].text.isValidEmail()) {
                            errorMsg = "Please enter the valid email!!";
                          }
                          if (errorMsg == null) {
                            var customer = await RestService.addCustomer(
                                textEditControllerList.elementAt(0).text,
                                textEditControllerList.elementAt(1).text,
                                textEditControllerList.elementAt(2).text,
                                textEditControllerList.elementAt(3).text,
                                authentationCode: widget.authentationCode);
                            if (customer.status != 200) {
                              errorMsg = customer.message;
                            }
                          }
                          if (errorMsg != null) {
                            showSnackBar(context,
                                "OOps error occured during adding user\n${errorMsg}");
                          }
                        }),
                  ],
                )),
          ),
        ));
  }
}
