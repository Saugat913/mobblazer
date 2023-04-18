import 'package:flutter/material.dart';
import 'package:mobblazers/components/CustomDrawer.dart';
import 'package:mobblazers/models/dashboard.dart';
import 'package:mobblazers/services/rest_service.dart';

class DashBoard extends StatefulWidget {
  DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
 late int noOfBusiness;
  late int noOfLocations;
  bool isLoaded=false;
@override
  void initState() {
    super.initState();
    getData();
  }

  void getData()async{
    Dashboardmodel model= await RestService.getDashBoardData();
    noOfBusiness= int.parse(model.data.business);
    noOfLocations=int.parse(model.data.location);
    isLoaded=true;
  }
  @override
  Widget build(BuildContext context) {
    var screenWidth=MediaQuery.of(context).size.width;
    var screenHeight=MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: Drawer(
        width: screenWidth / 1.4,
        child: CustomDrawer(),
      ),
      appBar: AppBar(leading: Builder(builder: (context) {
              return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: Icon(Icons.menu,color: Colors.black,));
            }),
            title:  Text(
                "Dashboard",
                style: TextStyle(color: Colors.black),
              ), backgroundColor: Colors.transparent,elevation: 0,),
      body: SafeArea(
        child: isLoaded ? Container(
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
                      "${noOfBusiness}",
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
                      "${noOfLocations}",
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
        ):Center(child: CircularProgressIndicator(),),
      ),
    );
  }
}
