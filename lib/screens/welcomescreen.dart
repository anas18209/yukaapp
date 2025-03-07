import 'package:flutter/material.dart';

import 'package:yukaapp/screens/emailscreen.dart';
import 'package:yukaapp/widget/customcirculeranimation.dart';

class welcomescreen extends StatefulWidget {
  welcomescreen({super.key});

  @override
  State<welcomescreen> createState() => _SignupsceenState();
}

class _SignupsceenState extends State<welcomescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f7),
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xfff2f2f7),
        centerTitle: true,
        title: Text("Welcome", style: TextStyle(fontWeight: FontWeight.bold)),

        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0), // Adds spacing
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero, // Removes extra padding
              minimumSize: Size(0, 0), // Ensures a compact button
            ),
            child: Text("Cancel", style: TextStyle(fontSize: 14)),
          ),
        ),
      ),
      body: Center(
        child: Column(
          spacing: 300,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomCircularProgress(), // CommonWidget(imagePath: welcomeImage),
            Container(
              height: 50,
              width: 260,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return Emailscreen();
                      },
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        const begin = Offset(1.0, 0.0); // Start from the right
                        const end = Offset.zero; // End at the normal position
                        const curve = Curves.easeInOut; // You can change the curve for a different effect

                        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                        var offsetAnimation = animation.drive(tween);

                        return SlideTransition(position: offsetAnimation, child: child);
                      },
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff42b37c),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Adjust corner radius
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.mail, color: Colors.white, size: 23),
                    SizedBox(width: 20),
                    Text("Sign in with email", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
