import 'package:flutter/material.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:yukaapp/apiservices/productservices.dart';
import 'package:yukaapp/model/producat_model.dart';

class BarcodeScannerScreen extends StatefulWidget {
  @override
  _BarcodeScannerScreenState createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen> {
  bool isScanning = true;

  Future<void> _startBarcodeScanner() async {
    final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => const SimpleBarcodeScannerPage()));

    if (result is String && result.isNotEmpty) {
      _onBarcodeScanned(result);
    }
  }

  void _onBarcodeScanned(String barcode) async {
    if (!isScanning) return;
    isScanning = false;

    ProductService productService = ProductService();
    Product? product = await productService.fetchProduct(barcode);

    if (product != null) {
      if (mounted) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailScreen(product: product)));
      }
    } else {
      if (mounted) {
        _showErrorDialog("Product not found.");
      }
      isScanning = true;
    }
  }

  void _showErrorDialog(String message) {
    if (!mounted) return;
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Error"),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  if (mounted) {
                    Navigator.pop(context);
                    isScanning = true;
                  }
                },
                child: const Text("OK"),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Scan Barcode")),
      body: Center(child: ElevatedButton(onPressed: _startBarcodeScanner, child: const Text("Start Scanner"))),
    );
  }
}

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.product.productName ?? '')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(product.product.imageUrl, height: 200, fit: BoxFit.cover),
            const SizedBox(height: 10),
            Text("Brand: ${product.product.brands}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text("Ingredients: ${product.product.ingredientsText}"),
            const SizedBox(height: 10),
            Text("Categories: ${product.product.categories.join(", ")}"),
            const SizedBox(height: 10),
            Text("Energy: ${product.product.nutriments.energyKcal} kcal"),
            Text("Carbohydrates: ${product.product.nutriments.carbohydrates} g"),
            Text("Proteins: ${product.product.nutriments.proteins} g"),
            Text("Fats: ${product.product.nutriments.fat} g"),
            Text("Sugars: ${product.product.nutriments.sugars} g"),
            Text("Salt: ${product.product.nutriments.salt} g"),
          ],
        ),
      ),
    );
  }
}
