import 'package:flutter/material.dart';
import 'package:yukaapp/widget/circular_reveal_page.dart';

class WelcomeSlideScreen extends StatefulWidget {
  @override
  _WelcomeSlideScreenState createState() => _WelcomeSlideScreenState();
}

class _WelcomeSlideScreenState extends State<WelcomeSlideScreen> with TickerProviderStateMixin {
  int _currentPage = 0;
  late AnimationController _animationController;
  late Animation<double> _animation;
  late int _nextPage;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500))..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _currentPage = _nextPage;
          _isAnimating = false;
        });
      }
    });

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));

    _nextPage = _currentPage;
  }

  void _onPageSwipe(DragEndDetails details) {
    if (_isAnimating) return;

    if (details.primaryVelocity != null && details.primaryVelocity! < -500) {
      // Swipe Left
      if (_currentPage < 2) {
        setState(() {
          _nextPage = _currentPage + 1;
          _isAnimating = true;
          _animationController.reset();
          _animationController.forward();
        });
      }
    } else if (details.primaryVelocity != null && details.primaryVelocity! > 500) {
      // Swipe Right
      if (_currentPage > 0) {
        setState(() {
          _nextPage = _currentPage - 1;
          _isAnimating = true;
          _animationController.reset();
          _animationController.forward();
        });
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onHorizontalDragEnd: _onPageSwipe,
        child: Stack(
          children: [
            // Background Page (Current page stays in background)
            Positioned.fill(child: CircularRevealPage(index: _currentPage)),

            // Foreground Animation (Next page animating into foreground)
            Positioned.fill(child: CircularRevealPage(animation: _animation, index: _nextPage)),

            // Bottom Navigation Indicators
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  bool isSelected = _currentPage == index;

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 500), // Smoother transition
                    curve: Curves.easeOutQuad, // Soft floating effect
                    width: isSelected ? 45 : 30,
                    height: isSelected ? 45 : 20,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected ? Colors.white.withOpacity(0.3) : Colors.transparent, // Less brightness
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2), // Keep it subtle
                        width: isSelected ? 1.5 : 1,
                      ),
                      boxShadow:
                          isSelected
                              ? [
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.2), // Softer glow
                                  blurRadius: 6,
                                  spreadRadius: 1,
                                  offset: Offset(0, 2), // Slight float effect
                                ),
                              ]
                              : [],
                    ),
                    child: Center(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 600),
                        switchInCurve: Curves.easeOutQuad,
                        switchOutCurve: Curves.easeInQuad,
                        transitionBuilder: (child, animation) {
                          return SlideTransition(
                            position: Tween<Offset>(
                              begin: Offset(0, 0.2), // Slightly lower at start
                              end: Offset(0, 0), // Moves up smoothly
                            ).animate(animation),
                            child: ScaleTransition(
                              scale: Tween<double>(begin: 0.9, end: 1).animate(animation), // Small pop effect
                              child: FadeTransition(opacity: animation, child: child),
                            ),
                          );
                        },
                        child: Icon(
                          isSelected ? _getPageIcon(index) : Icons.circle_outlined,
                          key: ValueKey(index),
                          color: Colors.white.withOpacity(0.5), // Softer color
                          size: isSelected ? 28 : 20,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

IconData _getPageIcon(int index) {
  switch (index) {
    case 0:
      return Icons.home_rounded;
    case 1:
      return Icons.search_rounded;
    case 2:
      return Icons.recommend;
    default:
      return Icons.circle;
  }
}
