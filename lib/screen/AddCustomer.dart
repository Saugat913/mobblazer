import 'package:flutter/material.dart';

class AddCustomerPage extends StatelessWidget {
  AddCustomerPage({super.key});

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
          child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.07),
              child: SingleChildScrollView(
                child: Column(children: [
                  Form(
                      child: Column(
                    children: [
                      ...List.generate(
                        textEditControllerList.length,
                        (index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  formFieldName.elementAt(index),
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              TextFormField(
                                controller:
                                    textEditControllerList.elementAt(index),
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    contentPadding:
                                        EdgeInsets.only(left: 24, right: 24),
                                    prefixIcon:
                                        Icon(formFieldIcon.elementAt(index))),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                            ],
                          );
                        },
                      )
                    ],
                  )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Center(
                      child: Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width / 1.3,
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
                        ),
                      ),
                    ),
                  ),
                ]),
              ))),
    );
  }
}
