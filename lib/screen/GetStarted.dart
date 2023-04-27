import 'package:flutter/material.dart';
import 'package:mobblazers/screen/LogIn.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    var screenHeight=MediaQuery.of(context).size.height; 
    var screenWidth=MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: screenHeight*0.2,),
            Image.asset(
              "assets/images/name.png",
               height: screenHeight*0.5,
               width: screenWidth*0.7,
            ),
            const Text(
              "Get Started",
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 19,
            ),
            GestureDetector(
              onTap: (()async {
                final sharedInstance=await SharedPreferences.getInstance();
                sharedInstance.setBool("isVisited", true);
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: ((context) => LogInPage())));
              }),
              child: Container(
                height: 70,
                width: 70,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(35),color:const Color.fromARGB(235, 228, 84, 17)),
                child: const Center(child: Icon(Icons.arrow_forward,color: Colors.white,size: 34,))),
            )
          ],
        ),
      ),
    );
  }
}
