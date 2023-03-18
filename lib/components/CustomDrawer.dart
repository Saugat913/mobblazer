import 'package:flutter/material.dart';
import 'package:mobblazers/screen/BusinessPage.dart';
import 'package:mobblazers/screen/DashBoard.dart';
import 'package:mobblazers/screen/LocationList.dart';



class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});
String userName="Username";
String userEmail="random@gmail.com";
List<String> options=[
  "DashBoard",
  "Business",
  "Location",
  "Change Password",
  "Signout"
];
List<IconData> optionsIcons=[
  Icons.home,
  Icons.business,
  Icons.location_on_sharp,
  Icons.password_rounded,
  Icons.logout
];
List<Widget> optionsPage=[
  DashBoard(),
  LocationListPage(),
  LocationListPage(),
  LocationListPage(),
  LocationListPage(),

];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
       width: MediaQuery.of(context).size.width/2,
      child: Column(children: [
        Container(
          height: MediaQuery.of(context).size.height / 3,
          width: MediaQuery.of(context).size.width,
          color: Colors.redAccent,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              Center(child: Image.asset("assets/images/user_profile.png",height: MediaQuery.of(context).size.height/ 7,)),
              SizedBox(height: 8,),
              Text("${userName}",style: TextStyle(color: Colors.white),),
              SizedBox(height: 13,),
              Text("${userEmail}",style: TextStyle(color: Colors.white),),
              ],),
            ),
          ),
        ),
        Expanded(
          child: Container(
            child: ListView.builder(itemCount: options.length,itemBuilder: ((context, index) {
               return ListTile(onTap: (() {
                 Navigator.of(context).push(MaterialPageRoute(builder: ((context) => optionsPage.elementAt(index))));
               }),leading: Icon(optionsIcons.elementAt(index)),title: Text(options.elementAt(index)),);
            })),
          ),
        ),
        // ...List.generate(options.length, (index){
        //    return ListTile(onTap: (() {
        //      Navigator.of(context).push(MaterialPageRoute(builder: ((context) => BusinessPage())));
        //    }),leading: Icon(optionsIcons.elementAt(index)),title: Text(options.elementAt(index)),);
        // })
      ]),
    );
  }
}
