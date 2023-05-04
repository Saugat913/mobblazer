import 'package:flutter/material.dart';
import 'package:mobblazers/components/CustomDrawer.dart';
import 'package:mobblazers/models/appstate.dart';
import 'package:mobblazers/screen/ListPage/CustomerListPage.dart';
import 'package:mobblazers/services/rest_service.dart';
import 'package:mobblazers/screen/session.dart';

class LocationListPage extends StatefulWidget {
  LocationListPage(
      {super.key,
      required this.isMain,
      required this.pageTitle,
      required this.businessId});
  bool isMain;
  int businessId;
  String pageTitle;

  @override
  State<LocationListPage> createState() => _LocationListPageState();
}

class _LocationListPageState extends State<LocationListPage> {
  final appState = AppState.getInstance();
  late Future<List<Map<String, int>>?> status;

  Future<List<Map<String, int>>?> getLocationData() async {
    if (widget.isMain == true && appState.locationList != null) {
      return appState.locationList!;
    }
    var locationData = await RestService.getLocationByBusinessData(
        widget.businessId,
        authentationCode: appState.authentationCode!);

    // if (locationData == null) {
    //   return null;
    // }
    var locationList = List<Map<String, int>>.generate(
        locationData.data.length,
        (index) => {
              locationData.data.elementAt(index).locationName:
                  locationData.data.elementAt(index).id
            });
    return locationList;
  }

  @override
  void initState() {
    status = getLocationData();
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
          }
          return Scaffold(
            drawer: const Drawer(child: CustomDrawer()),
            appBar: AppBar(
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
                    child: snapshot.data!.isEmpty
                        ? const Center(
                            child:
                                Text("Sorry there is no location available!"),
                          )
                        : ListView.builder(
                            itemExtent: screenHeight * 0.13,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(9),
                                    side: const BorderSide(
                                        color: Colors.black26)),
                                child: Center(
                                  child: ListTile(
                                    leading: const Icon(Icons.location_on),
                                    title: Text(
                                      snapshot.data!
                                          .elementAt(index)
                                          .keys
                                          .first,
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                    trailing:
                                        const Icon(Icons.arrow_forward_ios),
                                    onTap: () {
                                      // if (widget.isMain == true) {
                                      //   Navigator.of(context).push(
                                      //       MaterialPageRoute(
                                      //           builder: ((context) =>
                                      //               BusinessListPage(
                                      //                 pageTitle:
                                      //                     "Business List in ${snapshot.data!.elementAt(index).keys.first}",
                                      //                 isMain: false,
                                      //                 locationId: snapshot.data!
                                      //                     .elementAt(index)
                                      //                     .values
                                      //                     .first,
                                      //               ))));
                                      // } else {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: ((context) =>
                                                  CustomerListPage(
                                                    businessName:
                                                        widget.pageTitle,
                                                    businessLocation: snapshot
                                                        .data!
                                                        .elementAt(index)
                                                        .keys
                                                        .first,
                                                    locationId: snapshot.data!
                                                        .elementAt(index)
                                                        .values
                                                        .first,
                                                        businessId: widget.isMain != true ?widget.businessId:null,
                                                  ))));
                                      //}
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
