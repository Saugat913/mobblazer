import 'package:flutter/material.dart';
import 'package:mobblazers/screen/LogIn.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    var screenHeight=MediaQuery.of(context).size.height; 
    var screenWidth=MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            children: [
              SizedBox(height: screenHeight*0.2,),
              Image.asset(
                "assets/images/name.png",
                 height: screenHeight*0.5,
                 width: screenWidth*0.7,
              ),
              Text(
                "Get Started",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 19,
              ),
              GestureDetector(
                onTap: (() {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: ((context) => LogInPage())));
                }),
                child: Container(
                  child: Center(child: Icon(Icons.arrow_forward,color: Colors.white,size: 34,)),
                  height: 70,
                  width: 70,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(35),color:Color.fromARGB(235, 228, 84, 17))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
