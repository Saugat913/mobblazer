import 'package:flutter/material.dart';
import 'package:mobblazers/components/CustomDrawer.dart';
import 'package:mobblazers/screen/ListPage/BusinessListPage.dart';
import 'package:mobblazers/screen/ListPage/CustomerList.dart';

class LocationListPage extends StatelessWidget {
  LocationListPage({super.key, required this.isMain, required this.pageTitle});
  bool isMain;
  String pageTitle;
  List<String> locationlist = [
    "Winnipeg, Manitoba",
    "Calgary, Alberta",
    "Banff, Alberta",
    "Thunder Bay, Ontario",
    "Ottawa, Ontario",
    "Montreal, Quebec",
    "Toronto, Ontario"
  ];
  @override
  Widget build(BuildContext context) {
    var screenWidth=MediaQuery.of(context).size.width;
    var screenHeight=MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: Drawer(child: CustomDrawer()),
      appBar: AppBar(
        leading: isMain
            ? Builder(builder: (context) {
                return IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: Icon(
                      Icons.menu,
                      color: Colors.black,
                    ));
              })
            : IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                )),
        title: Text(
          "${pageTitle}",
          style: TextStyle(
              fontSize: 19, fontWeight: FontWeight.w600, color: Colors.black),
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
              padding:EdgeInsets.fromLTRB(screenWidth*0.02, screenHeight*0.01, screenWidth*0.02, screenHeight*0.01),
              child: ListView.builder(
                  itemCount: locationlist.length,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9),
                          side: BorderSide(color: Colors.black26)
                        ),
                      child: ListTile(
                        leading: Icon(Icons.location_on),
                        title: Text(
                          "${locationlist.elementAt(index)}",
                          style: TextStyle(fontSize: 18),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          if (isMain == true) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: ((context) => BusinessListPage(
                                    pageTitle:
                                        "Business List in ${locationlist.elementAt(index)}",
                                    isMain: false))));
                          } else {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: ((context) => CustomerListPage(
                                    businessName: pageTitle,
                                    businessLocation:
                                        locationlist.elementAt(index)))));
                          }
                        },
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
