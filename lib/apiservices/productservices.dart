import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:yukaapp/model/producat_model.dart';

class ProductService {
  Future<Product?> fetchProduct(String barcode) async {
    final url = Uri.parse('https://us.openfoodfacts.org/api/v0/product/$barcode');

    try {
      final response = await http.get(url);
      print("🖥️ API Response Status: ${response.statusCode}");
      print("📜 API Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data.containsKey('product')) {
          return Product.fromJson(data);
        }
      }
    } catch (e) {
      print("Error fetching product: $e");
    }
    return null;
  }
}
// import 'package:flutter/material.dart';
// import 'package:yukaapp/screens/barcodescreen.dart';

// class BottomNavBarExample extends StatefulWidget {
//   @override
//   _BottomNavBarExampleState createState() => _BottomNavBarExampleState();
// }

// class _BottomNavBarExampleState extends State<BottomNavBarExample> {
//   int _currentIndex = 0;

//   final List<Widget> _pages = [HomeScreen(), SearchScreen(), BarcodeScannerScreen(), ProfileScreen(), SettingsScreen()];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xffffffff),
//       body: _pages[_currentIndex], // Display the selected page
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//         type: BottomNavigationBarType.fixed, // To allow more than 3 items
//         selectedItemColor: Colors.blue,
//         unselectedItemColor: Colors.grey,
//         items: [
//           BottomNavigationBarItem(icon: Icon(Icons.history_sharp), label: "History"),
//           BottomNavigationBarItem(icon: Icon(Icons.swap_horizontal_circle_outlined), label: "Recs"),
//           BottomNavigationBarItem(icon: Icon(Icons.qr_code_scanner_rounded), label: "Scan"),
//           BottomNavigationBarItem(icon: Icon(Icons.incomplete_circle_rounded), label: "Overview"),
//           BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
//         ],
//       ),
//     );
//   }
// }

// // Dummy Screens
// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(child: Text('Home Screen'));
//   }
// }

// class SearchScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(child: Text('Search Screen'));
//   }
// }

// class ProfileScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(child: Text('Profile Screen'));
//   }
// }

// class SettingsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(child: Text('Settings Screen'));
//   }
// }
