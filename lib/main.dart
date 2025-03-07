// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:yukaapp/firebase_options.dart';
import 'package:yukaapp/screens/bottomnavigationbar.dart';

import 'package:yukaapp/screens/createaccounscreen.dart';
import 'package:yukaapp/screens/emailscreen.dart';
import 'package:yukaapp/screens/newscreen.dart';
import 'package:yukaapp/screens/signinscreeen.dart';

import 'package:yukaapp/screens/welcome_slide_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   try {
//     await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   } catch (e) {
//     print("Firebase initialization error: $e");
//   }
//   runApp(const MyApp());
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), useMaterial3: true),
      home: WelcomeSlideScreen(),
    );
  }
}
