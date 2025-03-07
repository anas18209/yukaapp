import 'package:flutter/material.dart';
import 'package:yukaapp/Constant/const.dart';

class CustomCircularProgress extends StatefulWidget {
  @override
  _CustomCircularProgressState createState() => _CustomCircularProgressState();
}

class _CustomCircularProgressState extends State<CustomCircularProgress> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: Duration(seconds: 3), vsync: this)..repeat();

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return customlogo(animation: _animation);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class customlogo extends StatelessWidget {
  const customlogo({super.key, required Animation<double> animation}) : _animation = animation;

  final Animation<double> _animation;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          size: Size(150, 150), // Set the size of the circle
          painter: CircularProgressPainter(_animation),
        ),
        // Add the image widget here
        Positioned(
          child: ClipOval(
            child: Image.asset(
              yukalogo, // Replace with your image path
              width: 90,
              height: 90,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}

class CircularProgressPainter extends CustomPainter {
  final Animation<double> progress;

  CircularProgressPainter(this.progress) : super(repaint: progress);

  @override
  void paint(Canvas canvas, Size size) {
    Paint circlePaint =
        Paint()
          ..color = Colors.grey.withOpacity(0.3)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 10;

    Paint progressPaint =
        Paint()
          ..color = Color(0xff42b37c)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 10
          ..strokeCap = StrokeCap.round;

    // Draw the background circle
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), size.width / 2, circlePaint);

    // Draw the progress arc
    double progressAngle = 2 * 3.141592653589793 * progress.value;
    canvas.drawArc(
      Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: size.width / 2),
      -3.141592653589793 / 2,
      progressAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
