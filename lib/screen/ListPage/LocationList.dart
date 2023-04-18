import 'package:flutter/material.dart';
import 'package:mobblazers/components/CustomDrawer.dart';
import 'package:mobblazers/models/location.dart';
import 'package:mobblazers/screen/ListPage/BusinessListPage.dart';
import 'package:mobblazers/screen/ListPage/CustomerList.dart';
import 'package:mobblazers/services/rest_service.dart';

class LocationListPage extends StatefulWidget {
  LocationListPage(
      {super.key,
      required this.isMain,
      required this.pageTitle,
      required this.authentationCode});
  bool isMain;
  String pageTitle;
  String authentationCode;

  @override
  State<LocationListPage> createState() => _LocationListPageState();
}

class _LocationListPageState extends State<LocationListPage> {
  Future<LocationData?> getLocationData(String authentationCode) async {
    var locationData = await RestService.getAllLocationData(
        authentationCode: authentationCode);
    return locationData;
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return FutureBuilder(
        future: getLocationData(widget.authentationCode),
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
            drawer: Drawer(child: CustomDrawer()),
            appBar: AppBar(
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
              backgroundColor: Colors.transparent,
              elevation: 0,
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
                                borderRadius: BorderRadius.circular(9),
                                side: BorderSide(color: Colors.black26)),
                            child: Center(
                              child: ListTile(
                                leading: Icon(Icons.location_on),
                                title: Text(
                                  "${snapshot.data?.data.elementAt(index).locationName}",
                                  style: TextStyle(fontSize: 18),
                                ),
                                trailing: Icon(Icons.arrow_forward_ios),
                                onTap: () {
                                  if (widget.isMain == true) {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: ((context) => BusinessListPage(
                                            pageTitle:
                                                "Business List in ${snapshot.data?.data.elementAt(index).locationName}",
                                            isMain: false,authentationCode: widget.authentationCode,))));
                                  } else {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: ((context) =>
                                                CustomerListPage(
                                                    businessName:
                                                        widget.pageTitle,
                                                    businessLocation: snapshot
                                                        .data!.data
                                                        .elementAt(index)
                                                        .locationName))));
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
