import 'package:flutter/material.dart';
import 'package:mobblazers/models/appstate.dart';
import 'package:mobblazers/screen/DashBoard.dart';
import 'package:mobblazers/screen/ListPage/BusinessListPage.dart';
import 'package:mobblazers/screen/ListPage/LocationList.dart';
import 'package:mobblazers/screen/LogIn.dart';
import 'package:mobblazers/screen/change_password.dart';

class CustomeDrawerItem extends StatelessWidget {
  CustomeDrawerItem(
      {super.key,
      required this.title,
      required this.leadingIcon,
      this.color,
      this.onTap});
  Widget leadingIcon;
  String title;
  Color? color;
  void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        padding: const EdgeInsets.fromLTRB(15, 12, 15, 12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(9),
        ),
        child: Row(children: [
          leadingIcon,
          const SizedBox(
            width: 19,
          ),
          Text(title)
        ]),
      ),
    );
  }
}

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key, required this.currentIndexPage});
  int currentIndexPage;
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: screenHeight,
      //width: screenWidth / 2,
      child: Column(children: [
        Container(
          height: screenHeight * 0.3,
          width: screenWidth,
          color: const Color(0xFFF04924),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Center(
                    child: Image.asset(
                  "assets/images/user_profile.png",
                  height: screenHeight / 12,
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
          child: Padding(
            padding: const EdgeInsets.only(
                top: 14, bottom: 14, left: 25.0, right: 25),
            child: ListView(
              children: [
                //ListTile(
                //focusColor: Colors.grey,
                CustomeDrawerItem(
                  title: "Dashboard",
                  leadingIcon: const Icon(Icons.home),
                  color: currentIndexPage != 0
                      ? null
                      : Colors.grey.withOpacity(0.3),
                  //tileColor: currentIndexPage != 0 ? null : Colors.grey,
                  onTap: (() {
                    if (currentIndexPage != 0) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => const DashBoard())));
                    }
                    // for temporary use dummy
                  }),
                ),

                //leading: const Icon(Icons.home),
                //title: const Text("DashBoard"),
                //),

                const Divider(),
                CustomeDrawerItem(
                  color: currentIndexPage != 1
                      ? null
                      : Colors.grey.withOpacity(0.3),
                  onTap: (() {
                    if (currentIndexPage != 1) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => BusinessListPage(
                                pageTitle: "Business List",
                                isMain: true,
                                //-1 mean garbage value becoz its main page no need of business id
                              ))));
                    }
                  }),
                  title: "Business",
                  leadingIcon: const Icon(Icons.business),
                  //leading: const Icon(Icons.business),
                  //title: const Text("Business"),
                ),
                CustomeDrawerItem(
                  color: currentIndexPage != 2
                      ? null
                      : Colors.grey.withOpacity(0.3),
                  onTap: (() {
                    if (currentIndexPage != 2) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => LocationListPage(
                                pageTitle: "Location List",
                                isMain: true,
                                businessId:
                                    -1, //-1 mean garbage value becoz its main page no need of business id
                              ))));
                    }
                  }),
                  title: "Location",
                  //leading: const Icon(
                  leadingIcon: const Icon(Icons.location_on_sharp), //
                  //title: const Text("Location"),
                ),
                const Divider(),
                CustomeDrawerItem(
                  onTap: (() {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => const ChangePasswordPage())));
                  }),
                  leadingIcon: const Icon(
                    Icons.lock,
                  ),
                  title: "Change Password",
                ),
                CustomeDrawerItem(
                  onTap: (() {
                    AppState.getInstance()
                        .sharePreference!
                        .setBool("isLogin", false);
                    Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return const LogInPage();
                    }), (r) {
                      return false;
                    });
                    // Navigator.of(context).pushReplacement(
                    //     MaterialPageRoute(builder: ((context) => const LogInPage())));
                  }),
                  leadingIcon: const Icon(Icons.logout),
                  title: "Signout",
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
