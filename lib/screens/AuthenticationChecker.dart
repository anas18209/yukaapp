// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:yukaapp/screens/createaccounscreen.dart';
// import 'package:yukaapp/screens/signupsceen.dart';

// class AuthenticationChecker extends StatefulWidget {
//   @override
//   _AuthenticationCheckerState createState() => _AuthenticationCheckerState();
// }

// class _AuthenticationCheckerState extends State<AuthenticationChecker> {
//   @override
//   void initState() {
//     super.initState();
//     _checkAuthentication();
//   }

//   Future<void> _checkAuthentication() async {
//     // Check if the user is already signed in
//     final user = FirebaseAuth.instance.currentUser;

//     // If no user is signed in, navigate to the Sign-In page
//     if (user == null) {
//       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Createaccounscreen()));
//     } else {
//       // User is already signed in, navigate to the Sign-Up page or home
//       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Signupsceen()));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Show loading indicator while checking the user authentication status
//     return Scaffold(body: Center(child: CircularProgressIndicator()));
//   }
// }
