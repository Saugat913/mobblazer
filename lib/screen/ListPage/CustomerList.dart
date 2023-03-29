import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobblazers/components/CustomTextButton.dart';
import 'package:mobblazers/screen/AddCustomer.dart';
import 'package:mobblazers/services/rest_service.dart';

import '../../models/user.dart';

class CustomerModel {
  CustomerModel(
      {required this.customerName,
      required this.isSelected,
      required this.isReviewSent});
  String customerName;
  bool isSelected;
  bool isReviewSent;
}

class CustomerListPage extends StatefulWidget {
  CustomerListPage(
      {super.key, required this.businessName, required this.businessLocation});
  String businessName, businessLocation;

  @override
  State<CustomerListPage> createState() => _CustomerListPageState();
}

class _CustomerListPageState extends State<CustomerListPage> {
  List<User>? userdata;
  @override
  void initState() {
    super.initState();

    getData();
  }

  getData() async {
    userdata = await RestService().getUsers();
    if (userdata != null) {
      setState(() {
        isLoaded = true;
        customerList = List.generate(
            userdata!.length,
            (index) => CustomerModel(
                customerName: userdata![index].username,
                isSelected: false,
                isReviewSent: false));
      });
    }
  }

  List<CustomerModel>? customerList;

  bool isAllSelected = false;
  bool isLoaded = false;
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var fontFactor =
        ((screenWidth * screenHeight) / (screenHeight + screenWidth)) * 0.004;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => AddCustomerPage())));
              },
              child: Image.asset(
                "assets/images/add_user.png",
                height: screenWidth * 0.07,
                width: screenWidth * 0.07,
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        minimum: EdgeInsets.only(left: screenWidth * 0.08),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${widget.businessName}",
              style: TextStyle(
                  fontSize: fontFactor * 17, fontWeight: FontWeight.w400),
            ),
            Text(
              "${widget.businessLocation}",
              style: TextStyle(
                  fontSize: fontFactor * 17, fontWeight: FontWeight.w400),
            ),
            isLoaded == true
                ?
                // customerList!.length == 0
                //     ? Expanded(
                //         child: Center(
                //             child: Column(
                //           children: [
                //             SizedBox(
                //               height: screenHeight * 0.2,
                //             ),
                //             Text(
                //                 "You don't have any customers for this locations yet. Please add new customer to send review request"),
                //             SizedBox(
                //               height: 12,
                //             ),
                //             GestureDetector(
                //                 onTap: () {},
                //                 child: Container(
                //                     height: screenHeight * 0.04,
                //                     width: screenWidth * 0.3,
                //                     decoration: BoxDecoration(
                //                         color: Color(0xff363740),
                //                         borderRadius: BorderRadius.circular(4)),
                //                     child: Center(
                //                       child: Text(
                //                         "Add the customer",
                //                         style:
                //                             TextStyle(fontSize: fontFactor * 12),
                //                       ),
                //                     ))
                //                 //
                //                 ),
                //           ],
                //         )),
                //       )
                Expanded(
                    child: Container(
                      padding: EdgeInsets.all(12),
                      child: Column(children: [
                        SizedBox(
                          height: 14,
                        ),
                        Row(
                          children: [
                            Text(
                              "Customer List",
                              style: TextStyle(
                                  fontSize: fontFactor * 15,
                                  fontWeight: FontWeight.w400),
                            ),
                            Spacer(),
                            CustomTextButton(
                              height: screenHeight * 0.04,
                              width: screenWidth * 0.2,
                              text: "Bulk Send",
                              onTap: () {},
                              fontFactor: fontFactor,
                              fontSize: 11,
                            )
                          ],
                        ),
                        SizedBox(
                          height: screenHeight * 0.04,
                        ),
                        Row(
                          children: [
                            Checkbox(
                                value: isAllSelected,
                                onChanged: (value) {
                                  if (value != null) {
                                    setState(() {
                                      isAllSelected = value;

                                      for (var i = 0;
                                          i < customerList!.length;
                                          i++) {
                                        customerList![i].isSelected = value;
                                      }
                                    });
                                  }
                                }),
                            Text("Select all")
                          ],
                        ),
                        Expanded(
                          child: Container(
                            child: ListView.builder(
                                itemCount: customerList!.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 12.0),
                                    child: Row(
                                      children: [
                                        Checkbox(
                                            value: customerList!
                                                .elementAt(index)
                                                .isSelected,
                                            onChanged: ((value) {
                                              if (value != null) {
                                                setState(() {
                                                  customerList![index]
                                                      .isSelected = value;
                                                });
                                              }
                                            })),
                                        Text(
                                            "${customerList!.elementAt(index).customerName}"),
                                        Spacer(),
                                        GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                customerList![index]
                                                    .isReviewSent = true;
                                              });
                                            },
                                            child: Container(
                                                height: screenHeight * 0.04,
                                                width: screenWidth * 0.2,
                                                decoration: BoxDecoration(
                                                    color: customerList!
                                                            .elementAt(index)
                                                            .isReviewSent
                                                        ? Colors.green
                                                        : Color(0xffee3925),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                                child: Center(
                                                    child: Text(
                                                  customerList!
                                                          .elementAt(index)
                                                          .isReviewSent
                                                      ? "Review sent"
                                                      : "Send Review",
                                                  style: TextStyle(
                                                      fontSize: fontFactor * 11,
                                                      color: Colors.white),
                                                )))),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        )
                      ]),
                    ),
                  )
                : Expanded(
                    child: Container(
                        child: Center(
                    child: CircularProgressIndicator(),
                  ))),
          ],
        ),
      ),
    );
  }
}
