import 'package:flutter/material.dart';
import 'package:mobblazers/screen/DashBoard.dart';
import 'package:mobblazers/screen/ListPage/BusinessListPage.dart';
import 'package:mobblazers/screen/ListPage/LocationList.dart';
import 'package:mobblazers/screen/LogIn.dart';
import 'package:mobblazers/screen/ResetPassword.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});
  String userName = "Username";
  String userEmail = "random@gmail.com";
 
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight,
      width: screenWidth / 2,
      child: Column(children: [
        Container(
          height: screenHeight * 0.3,
          width: screenWidth,
          color: Color(0xfff36622),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: Image.asset(
                  "assets/images/user_profile.png",
                  height: screenHeight / 7,
                )),
                Spacer(),
                ListTile(
                  title: Text(
                    "${userName}",
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    "${userEmail}",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 14,
        ),
        Expanded(
          child: Container(
              child: ListView(
            children: [
              ListTile(
                onTap: (() {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: ((context) => DashBoard())));
                }),
                leading: Icon(Icons.home),
                title: Text("DashBoard"),
              ),
              Divider(),
              ListTile(
                onTap: (() {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => BusinessListPage(
                            pageTitle: "Business List",
                            isMain: true,
                          ))));
                }),
                leading: Icon(Icons.business),
                title: Text("Business"),
              ),
              ListTile(
                onTap: (() {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => LocationListPage(
                            pageTitle: "Location List",
                            isMain: true,
                          ))));
                }),
                leading: Icon(
                  Icons.location_on_sharp,
                ),
                title: Text("Location"),
              ),
              Divider(),
              ListTile(
                onTap: (() {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => ResetPasswordPage())));
                }),
                leading: Icon(
                  Icons.password_rounded,
                ),
                title: Text("Change Password"),
              ),
              ListTile(
                onTap: (() {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: ((context) => LogInPage())));
                }),
                leading: Icon(Icons.logout),
                title: Text("Signout"),
              )
            ],
          )),
        ),
      ]),
    );
  }
}
