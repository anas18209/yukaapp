import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yukaapp/apiservices/authservices.dart';
import 'package:yukaapp/screens/bottomnavigationbar.dart';
import 'package:yukaapp/widget/customcirculeranimation.dart';

class Signinscreeen extends StatefulWidget {
  TextEditingController emailcontroller;
  Signinscreeen({super.key, required this.emailcontroller});

  @override
  State<Signinscreeen> createState() => _sigbnState();
}

class _sigbnState extends State<Signinscreeen> {
  TextEditingController passwordcontroller = TextEditingController();
  bool ispasswordvisible = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signIn() async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: widget.emailcontroller.text,
        password: passwordcontroller.text,
      );

      // If login is successful, navigate to the home or another page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BottomNavBarExample()), // Replace with your home page
      );
    } on FirebaseAuthException catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message ?? 'Error occurred')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f7),

      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              _signIn();
            },
            child: Text("Sign in"),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 90),
          child: Column(
            spacing: 30,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomCircularProgress(),
              Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.only(left: 20, right: 20),
                height: 98,
                width: double.infinity,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Color(0xffffffff)),
                child: Column(
                  children: [
                    // Email Field
                    TextField(
                      controller: widget.emailcontroller,
                      // controller: widget.controller,
                      decoration: InputDecoration(
                        hintText: "Enter your email",
                        hintStyle: TextStyle(color: Color(0xffc5c5c7), fontSize: 15),
                        border: UnderlineInputBorder(),
                        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xfff7f7f7), width: 1.5)),
                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xfff7f7f7), width: 2.0)),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text("Email", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xff010101))),
                        ),
                      ),
                    ),
                    // First Name Field

                    // Password Field
                    TextField(
                      controller: passwordcontroller,
                      obscureText: !ispasswordvisible,
                      onChanged: (value) {
                        setState(() {
                          // isPasswordEntered = value.isNotEmpty;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "Enter your password",
                        hintStyle: TextStyle(color: Color(0xffc5c5c7), fontSize: 15),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              ispasswordvisible = !ispasswordvisible;
                            });
                          },
                          icon: Icon(ispasswordvisible ? Icons.visibility : Icons.visibility_off),
                        ),
                        border: UnderlineInputBorder(),
                        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xfff7f7f7), width: 1.5)),
                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xfff7f7f7), width: 2.0)),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text("Password", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xff010101))),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
