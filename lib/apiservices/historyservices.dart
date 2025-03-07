import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yukaapp/model/producat_model.dart';

class HistoryService {
  static const String _historyKey = 'history';

  static List<Product> scannedProducts = [];

  // Save product to SharedPreferences
  static Future<void> addProductToHistory(Product product) async {
    final prefs = await SharedPreferences.getInstance();
    scannedProducts.add(product); // Add product to the in-memory list

    // Convert list of products to JSON string
    List<String> productJsonList = scannedProducts.map((product) => json.encode(product.toJson())).toList();

    // Save JSON string to SharedPreferences
    await prefs.setStringList(_historyKey, productJsonList);
  }

  // Load products from SharedPreferences
  static Future<void> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? productJsonList = prefs.getStringList(_historyKey);

    if (productJsonList != null) {
      scannedProducts =
          productJsonList.map((jsonStr) {
            return Product.fromJson(json.decode(jsonStr));
          }).toList();
    }
  }

  // Clear the history
  static Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_historyKey);
    scannedProducts.clear();
  }
}
