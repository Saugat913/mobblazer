import 'package:flutter/material.dart';
import 'package:mobblazers/components/CustomDrawer.dart';
import 'package:mobblazers/models/appstate.dart';
import 'package:mobblazers/models/business.dart';
import 'package:mobblazers/models/dashboard.dart';
import 'package:mobblazers/models/location.dart';
import 'package:mobblazers/screen/LogIn.dart';
import 'package:mobblazers/services/rest_service.dart';
import 'package:mobblazers/services/session.dart';

const errorMessage = "Session expired Please login again!";

class DashBoard extends StatefulWidget {
  DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  late Future status;

  final appState = AppState.getInstance();
  Future<bool> getData() async {
    if (appState.businessCount != null) {
      return true;
    }

    Dashboardmodel? dashboardModel = await RestService.getDashBoardData(
        authentationCode: appState.authentationCode!);
    BusinessData? businessModel = await RestService.getAllBusinessData(
        authentationCode: appState.authentationCode!);
    LocationData? locationModel = await RestService.getAllLocationData(
        authentationCode: appState.authentationCode!);

    if (dashboardModel == null ||
        locationModel == null ||
        businessModel == null) {
      return false;
    }
    appState.setData(
        int.parse(dashboardModel!.data!.location),
        int.parse(dashboardModel.data!.business),
        List<Map<String, int>>.generate(
            businessModel!.data!.length,
            (index) => {
                  businessModel.data.elementAt(index).businessName:
                      businessModel.data.elementAt(index).id
                }),
        List<Map<String, int>>.generate(
            locationModel!.data.length,
            (index) => {
                  locationModel.data.elementAt(index).locationName:
                      locationModel.data.elementAt(index).id
                }));
    return true;
  }

  @override
  void initState() {
    super.initState();
    status = getData();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return FutureBuilder(
        future: status,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (snapshot.data == false) {
            return SessionExpired();
            // sessionExpired(
            //     context); // the error in fetching occured only when session token has expired
          }
          return Scaffold(
            drawer: Drawer(
              width: screenWidth / 1.4,
              child: CustomDrawer(),
            ),
            appBar: AppBar(
              leading: Builder(builder: (context) {
                return IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: Icon(
                      Icons.menu,
                      color: Colors.black,
                    ));
              }),
              title: Text(
                "Dashboard",
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: SafeArea(
              child: Container(
                height: screenHeight,
                width: screenWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(17, 12, 17, 12),
                      height: screenHeight / 5.5,
                      width: screenWidth / 1.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        gradient: LinearGradient(
                          begin: Alignment(0, -1),
                          end: Alignment(0, 1),
                          colors: <Color>[Color(0xffe91d26), Color(0xfff36622)],
                          stops: <double>[0, 1],
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "BUSINESS",
                            style: TextStyle(color: Colors.white, fontSize: 19),
                          ),
                          Spacer(),
                          Text(
                            "${appState.businessCount}",
                            style: TextStyle(color: Colors.white, fontSize: 32),
                          ),
                          SizedBox(
                            width: 24,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screenHeight / 8,
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(17, 12, 17, 12),
                      height: screenHeight / 5.5,
                      width: screenWidth / 1.2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9),
                          border: Border.all(color: Colors.black26),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              offset: const Offset(
                                5.0,
                                5.0,
                              ),
                              blurRadius: 10.0,
                              spreadRadius: 2.0,
                            ),
                            BoxShadow(
                              color: Colors.white,
                              offset: const Offset(0.0, 0.0),
                              blurRadius: 0.0,
                              spreadRadius: 0.0,
                            ), // //Box
                          ]),
                      child: Row(
                        children: [
                          Text(
                            "LOCATION",
                            style: TextStyle(fontSize: 19),
                          ),
                          Spacer(),
                          Text(
                            "${appState.locationCount}",
                            style: TextStyle(fontSize: 32),
                          ),
                          SizedBox(
                            width: 24,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
