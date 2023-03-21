import 'package:flutter/material.dart';
import 'package:mobblazers/components/CustomDrawer.dart';

class DashBoard extends StatelessWidget {
  DashBoard({super.key});
  int noOfBusiness = 8;
  int noOfLocations = 3500;
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
        ),
      ),
    );
  }
}
