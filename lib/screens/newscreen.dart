// import 'package:flutter/material.dart';
// import 'package:yukaapp/Constant/const.dart';

// class Newscreen extends StatefulWidget {
//   const Newscreen({super.key});

//   @override
//   State<Newscreen> createState() => _NewscreenState();
// }

// class _NewscreenState extends State<Newscreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(padding: const EdgeInsets.only(top: 80, left: 10), child: Customlist(imagepath: additiveslogo, title: "Additives", text: "7")),
//     );
//   }
// }

// class Customlist extends StatelessWidget {
//   final String title;
// final String? subtitle;

//   final String imagepath;
//   final String? text;

//   const Customlist({super.key, required this.imagepath, this.text, required this.title, this.subtitle});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           spacing: 17,
//           children: [
//             Image.asset(imagepath, fit: BoxFit.cover, height: 40),

//             // SizedBox(width: 20),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,

//               children: [
//                 Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                 Text("Additives with limited risk", style: TextStyle(color: Colors.grey)),
//                 Divider(thickness: 2, height: 20, color: Colors.red),
//               ],
//             ),
//             Spacer(),
//             Text(text ?? '', style: TextStyle(fontSize: 18)),
//             CircleAvatar(radius: 8, backgroundColor: Colors.amberAccent),
//             Icon(Icons.keyboard_arrow_down_sharp),
//           ],
//         ),
//       ],
//     );
//   }
// }
