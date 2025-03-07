import 'package:flutter/material.dart';
import 'package:yukaapp/Constant/const.dart';
import 'package:yukaapp/screens/bottomnavigationbar.dart';

class Welcomescnnerscreen extends StatefulWidget {
  const Welcomescnnerscreen({super.key});

  @override
  State<Welcomescnnerscreen> createState() => _WelcomescnnerscreenState();
}

class _WelcomescnnerscreenState extends State<Welcomescnnerscreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    // Animation Controller
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));

    // Slide animation from bottom to top
    _animation = Tween<Offset>(
      begin: const Offset(0, 1), // Start from bottom
      end: Offset.zero, // Move to normal position
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // Start the animation when screen appears
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff48b87f),
      body: SlideTransition(
        position: _animation, // Apply slide transition animation
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(radius: 150, child: Image.asset(maskGroup)),
              SizedBox(height: 40),
              Text("Yuka scans the barcodes of your", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20)),
              Text("products to analyse them", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20)),
              SizedBox(height: 40),
              SizedBox(
                width: 325,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => BottomNavBarExample(),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          return SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0, 1), // Start from bottom
                              end: Offset.zero, // Move to normal position
                            ).animate(animation),
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffe7a57),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text("Scan my 1st product", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
