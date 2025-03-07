import 'package:flutter/material.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:yukaapp/Constant/const.dart';
import 'package:yukaapp/apiservices/historyservices.dart';
import 'package:yukaapp/apiservices/productservices.dart';
import 'package:yukaapp/model/producat_model.dart';
import 'package:yukaapp/screens/historyscreen.dart';
import 'package:yukaapp/screens/overviewscreen.dart';
import 'package:yukaapp/screens/recommendationscreen.dart';
import 'package:yukaapp/screens/searchscreen.dart';
import 'package:yukaapp/widget/cutomlist.dart';

void main() {
  runApp(MaterialApp(home: BottomNavBarExample()));
}

class BottomNavBarExample extends StatefulWidget {
  @override
  _BottomNavBarExampleState createState() => _BottomNavBarExampleState();
}

class _BottomNavBarExampleState extends State<BottomNavBarExample> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    Historyscreen(),
    RecommendationsScreen(),
    ScanScreen(), // NEW: Scan screen instead of barcode scanner
    OverviewScreen(),
    SearchScreen(),
  ];

  void _onNavItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xfff5f5f5),
        currentIndex: _currentIndex,
        onTap: _onNavItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xff33c571),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.history_sharp), label: "History"),
          BottomNavigationBarItem(icon: Icon(Icons.swap_horizontal_circle_outlined), label: "Recs"),
          BottomNavigationBarItem(icon: Icon(Icons.qr_code_scanner_rounded), label: "Scan"), // SCAN SCREEN
          BottomNavigationBarItem(icon: Icon(Icons.incomplete_circle_rounded), label: "Overview"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
        ],
      ),
    );
  }
}

// SCAN SCREEN WITH SCANNER & PRODUCT DETAILS
class ScanScreen extends StatefulWidget {
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _openBarcodeScanner();
    });
  }

  void _openBarcodeScanner() async {
    final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => const SimpleBarcodeScannerPage()));

    if (result is String && result.isNotEmpty) {
      _onBarcodeScanned(result);
    } else {
      // If the user cancels the scan, return to home screen instead of showing blank
      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  void _onBarcodeScanned(String barcode) async {
    print("🔍 Scanned Barcode: $barcode");

    setState(() => isLoading = true);
    _showLoadingDialog();

    ProductService productService = ProductService();
    Product? product = await productService.fetchProduct(barcode.trim());

    if (mounted) {
      Navigator.pop(context); // Close loading dialog
      setState(() => isLoading = false);
    }

    if (product != null) {
      // Save product to history
      HistoryService.addProductToHistory(product);

      // Show the bottom sheet with product details
      _showProductBottomSheet(product);
    } else {
      // Show error if product not found
      _showProductBottomSheet(null);
    }
  }

  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [CircularProgressIndicator(), SizedBox(height: 10), Text("Fetching product...")],
            ),
          ),
    );
  }

  void _showProductBottomSheet(Product? product) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.4,
          minChildSize: 0.4,
          maxChildSize: 1,
          expand: false,
          builder: (_, scrollController) {
            return Container(
              padding: const EdgeInsets.all(16),
              child:
                  product != null
                      ? SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            product.product.imageUrl != null && product.product.imageUrl.isNotEmpty
                                ? Row(
                                  children: [
                                    Image.network(
                                      product.product.imageUrl!,
                                      height: 100,
                                      errorBuilder: (context, error, stackTrace) => Icon(Icons.broken_image),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        product.product.productName ?? "Unknown",
                                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                )
                                : Text("No image available"),
                            SizedBox(height: 8),

                            Text("Negatives", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                            SizedBox(height: 8),

                            Customlist(imagepath: additiveslogo, title: "Additives", text: "7"),
                            SizedBox(height: 8),
                            Customlist(imagepath: energylogo, title: "Energy", text: "${product.product.nutriments?.energykcalserving}kcal"),
                            SizedBox(height: 8),
                            Customlist(
                              imagepath: additiveslogo,
                              title: "Saturates",
                              text: "${product.product.nutriments.saturatedFat ?? "Unknown"}g",
                            ),
                            SizedBox(height: 8),
                            Customlist(imagepath: sugarlogo, title: "sugar", text: "${product.product.nutriments?.sugarsserving ?? "Unknown"}g"),
                            SizedBox(height: 8),
                            Text("Positives", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                            SizedBox(height: 8),

                            Customlist(imagepath: proteinlogo, title: "protein", text: "${product.product.nutriments?.proteins ?? "Unknown"}g"),
                            SizedBox(height: 8),

                            Customlist(imagepath: fiberlogo, title: "Fibre", text: "${product.product.nutriments?.fiber ?? "Unknown"}g"),
                            SizedBox(height: 8),

                            Customlist(imagepath: sodiumlogo, title: "Soudium", text: "${product.product.nutriments.sodium ?? "Unknown"}g"),

                            SizedBox(height: 8),
                            Text("Ingredients: ${product.product.ingredientsText ?? "Not available"}"),
                            SizedBox(height: 8),
                            Text("Categories: ${product.product.categories?.join(", ") ?? "Not available"}"),
                          ],
                        ),
                      )
                      : Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("❌ Product not found!", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                _openBarcodeScanner(); // Rescan
                              },
                              child: Text("Try Again"),
                            ),
                          ],
                        ),
                      ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
