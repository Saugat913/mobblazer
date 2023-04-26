import 'package:flutter/material.dart';
import 'package:mobblazers/components/CustomTextButton.dart';

class CustomerModel {
  CustomerModel(
      {required this.customerName,
      required this.isSelected,
      required this.isReviewSent});
  String customerName;
  bool isSelected;
  bool isReviewSent;
}

class CustomerList extends StatefulWidget {
  CustomerList({super.key, required this.customerList});
  List<CustomerModel>? customerList;
  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  bool isAllSelected = false;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var fontFactor =
        ((screenWidth * screenHeight) / (screenHeight + screenWidth)) * 0.004;
    return Container(
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
                  fontSize: fontFactor * 15, fontWeight: FontWeight.w400),
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
        CheckboxListTile(
            value: isAllSelected,
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  isAllSelected = value;

                  for (var i = 0; i < widget.customerList!.length; i++) {
                    widget.customerList![i].isSelected = value;
                  }
                });
              }
            },
            title: Text("Select all"),
            controlAffinity: ListTileControlAffinity.leading),
        Expanded(
          child: Container(
              child: ListView.builder(
                  itemCount: widget.customerList?.length ?? 0,
                  itemBuilder: (context, index) {
                    return CheckboxListTile(
                      value: widget.customerList!.elementAt(index).isSelected,
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
                          Text(
                              "${widget.customerList!.elementAt(index).customerName}"),
                          Spacer(),
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  widget.customerList![index].isReviewSent =
                                      true;
                                });
                              },
                              child: Container(
                                  height: screenHeight * 0.04,
                                  width: screenWidth * 0.2,
                                  decoration: BoxDecoration(
                                      color: widget.customerList!
                                              .elementAt(index)
                                              .isReviewSent
                                          ? Colors.green
                                          : Color(0xffee3925),
                                      borderRadius: BorderRadius.circular(4)),
                                  child: Center(
                                      child: Text(
                                    widget.customerList!
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
                  })

              // Padding(
              //   padding: const EdgeInsets.only(bottom: 12.0),
              //   child: Row(
              //     children: [
              //       Checkbox(
              //           value: widget.customerList!.elementAt(index).isSelected,
              //           onChanged: ((value) {
              //             if (value != null) {
              //               setState(() {
              //                 widget.customerList![index].isSelected = value;
              //               });
              //             }
              //           })),
              //       Text("${widget.customerList!.elementAt(index).customerName}"),
              //       Spacer(),
              //       GestureDetector(
              //           onTap: () {
              //             setState(() {
              //               widget.customerList![index].isReviewSent = true;
              //             });
              //           },
              //           child: Container(
              //               height: screenHeight * 0.04,
              //               width: screenWidth * 0.2,
              //               decoration: BoxDecoration(
              //                   color: widget.customerList!
              //                           .elementAt(index)
              //                           .isReviewSent
              //                       ? Colors.green
              //                       : Color(0xffee3925),
              //                   borderRadius: BorderRadius.circular(4)),
              //               child: Center(
              //                   child: Text(
              //                 widget.customerList!.elementAt(index).isReviewSent
              //                     ? "Review sent"
              //                     : "Send Review",
              //                 style: TextStyle(
              //                     fontSize: fontFactor * 11,
              //                     color: Colors.white),
              //               )))),
              //     ],
              //   ),
              //);
              ),
        ),
      ]),
    );
  }
}
