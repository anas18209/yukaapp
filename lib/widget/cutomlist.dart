import 'package:flutter/material.dart';

class Customlist extends StatelessWidget {
  final String title;
  final String? subtitle;

  final String imagepath;
  final String? text;

  const Customlist({super.key, required this.imagepath, this.text, required this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          spacing: 10,
          children: [
            Image.asset(imagepath, fit: BoxFit.cover, height: 40),

            // SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                Text("Additives with limited risk", style: TextStyle(color: Colors.grey)),
                Divider(thickness: 2, height: 20, color: Colors.red),
              ],
            ),
            Spacer(),
            Text(text ?? '', style: TextStyle(fontSize: 13)),
            CircleAvatar(radius: 5, backgroundColor: Colors.amberAccent),
            Icon(Icons.keyboard_arrow_down_sharp),
          ],
        ),
      ],
    );
  }
}
