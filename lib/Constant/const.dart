import 'package:flutter/material.dart';

const colorizeColors = [Colors.white, Colors.white, Colors.black87, Colors.white];

const colorizeTextStyle = TextStyle(fontSize: 20.0);

const subtitleTextStyle = TextStyle(color: Colors.white, fontSize: 18);

const String welcomeImage = "assets/images/carrot.png";
const String analysisImage = "assets/images/picana.png";
const String recommendImage = "assets/images/choco.png";
const String maskGroup = "assets/images/MaskGroup.png";
const String animatedfoodlogo = "assets/images/animatedfoodlogo.png";
const String animatedproductlogo = "assets/images/animatedproductlogo.png";
const String additiveslogo = "assets/images/additiveslogo.png";
const String energylogo = "assets/images/energylogo.png";
const String sugarlogo = "assets/images/sugar.png";
const String proteinlogo = "assets/images/protein.png";
const String fiberlogo = "assets/images/fiber.png";
const String sodiumlogo = "assets/images/sodium.png";
const String yukalogo = "assets/images/yukalogo.png";

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
