import 'package:flutter/material.dart';
import 'package:mobblazers/models/appstate.dart';
import 'package:mobblazers/screen/AddCustomer.dart';
import 'package:mobblazers/screen/CustomerList.dart';
import 'package:mobblazers/services/rest_service.dart';
import 'package:mobblazers/models/customer.dart';

class CustomerListPage extends StatefulWidget {
  CustomerListPage(
      {super.key,
      required this.businessName,
      required this.businessLocation,
      required this.locationId,
      this.businessId});
  String businessName, businessLocation;
  int locationId;
  int? businessId;

  @override
  State<CustomerListPage> createState() => _CustomerListPageState();
}

class _CustomerListPageState extends State<CustomerListPage> {
  late Future<List<CustomerModel>?> status;

  Future<List<CustomerModel>?> getCustomerData() async {
    var customerData = await RestService.getCustomer("", widget.locationId);
    List<Datum> customerOfBusiness;
    if (widget.businessId == null) {
      customerOfBusiness = customerData.data;
    } else {
      customerOfBusiness = customerData.data;
    }

    List<CustomerModel> customerdata =
        List<CustomerModel>.generate(customerData.data.length, (index) {
      return CustomerModel(
          customerName: customerData.data.elementAt(index).firstName,
          isSelected: false,
          isReviewSent: false);
    });

    return customerdata;
  }

  @override
  void initState() {
    status = getCustomerData();
    super.initState();
  }

  bool isLoaded = true;
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
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () async {
                await Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => const AddCustomerPage())));
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
              widget.businessName,
              style: TextStyle(
                  fontSize: fontFactor * 17, fontWeight: FontWeight.w400),
            ),
            Text(
              widget.businessLocation,
              style: TextStyle(
                  fontSize: fontFactor * 17, fontWeight: FontWeight.w400),
            ),
            Expanded(
                child: FutureBuilder(
                    future: status,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.data == null) {
                        return Center(
                            child: Column(
                          children: [
                            SizedBox(
                              height: screenHeight * 0.2,
                            ),
                            const Text(
                                "You don't have any customers for this locations yet. Please add new customer to send review request"),
                            const SizedBox(
                              height: 12,
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return const AddCustomerPage();
                                  }));
                                },
                                child: Container(
                                    height: screenHeight * 0.04,
                                    width: screenWidth * 0.3,
                                    decoration: BoxDecoration(
                                        color: const Color(0xff363740),
                                        borderRadius: BorderRadius.circular(4)),
                                    child: Center(
                                      child: Text(
                                        "Add the customer",
                                        style: TextStyle(
                                            fontSize: fontFactor * 12,
                                            color: Colors.white),
                                      ),
                                    ))
                                //
                                ),
                          ],
                        ));
                      }

                      return CustomerList(customerList: snapshot.data);
                    })),

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
          ],
        ),
      ),
    );
  }
}
