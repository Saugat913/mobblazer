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
    var screenWidth=MediaQuery.of(context).size.width;
    var screenHeight=MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: isMain
            ? Builder(builder: (context) {
                return IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: Icon(Icons.menu,color: Colors.black,));
              })
            : IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.arrow_back,color: Colors.black,)),
        title: Text(
          "${pageTitle}",
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600,color: Colors.black),
        ),
      ),
      drawer: Drawer(child: CustomDrawer(),),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              padding:EdgeInsets.fromLTRB(screenWidth*0.02, screenHeight*0.01, screenWidth*0.02, screenHeight*0.01),
              child: ListView.builder(
                itemExtent: screenHeight*0.13,
                  itemCount: businessList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black26, width: 1),
                          borderRadius: BorderRadius.circular(9),
                        ),
                      child: Center(
                        child: ListTile(
                          leading: Icon(Icons.business),
                          title: Text(
                            "${businessList.elementAt(index)}",
                            style: TextStyle(fontSize: 18),
                          ),
                          trailing: Icon(Icons.arrow_forward_ios),
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
