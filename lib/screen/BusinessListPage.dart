import 'package:flutter/material.dart';
import 'package:mobblazers/screen/CustomerList.dart';

class BusinessListPage extends StatelessWidget {
  BusinessListPage({super.key, required String pageTitle}) {
    _pageTitle = pageTitle;
  }
  late final String _pageTitle;
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
      body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(onPressed: () {
            Navigator.of(context).pop();
          }, icon: Icon(Icons.arrow_back)),
          SizedBox(
            height: 14,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 17),
            child: Text(
              "Business List in ${_pageTitle}",
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
                        Navigator.of(context).push(MaterialPageRoute(builder: ((context) => CustomerListPage(businessName: businessList.elementAt(index), businessLocation:_pageTitle))));
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(17, 12, 17, 12),
                        margin: EdgeInsets.only(bottom: 27, left: 12, right: 12),
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
