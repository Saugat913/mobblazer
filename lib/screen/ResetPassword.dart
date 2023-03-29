import 'package:flutter/material.dart';
import 'package:mobblazers/components/CustomDrawer.dart';
import 'package:mobblazers/screen/verification_page.dart';

class ResetPasswordPage extends StatefulWidget {
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(
                Icons.menu,
                color: Colors.black,
              ));
        }),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(17.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 8,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Reset Password",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Please enter your email address to request a password reset.",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.2),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14)),
                          hintText: "Enter the email",
                          labelText: "Email",
                          contentPadding: EdgeInsets.only(left: 24, right: 24),
                          suffixIcon: Icon(Icons.email_outlined),
                        ),
                      ),
                      //Yo validator check ek patak hernu parne xa
                      // validator: (value) {
                      //   if (value!.isEmpty) {
                      //     return 'Please enter your email';
                      //   }
                      //   return null;
                      // },
                    ],
                  )),
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: ((context) => VerificationPage())));
                },
                child: Center(
                  child: Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width / 1.4,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment(0, -1),
                          end: Alignment(0, 1),
                          colors: <Color>[Color(0xffe91d26), Color(0xfff36622)],
                          stops: <double>[0, 1],
                        ),
                        borderRadius: BorderRadius.circular(19)),
                    child: Center(
                      child: Text(
                        "SEND",
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
