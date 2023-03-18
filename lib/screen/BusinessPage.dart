import 'package:flutter/material.dart';
import 'package:mobblazers/components/CustomDrawer.dart';




class BusinessPage extends StatelessWidget {
  const BusinessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(child: CustomDrawer(),width: MediaQuery.of(context).size.width/1.4,),
      body: SafeArea(child: Column(children: [
        IconButton(onPressed: (){
          Scaffold.of(context).openDrawer();
        }, icon: Icon(Icons.menu)),
        
      ],)),
    );
  }
}