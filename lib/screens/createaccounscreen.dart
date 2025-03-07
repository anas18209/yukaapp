import 'package:flutter/material.dart';
import 'package:yukaapp/apiservices/authservices.dart';
import 'package:yukaapp/screens/welcomescnnerscreen.dart';
import 'package:yukaapp/widget/customcirculeranimation.dart';

class Createaccounscreen extends StatefulWidget {
  final TextEditingController controller;
  Createaccounscreen({super.key, required this.controller});

  @override
  State<Createaccounscreen> createState() => _CreateaccounscreenState();
}

class _CreateaccounscreenState extends State<Createaccounscreen> {
  TextEditingController firstnamecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  bool ispasswordvisible = false;
  bool isFirstNameFocused = false; // Track focus state for the first name field
  bool isPasswordEntered = false; // Track if password has been typed
  bool isNextButtonEnabled = false; // Track if the 'Next' button should be enabled

  @override
  void initState() {
    super.initState();
    // Add listeners to check if the fields are filled
    passwordcontroller.addListener(_checkFields);
    firstnamecontroller.addListener(_checkFields); // Listen to firstnamecontroller as well.
    widget.controller.addListener(_checkFields); // Listen to widget.controller for email.
  }

  void _checkFields() {
    setState(() {
      // Enable the "Next" button if all fields are not empty
      isNextButtonEnabled = widget.controller.text.isNotEmpty && passwordcontroller.text.isNotEmpty && firstnamecontroller.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    // Remove listeners to avoid memory leaks
    passwordcontroller.removeListener(_checkFields);
    firstnamecontroller.removeListener(_checkFields);
    widget.controller.removeListener(_checkFields);
    super.dispose();
  }

  final AuthService _authService = AuthService();

  void createUser() async {
    print("createUser() method called"); // Add this print statement for debugging
    String email = widget.controller.text.trim();
    String password = passwordcontroller.text.trim();

    try {
      // Call the createUserWithEmailPassword method from AuthService
      var user = await _authService.createUserWithEmailPassword(email, password);

      if (user != null) {
        // Successfully created user
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("User created successfully!")));

        // Navigate to the next screen
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => Welcomescnnerscreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return SlideTransition(position: Tween<Offset>(begin: const Offset(0.0, -1.0), end: Offset.zero).animate(animation), child: child);
            },
          ),
        );
      } else {
        // Handle user creation failure
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("User creation failed!")));
      }
    } catch (e) {
      // Handle any errors that occur during user creation
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: ${e.toString()}")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff3f2f8),
      appBar: AppBar(
        backgroundColor: Color(0xfff3f2f8),
        centerTitle: true,
        title: Text("Create account", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        actions: [
          TextButton(
            onPressed:
                isNextButtonEnabled
                    ? () {
                      print("Next button pressed!"); // Add this print statement for debugging
                      createUser();
                    }
                    : null, // Disable button if not enabled
            child: Text(
              "Next",
              style: TextStyle(
                color: isNextButtonEnabled ? Colors.blue : Colors.grey, // Change color based on enable status
              ),
            ),
          ),
        ],
      ),
      body: Column(
        spacing: 40,
        children: [
          SizedBox(height: 10),
          CustomCircularProgress(), // CommonWidget(imagePath: welcomeImage),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.only(left: 20, right: 20),
              height: 144,
              width: double.infinity,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Color(0xffffffff)),
              child: Column(
                children: [
                  // Email Field
                  TextField(
                    controller: widget.controller,
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
                  Focus(
                    onFocusChange: (hasFocus) {
                      setState(() {
                        isFirstNameFocused = hasFocus;
                      });
                    },
                    child: TextField(
                      controller: firstnamecontroller,
                      onChanged: (value) {
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        hintText: "First name",
                        hintStyle: TextStyle(color: Color(0xffc5c5c7), fontSize: 15),
                        suffixIcon:
                            isFirstNameFocused && firstnamecontroller.text.isNotEmpty
                                ? IconButton(
                                  onPressed: () {
                                    setState(() {
                                      firstnamecontroller.clear();
                                    });
                                  },
                                  icon: Icon(Icons.clear_rounded),
                                )
                                : null,
                        border: UnderlineInputBorder(),
                        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xfff7f7f7), width: 1.5)),
                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xfff7f7f7), width: 2.0)),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text("First name", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xff010101))),
                        ),
                      ),
                    ),
                  ),
                  // Password Field
                  TextField(
                    controller: passwordcontroller,
                    obscureText: !ispasswordvisible,
                    onChanged: (value) {
                      setState(() {
                        isPasswordEntered = value.isNotEmpty;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "Choose password",
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
          ),
        ],
      ),
    );
  }
}
