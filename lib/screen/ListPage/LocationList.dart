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
    return Scaffold(
      drawer: Drawer(child: CustomDrawer()),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isMain?
          Builder(builder: (context) {
            return IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: Icon(Icons.menu));
          }):IconButton(onPressed: () {
            Navigator.of(context).pop();
          }, icon: Icon(Icons.arrow_back)),
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
                  itemCount: locationlist.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        if (isMain == true) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: ((context) => BusinessListPage(
                                    pageTitle:
                                        "Business List in ${locationlist.elementAt(index)}",isMain:false
                                  ))));
                        }else{
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: ((context) =>CustomerListPage(businessName: pageTitle, businessLocation: locationlist.elementAt(index)) )));
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
                              "${locationlist.elementAt(index)}",
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
