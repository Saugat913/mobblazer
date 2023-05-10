import 'package:flutter/material.dart';
import 'package:mobblazers/components/CustomTextButton.dart';
import 'package:mobblazers/services/rest_service.dart';

class CustomerModel {
  CustomerModel(
      {required this.customerName,
      required this.isSelected,
      required this.isReviewSent,
      required this.customerId});
  String customerName;
  bool isSelected;
  bool isReviewSent;
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

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var fontFactor =
        ((screenWidth * screenHeight) / (screenHeight + screenWidth)) * 0.004;
    return Container(
      padding: const EdgeInsets.all(12),
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
              text: "Bulk Send",
              onTap: () async {
                List<int> selectedCustomerId = [];
                for (var element in widget.customerList!) {
                  if (element.isSelected == true) {
                    selectedCustomerId.add(element.customerId);
                  }
                }
                await RestService.sendReviewBulk(
                    widget.locationId, selectedCustomerId);
                // after getting response dont know the response we change the state as review sent
                for (var element in widget.customerList!) {
                  if (selectedCustomerId.contains(element.customerId)) {
                    element.isReviewSent = true;
                  }
                }
                setState(() {});
              },
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
            title: const Text("Select all"),
            controlAffinity: ListTileControlAffinity.leading),
        Expanded(
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
                      Text(widget.customerList!.elementAt(index).customerName),
                      const Spacer(),
                      GestureDetector(
                          onTap: widget.customerList!
                                  .elementAt(index)
                                  .isReviewSent
                              ? () {}
                              : ()async {
                                  //TODO:Send the review of individual
                                  await RestService.sendReviewOf(widget.locationId,widget.customerList!.elementAt(index).customerId);
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
                                      ? Colors.grey
                                      : const Color(0xffee3925),
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
              }),
        ),
      ]),
    );
  }
}
