import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:yukaapp/Constant/const.dart';
import 'package:yukaapp/screens/welcomescreen.dart';

class CommonWidget extends StatefulWidget {
  final String? imagePath;
  final String? title;
  final String? description;
  final bool showButton;
  final bool showAnimatedText;
  final bool isAnalysPage;

  const CommonWidget({
    Key? key,
    this.imagePath,
    this.title,
    this.description,
    this.showButton = false,
    this.showAnimatedText = false,
    this.isAnalysPage = false,
  }) : super(key: key);

  @override
  _CommonWidgetState createState() => _CommonWidgetState();
}

class _CommonWidgetState extends State<CommonWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  late Animation<Offset> imageani;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 500), // Control animation speed
      vsync: this,
    );

    _animation = Tween<Offset>(
      begin: Offset(0, 0.10), // Start position (slightly lower)
      end: Offset(0, 0), // Normal position
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut, // Smooth easing
      ),
    );

    imageani = Tween<Offset>(
      begin: Offset(0, 0.15), // Start position (slightly lower)
      end: Offset(0, 0), // Normal position
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut, // Smooth easing
      ),
    );

    _controller.forward(); // Start animation
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose animation controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation, // Apply the controlled animation
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SlideTransition(
            position: imageani,
            child: Container(
              decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              padding: EdgeInsets.all(14),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(widget.imagePath ?? '', width: 150, height: 150, fit: BoxFit.cover),
              ),
            ),
          ),
          SizedBox(height: 30),
          Text(widget.title ?? '', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold, fontFamily: 'Satisfy-Regular')),
          SizedBox(height: 20),
          Text(widget.description ?? '', textAlign: TextAlign.center, style: TextStyle(color: Colors.white70, fontSize: 16)),
          SizedBox(height: 150),
          if (widget.showAnimatedText)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedTextKit(
                  repeatForever: true, // Ensures the animation never stops
                  pause: Duration.zero, // Removes the pause between loops
                  animatedTexts: [
                    ColorizeAnimatedText(
                      'Slide to continue',
                      speed: Duration(milliseconds: 150), // Controls animation speed
                      textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // Set proper style
                      colors: colorizeColors, // Your color list
                      textAlign: TextAlign.center, // Align text properly
                      textDirection: TextDirection.rtl, // Use LTR for better animation
                    ),
                  ],
                ),
                Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
              ],
            ),
          if (widget.isAnalysPage) SizedBox(height: 20),
          if (widget.showButton)
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: Duration(milliseconds: 500), // Animation duration
                    pageBuilder: (context, animation, secondaryAnimation) => welcomescreen(), // Replace with your screen
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      const begin = Offset(0.0, 1.0); // Starts from bottom
                      const end = Offset.zero; // Ends at normal position
                      const curve = Curves.easeInOut;

                      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                      var offsetAnimation = animation.drive(tween);

                      return SlideTransition(position: offsetAnimation, child: child);
                    },
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color(0xff3c785a),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10), side: BorderSide(color: Color(0xff3c785a), width: 2)),
              ),
              child: Padding(padding: EdgeInsets.symmetric(horizontal: 80), child: Text("Let's go!")),
            ),
        ],
      ),
    );
  }
}
