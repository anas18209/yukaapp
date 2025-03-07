import 'package:flutter/material.dart';

import 'package:yukaapp/Constant/const.dart';
import 'package:yukaapp/widget/cirReveal_clipper.dart';
import 'package:yukaapp/widget/common_widget.dart';

class CircularRevealPage extends StatefulWidget {
  final Animation<double>? animation; // Accept external animation
  final int index; // Useful for color differentiation

  const CircularRevealPage({Key? key, required this.index, this.animation}) : super(key: key);

  @override
  _CircularRevealPageState createState() => _CircularRevealPageState();
}

class _CircularRevealPageState extends State<CircularRevealPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    if (widget.animation == null) {
      _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 300))..forward();

      _animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    } else {
      _animation = widget.animation!;
    }
  }

  @override
  void dispose() {
    if (widget.animation == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ClipPath(
          clipper: CircularRevealClipper(_animation.value),
          child: Container(
            color: _getBackgroundColor(widget.index),
            child: Stack(
              children: [
                Positioned(
                  bottom: 100,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (index) {
                      return widget.index == index
                          ? (index == 0
                              ? // Example Usage:
                              CommonWidget(
                                imagePath: welcomeImage,
                                title: 'Welcome !',
                                description: "Yuka is a completely independent app that \n helps you choose the right products",
                                showAnimatedText: true,
                              )
                              : index == 1
                              ? CommonWidget(
                                isAnalysPage: true,
                                title: "Product Analysis",
                                description: "Yuka scans products and assesses their \n health benefites",
                                imagePath: analysisImage,
                                showAnimatedText: false,
                                showButton: false,
                              )
                              : CommonWidget(
                                imagePath: recommendImage,
                                title: "Recommendation",
                                description: "Yuka recommends healthier alternative",
                                showAnimatedText: false,
                                showButton: true,
                              ))
                          : Container();
                    }),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Color _getBackgroundColor(int index) {
    switch (index) {
      case 0:
        return Color(0xff66b584);
      case 1:
        return Color(0xfff0855b);
      case 2:
        return Color(0xff66b584);
      default:
        return Colors.white;
    }
  }
}
