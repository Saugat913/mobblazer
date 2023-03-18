import 'package:flutter/material.dart';
import 'package:mobblazers/screen/DashBoard.dart';

class LogInPage extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(17.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Log In",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Form(
                  child: Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14)),
                      hintText: "Enter the email",
                      labelText: "Email",
                      contentPadding: EdgeInsets.only(left: 24, right: 24),
                      suffixIcon: Icon(Icons.email_outlined),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14)),
                        hintText: "Password",
                        labelText: "Password",
                        contentPadding: EdgeInsets.only(left: 24, right: 24),
                        suffixIcon: Icon(Icons.remove_red_eye)),
                  ),
                ],
              )),
              SizedBox(
                height: MediaQuery.of(context).size.height / 14,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: ((context) => DashBoard())));
                },
                child: Center(
                  child: Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width / 1.3,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(235, 228, 84, 17),
                        borderRadius: BorderRadius.circular(19)),
                    child: Center(
                      child: Text(
                        "LOG IN",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Row(
                children: [
                  Spacer(),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        "Forget Password?",
                        style: TextStyle(decoration: TextDecoration.underline),
                      )),
                ],
              )
              //  TextField(controller: emailController,decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(3))),),
              //  SizedBox(height: 17,),
              //  TextField(controller: passwordController,decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(3))),),
            ],
          ),
        ),
      ),
    );
  }
}
