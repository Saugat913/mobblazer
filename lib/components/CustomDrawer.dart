import 'package:flutter/material.dart';
import 'package:mobblazers/models/appstate.dart';
import 'package:mobblazers/screen/DashBoard.dart';
import 'package:mobblazers/screen/ListPage/BusinessListPage.dart';
import 'package:mobblazers/screen/ListPage/LocationList.dart';
import 'package:mobblazers/screen/LogIn.dart';
import 'package:mobblazers/screen/ResetPassword.dart';
import 'package:mobblazers/screen/change_password.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: screenHeight,
      width: screenWidth / 2,
      child: Column(children: [
        Container(
          height: screenHeight * 0.3,
          width: screenWidth,
          color: const Color(0xfff36622),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: Image.asset(
                  "assets/images/user_profile.png",
                  height: screenHeight / 7,
                )),
                const Spacer(),
                ListTile(
                  title: Text(
                    "${AppState.getInstance().sharePreference!.getString("userName")}",
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    "${AppState.getInstance().sharePreference!.getString("userEmail")}",
                    style: const TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 14,
        ),
        Expanded(
          child: ListView(
            children: [
              ListTile(
                onTap: (() {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) =>
                          const DashBoard()))); // for temporary use dummy
                }),
                leading: const Icon(Icons.home),
                title: const Text("DashBoard"),
              ),
              const Divider(),
              ListTile(
                onTap: (() {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => BusinessListPage(
                            pageTitle: "Business List",
                            isMain: true,
                            //-1 mean garbage value becoz its main page no need of business id
                            locationId: -1,
                          ))));
                }),
                leading: const Icon(Icons.business),
                title: const Text("Business"),
              ),
              ListTile(
                onTap: (() {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => LocationListPage(
                            pageTitle: "Location List",
                            isMain: true,
                            businessId:
                                -1, //-1 mean garbage value becoz its main page no need of business id
                          ))));
                }),
                leading: const Icon(
                  Icons.location_on_sharp,
                ),
                title: const Text("Location"),
              ),
              const Divider(),
              ListTile(
                onTap: (() {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => ChangePasswordPage())));
                }),
                leading: const Icon(
                  Icons.password_rounded,
                ),
                title: const Text("Change Password"),
              ),
              ListTile(
                onTap: (() {
                  AppState.getInstance()
                      .sharePreference!
                      .setBool("isLogin", false);
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: ((context) => LogInPage())));
                }),
                leading: const Icon(Icons.logout),
                title: const Text("Signout"),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
