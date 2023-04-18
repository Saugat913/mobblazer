import 'package:flutter/material.dart';
import 'package:mobblazers/components/CustomDrawer.dart';
import 'package:mobblazers/models/business.dart';
import 'package:mobblazers/screen/ListPage/CustomerList.dart';
import 'package:mobblazers/screen/ListPage/LocationList.dart';
import 'package:mobblazers/services/rest_service.dart';

class BusinessListPage extends StatefulWidget {
  BusinessListPage(
      {super.key,
      required this.pageTitle,
      required this.isMain,
      required this.authentationCode });
  String pageTitle;
  bool isMain;
  String authentationCode;

  @override
  State<BusinessListPage> createState() => _BusinessListPageState();
}

class _BusinessListPageState extends State<BusinessListPage> {

  Future<BusinessData?> getBusinessData(String authentationCode) async {
    var businessData = await RestService.getAllBusinessData(
        authentationCode: authentationCode);
    return businessData;
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return FutureBuilder(
        future: getBusinessData(widget.authentationCode),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text(snapshot.error.toString()),
              ),
            );
          }
          if (snapshot.data == null || snapshot.data!.data == null) {
            return Scaffold(
              body: Center(
                child: Text("Some error has occured please try again!"),
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: widget.isMain
                  ? Builder(builder: (context) {
                      return IconButton(
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                          icon: Icon(
                            Icons.menu,
                            color: Colors.black,
                          ));
                    })
                  : IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      )),
              title: Text(
                "${widget.pageTitle}",
                style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
            ),
            drawer: Drawer(
              child: CustomDrawer(authentationCode: widget.authentationCode,),
            ),
            body: SafeArea(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(
                        screenWidth * 0.02,
                        screenHeight * 0.01,
                        screenWidth * 0.02,
                        screenHeight * 0.01),
                    child: ListView.builder(
                        itemExtent: screenHeight * 0.13,
                        itemCount: snapshot.data?.data.length,
                        itemBuilder: (context, index) {
                          return Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.black26, width: 1),
                              borderRadius: BorderRadius.circular(9),
                            ),
                            child: Center(
                              child: ListTile(
                                leading: Icon(Icons.business),
                                title: Text(
                                  "${snapshot.data?.data.elementAt(index).businessName}",
                                  style: TextStyle(fontSize: 18),
                                ),
                                trailing: Icon(Icons.arrow_forward_ios),
                                onTap: () {
                                  if (widget.isMain == true) {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => LocationListPage(
                                            isMain: false,
                                            pageTitle:
                                                "${snapshot.data?.data.elementAt(index).businessName} Location",authentationCode: widget.authentationCode,),),);
                                  } else {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: ((context) =>
                                                CustomerListPage(
                                                    businessName:
                                                        snapshot.data!.data.elementAt(index)!.businessName,
                                                    businessLocation:
                                                        widget.pageTitle))));
                                  }
                                },
                              ),
                            ),
                          );
                        }),
                  ),
                )
              ],
            )),
          );
        }));
  }
}
