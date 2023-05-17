import 'package:flutter/material.dart';
import 'package:mobblazers/components/CustomTextButton.dart';
import 'package:mobblazers/components/snackbar.dart';
import 'package:mobblazers/models/appstate.dart';
import 'package:mobblazers/services/rest_service.dart';

class CustomerModel {
  CustomerModel(
      {required this.customerName,
      required this.isSelected,
      required this.isReviewSent,
      required this.customerId});
  String customerName;
  bool isSelected;
  bool? isReviewSent;
  int customerId;
}

class CustomerList extends StatefulWidget {
  CustomerList(
      {super.key, required this.customerList, required this.locationId});
  List<CustomerModel>? customerList;
  int locationId;
  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  bool isAllSelected = false;
  bool isBulkSent = true;
  bool isReviewSentToAllCustomer = true;

  // void checkReviewSentToAllCustomer(){
  //   for (var element in widget.customerList!) {

  //   }
  //}

  void checkBulkReviewSent() {
    for (var element in widget.customerList!) {
      isBulkSent = true;
      if (element.isReviewSent == false) {
        isBulkSent = false;
      }
    }
  }

  @override
  void initState() {
    checkBulkReviewSent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var fontFactor =
        ((screenWidth * screenHeight) / (screenHeight + screenWidth)) * 0.004;
    return Container(
      //padding: const EdgeInsets.all(12),
      child: Column(children: [
        const SizedBox(
          height: 14,
        ),
        Row(
          children: [
            Text(
              "Customer List",
              style: TextStyle(
                  fontSize: fontFactor * 15, fontWeight: FontWeight.w400),
            ),
            const Spacer(),
            CustomTextButton(
              height: screenHeight * 0.04,
              width: screenWidth * 0.2,
              text: isBulkSent == true ? "Bulk sent" : "Bulk Send",
              onTap: isBulkSent == true
                  ? () {}
                  : () async {
                      List<int> selectedCustomerId = [];
                      for (var element in widget.customerList!) {
                        if (element.isSelected == true) {
                          selectedCustomerId.add(element.customerId);
                        }
                      }
                      bool status = await RestService.sendReviewBulk(
                          widget.locationId,
                          selectedCustomerId,
                          AppState.getInstance().authentationCode!);
                      // after getting response dont know the response we change the state as review sent
                      if (status == true) {
                        //if sucessfull if not TODO handled
                        for (var element in widget.customerList!) {
                          if (selectedCustomerId.contains(element.customerId)) {
                            element.isReviewSent = true;
                          }
                        }
                        showSnackBar(context, "Review Sent! ");
                        checkBulkReviewSent();
                        setState(() {});
                      } else {
                        showSnackBar(context, "Error");
                      }
                    },
              fontFactor: fontFactor,
              fontSize: 11,
              color: isBulkSent == true ? Colors.green : null,
            )
          ],
        ),
        SizedBox(
          height: screenHeight * 0.04,
        ),
        CheckboxListTile(
            contentPadding: const EdgeInsets.all(0),
            value: isAllSelected,
            enabled: isBulkSent == true ? false : true,
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  isAllSelected = value;

                  for (var i = 0; i < widget.customerList!.length; i++) {
                    if (widget.customerList![i].isReviewSent == false) {
                      widget.customerList![i].isSelected = value;
                    }
                  }
                });
              }
            },
            title: const Text("Select all"),
            controlAffinity: ListTileControlAffinity.leading),
        Expanded(
          child: ListView.builder(
              itemCount: widget.customerList?.length ?? 0,
              padding: const EdgeInsets.all(0),
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  contentPadding: const EdgeInsets.all(0),
                  value: widget.customerList!.elementAt(index).isSelected,
                  enabled:
                      widget.customerList!.elementAt(index).isReviewSent ?? true
                          ? false
                          : true,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        widget.customerList![index].isSelected = value;
                      });
                    }
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Row(
                    children: [
                      Text(widget.customerList!.elementAt(index).customerName),
                      const Spacer(),
                      SizedBox(
                        height: screenHeight * 0.04,
                        width: screenWidth * 0.2,
                        child: GestureDetector(
                            onTap: widget.customerList!
                                        .elementAt(index)
                                        .isReviewSent ??
                                    true
                                ? () {}
                                : () async {
                                    setState(() {
                                      widget.customerList!.elementAt(index).isReviewSent=null;
                                    });
                                    //TODO:Send the review of individual
                                    bool status =
                                        await RestService.sendReviewOf(
                                            widget.locationId,
                                            widget.customerList!
                                                .elementAt(index)
                                                .customerId,
                                            AppState.getInstance()
                                                .authentationCode!);
                                    if (status == true) {
                                      //if sucessfull if not TODO handled
                                      setState(() {
                                        widget.customerList![index]
                                            .isReviewSent = true;
                                        checkBulkReviewSent();
                                      });
                                      //showSnackBar(context, "Review Sent! ");
                                    }else{
                                      setState(() {
                                         widget.customerList![index]
                                            .isReviewSent = false;
                                      });
                                    }
                                  },
                            child: widget.customerList!
                                        .elementAt(index)
                                        .isReviewSent ==
                                    null
                                ? const CircularProgressIndicator()
                                : Container(
                                    padding: const EdgeInsets.only(top: 4, bottom: 4),
                                    decoration: BoxDecoration(
                                        color: widget.customerList!
                                                .elementAt(index)
                                                .isReviewSent!
                                            ? Colors.green
                                            : const Color(0xffee3925),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Center(
                                        child: Text(
                                      widget.customerList!
                                              .elementAt(index)
                                              .isReviewSent!
                                          ? "Review sent"
                                          : "Send Review",
                                      style: TextStyle(
                                          fontSize: fontFactor * 11,
                                          color: Colors.white),
                                    )))),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ]),
    );
  }
}
