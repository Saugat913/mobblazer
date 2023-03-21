import 'package:flutter/material.dart';
import 'package:mobblazers/components/CustomDrawer.dart';
import 'package:mobblazers/screen/ListPage/CustomerList.dart';
import 'package:mobblazers/screen/ListPage/LocationList.dart';

class BusinessListPage extends StatelessWidget {
  BusinessListPage({super.key, required this.pageTitle, required this.isMain});
  String pageTitle;
  bool isMain;
  final List<String> businessList = [
    "A&W Canada",
    "Pizza Nova",
    "Pita Pit",
    "KFC",
    "McDonald's",
    "Pizza Pizza",
    "Starbucks"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(child: CustomDrawer()),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isMain
              ? Builder(builder: (context) {
                  return IconButton(
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      icon: Icon(Icons.menu));
                })
              : IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back)),
          SizedBox(
            height: 14,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 17),
            child: Text(
              "${pageTitle}",
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: 14,
          ),
          Expanded(
            child: Container(
              child: ListView.builder(
                  itemCount: businessList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        if (isMain == true) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LocationListPage(
                                  isMain: false,
                                  pageTitle:
                                      "${businessList.elementAt(index)} Location")));
                        } else {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: ((context) => CustomerListPage(
                                  businessName: businessList.elementAt(index),
                                  businessLocation: pageTitle))));
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(17, 12, 17, 12),
                        margin:
                            EdgeInsets.only(bottom: 27, left: 12, right: 12),
                        height: MediaQuery.of(context).size.height / 11,
                        width: MediaQuery.of(context).size.width / 1.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9),
                          border: Border.all(color: Colors.black26),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 24,
                            ),
                            Text(
                              "${businessList.elementAt(index)}",
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          )
        ],
      )),
    );
  }
}
