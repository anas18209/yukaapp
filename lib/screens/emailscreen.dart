import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yukaapp/screens/createaccounscreen.dart';
import 'package:yukaapp/screens/signinscreeen.dart';
import 'package:yukaapp/screens/signupscreen.dart';
import 'package:yukaapp/widget/customcirculeranimation.dart';

class Emailscreen extends StatefulWidget {
  Emailscreen({super.key});

  @override
  State<Emailscreen> createState() => _EmailscreenState();
}

class _EmailscreenState extends State<Emailscreen> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // final AuthService _authService = AuthService();

  // void _signIn() async {
  //   String email = _controller.text.trim();
  //   String password = _passwordController.text.trim();

  //   var user = await _authService.signIn(email, password);
  //   if (user != null) {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Signed in successfully!")));
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Sign in failed!")));
  //   }
  // }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  void showErrorDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color(0xffeeeef0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(17), // Optional: Rounded corners
          ),
          contentPadding: EdgeInsets.zero, // Removes default padding for better spacing
          content: Container(
            width: 50, // Increased dialog width
            constraints: BoxConstraints(minHeight: 70), // Set minimum height
            padding: EdgeInsets.only(top: 20), // Internal padding
            child: Column(
              mainAxisSize: MainAxisSize.min, // Keeps layout dynamic but not too small
              children: [
                Text("That email address", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text("isn't correct.", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

                SizedBox(height: 5), // Spacing before divider
                // Full-width Divider
                SizedBox(width: double.infinity, child: Divider(thickness: 0, color: Colors.grey)),

                TextButton(onPressed: () => Navigator.pop(context), child: Text("OK", style: TextStyle(fontWeight: FontWeight.bold))),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff3f2f8),

      appBar: AppBar(
        backgroundColor: Color(0xfff3f2f8),

        centerTitle: true,
        title: Text("Enter your email", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        actions: [
          TextButton(
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                if (isValidEmail(_controller.text)) {
                  final user = FirebaseAuth.instance.currentUser;

                  if (user == null) {
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return Createaccounscreen(controller: _controller);
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
                  } else {
                    // User is already signed in, navigate to the Sign-Up page or home
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Signinscreeen(emailcontroller: _controller)));
                  }
                } else {
                  showErrorDialog(); // Show error dialog if email is invalid
                }
              }
            },

            child: Text("Next", style: TextStyle(color: _controller.text.isNotEmpty ? Colors.blue : Colors.grey)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          spacing: 90,
          children: [
            CustomCircularProgress(), // CommonWidget(imagePath: welcomeImage),

            TextField(
              controller: _controller,

              decoration: InputDecoration(
                hintText: "Enter your email",
                hintStyle: TextStyle(fontSize: 14, color: Color(0xffc5c5c7)),
                suffixIcon:
                    _controller.text.isNotEmpty
                        ? IconButton(
                          color: Colors.black,
                          onPressed: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          icon: Icon(Icons.clear),
                        )
                        : null,

                prefixIcon: Padding(padding: const EdgeInsets.all(16.0), child: Text("Email", style: TextStyle(fontWeight: FontWeight.bold))),
                filled: true,

                fillColor: Color(0xffffffff),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}
