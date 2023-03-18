import 'package:flutter/material.dart';
import 'package:mobblazers/components/CustomTextButton.dart';
import 'package:mobblazers/screen/AddCustomer.dart';

class CustomerListPage extends StatefulWidget {
  CustomerListPage({super.key,required this.businessName,required this.businessLocation});
  String businessName,businessLocation;

  @override
  State<CustomerListPage> createState() => _CustomerListPageState();
}

class _CustomerListPageState extends State<CustomerListPage> {
  
  List<String> customerList = [
    "Customer 1",
    "Customer 1",
    "Customer 1",
    "Customer 1",
    "Customer 1",
  ];

  bool isAllSelected = false;
  late List<bool> isSelectedState;

  @override
  void initState() {
    super.initState();
    isSelectedState = List.generate(customerList.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var fontFactor=((screenWidth * screenHeight)/(screenHeight+screenWidth))*0.004;


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
                height: screenWidth*0.07,
                width: screenWidth*0.07,
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: screenWidth * 0.08),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${widget.businessName}",
                style: TextStyle(fontSize: fontFactor*17, fontWeight: FontWeight.w400),
              ),
              Text(
                "${widget.businessLocation}",
                style: TextStyle(fontSize: fontFactor * 17, fontWeight: FontWeight.w400),
              ),
              customerList.length == 0
                  ? Expanded(
                      child: Center(
                          child: Column(
                        children: [
                          SizedBox(
                            height: screenHeight * 0.2,
                          ),
                          Text(
                              "You don't have any customers for this locations yet. Please add new customer to send review request"),
                          SizedBox(
                            height: 12,
                          ),
                          GestureDetector(
                              onTap: () {},
                              child: Container(
                                height: screenHeight * 0.04,
                                width: screenWidth * 0.3,
                                decoration: BoxDecoration(color: Colors.orangeAccent,borderRadius: BorderRadius.circular(4)),
                                child:Center(child:Text("Add the customer",style: TextStyle(fontSize: fontFactor * 12),) ,)
                              )
                              //
                              ),
                        ],
                      )),
                    )
                  : SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Column(children: [
                          SizedBox(
                            height: 14,
                          ),
                          Row(
                            children: [
                              Text("Customer List",style: TextStyle(fontSize: fontFactor*15,fontWeight: FontWeight.w400),),
                              Spacer(),
                              CustomTextButton( height: screenHeight * 0.04,
                                  width: screenWidth * 0.2,text:"Bulk Send",onTap: (){},fontFactor: fontFactor,fontSize: 11,)
                              // TextButton(
                              //     onPressed: () {}, child: Text("Bulk Send"))
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
                                            i < isSelectedState.length;
                                            i++) {
                                          isSelectedState[i] = value;
                                        }
                                      });
                                    }
                                  }),
                              Text("Select all")
                            ],
                          ),
                          ...List.generate(customerList.length, (index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom:12.0),
                              child: Row(
                                children: [
                                  Checkbox(
                                      value: isSelectedState.elementAt(index),
                                      onChanged: ((value) {
                                        if (value != null) {
                                          setState(() {
                                            isSelectedState[index] = value;
                                          });
                                        }
                                      })),
                                  Text("${customerList.elementAt(index)}"),
                                  Spacer(),
                                  CustomTextButton( height: screenHeight * 0.04,
                                  width: screenWidth * 0.2,text: "Send Review",onTap: (){},fontFactor: fontFactor,fontSize: 11,)
                                  // TextButton(
                                  //     onPressed: () {}, child: Text("Send Review"))
                                ],
                              ),
                            );
                          })
                        ]),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
