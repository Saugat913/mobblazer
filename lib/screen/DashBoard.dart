import 'package:flutter/material.dart';
import 'package:mobblazers/components/CustomDrawer.dart';

class DashBoard extends StatelessWidget {
  DashBoard({super.key});
  int noOfBusiness = 8;
  int noOfLocations = 3500;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        width: MediaQuery.of(context).size.width / 1.4,
        child: CustomDrawer(),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Builder(builder: (context) {
              return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: Icon(Icons.menu));
            }),
            Padding(
              padding: const EdgeInsets.only(top: 12.0, left: 20),
              child: Text(
                "Dashboard",
                style: TextStyle(fontSize: 24),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 8,
            ),
            Center(
              child: Container(
                padding: EdgeInsets.fromLTRB(17, 12, 17, 12),
                height: MediaQuery.of(context).size.height / 7,
                width: MediaQuery.of(context).size.width / 1.2,
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
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 14,
            ),
            Center(
              child: Container(
                padding: EdgeInsets.fromLTRB(17, 12, 17, 12),
                height: MediaQuery.of(context).size.height / 7,
                width: MediaQuery.of(context).size.width / 1.2,
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
            ),
          ],
        ),
      ),
    );
  }
}
