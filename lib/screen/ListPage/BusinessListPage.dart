import 'package:flutter/material.dart';
import 'package:mobblazers/components/CustomDrawer.dart';
import 'package:mobblazers/models/appstate.dart';
import 'package:mobblazers/screen/ListPage/LocationList.dart';
import 'package:mobblazers/services/rest_service.dart';
import 'package:mobblazers/screen/session.dart';

class BusinessListPage extends StatefulWidget {
  BusinessListPage(
      {super.key,
      required this.pageTitle,
      required this.isMain,
      required this.locationId});
  String pageTitle;
  int locationId;
  bool isMain;

  @override
  State<BusinessListPage> createState() => _BusinessListPageState();
}

class _BusinessListPageState extends State<BusinessListPage> {
  final appState = AppState.getInstance();
  late Future<List<Map<String, int>>?> status;

  Future<List<Map<String, int>>?> getBusinessData() async {
    if (widget.isMain == true && appState.businessList != null) {
      return appState.businessList!;
    }
    var businessData = await RestService.getAllBusinessData(
        authentationCode: appState.authentationCode!);

    if (businessData == null) {
      return null;
    }
    var businessList = List<Map<String, int>>.generate(
        businessData.data.length,
        (index) => {
              businessData.data.elementAt(index).businessName:
                  businessData.data.elementAt(index).id
            });
    return businessList;
  }

  @override
  void initState() {
    status = getBusinessData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return FutureBuilder(
        future: status,
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (snapshot.data == null) {
            return const SessionExpired();
            // sessionExpired(context);
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
                          icon: const Icon(
                            Icons.menu,
                            color: Colors.black,
                          ));
                    })
                  : IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      )),
              title: Text(
                widget.pageTitle,
                style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
            ),
            drawer:  Drawer(
              child: CustomDrawer(currentIndexPage: 1,),
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
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Card(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: Colors.black26, width: 1),
                              borderRadius: BorderRadius.circular(9),
                            ),
                            child: Center(
                              child: ListTile(
                                leading: const Icon(Icons.business),
                                title: Text(
                                  snapshot.data!.elementAt(index).keys.first,
                                  style: const TextStyle(fontSize: 18),
                                ),
                                trailing: const Icon(Icons.arrow_forward_ios),
                                onTap: () {
                                  //if (widget.isMain == true) {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => LocationListPage(
                                        isMain: false,
                                        businessId: snapshot.data!
                                            .elementAt(index)
                                            .values
                                            .first,
                                        pageTitle:
                                            "${snapshot.data!.elementAt(index).keys.first} Location",
                                      ),
                                    ),
                                  );
                                  // } else {
                                  //   Navigator.of(context).push(
                                  //       MaterialPageRoute(
                                  //           builder: ((context) =>
                                  //               CustomerListPage(
                                  //                   businessName:
                                  //                       snapshot
                                  //                           .data!
                                  //                           .elementAt(index)
                                  //                           .keys
                                  //                           .first,
                                  //                   businessLocation:
                                  //                       widget.pageTitle))));
                                  // }
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
