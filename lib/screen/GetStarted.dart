import 'package:flutter/material.dart';
import 'package:mobblazers/screen/LogIn.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 3,
            ),
            Container(
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/name.png",
                    height: 150,
                    width: 200,
                  ),
                  SizedBox(
                    height: 12,
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
                      Navigator.of(context).push(MaterialPageRoute(builder: ((context) => LogInPage())));
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
          ],
        ),
      ),
    );
  }
}
