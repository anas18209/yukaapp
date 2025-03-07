import 'package:flutter/material.dart';
import 'package:yukaapp/apiservices/historyservices.dart';
import 'package:yukaapp/model/producat_model.dart';

class Historyscreen extends StatefulWidget {
  @override
  State<Historyscreen> createState() => _HistoryscreenState();
}

class _HistoryscreenState extends State<Historyscreen> {
  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    await HistoryService.loadHistory();
    setState(() {});
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Color(0xffffffff),
        title: Text("Favorites", style: TextStyle(color: Color(0XFF00c965), fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            onPressed: () {
              HistoryService.clearHistory();
            },
            icon: Icon(Icons.delete_outline, color: Color(0XFF00c965)),
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.info_outline, color: Color(0XFF00c965))),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 19),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("History", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            Divider(
              color: Color(0xffebebec), // Change the color
              thickness: 1, // Set thickness
              height: 20, // Space around the divider
            ),
            Expanded(
              child: ListView.builder(
                itemCount: HistoryService.scannedProducts.length,
                itemBuilder: (context, index) {
                  Product product = HistoryService.scannedProducts[index];

                  return ListTile(
                    leading:
                        product.product.imageUrl != null && product.product.imageUrl!.isNotEmpty
                            ? Image.network(product.product.imageUrl!, width: 50)
                            : Icon(Icons.image_not_supported),
                    // leading: Image.network("", width: 50, height: 50, fit: BoxFit.cover),
                    title: Text(product.product.productName ?? '', style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Fritp lay", style: TextStyle(color: Colors.grey)),
                        Row(children: [Icon(Icons.circle, color: Colors.red, size: 12), SizedBox(width: 5), Text("Bad")]),
                        Text("Just now", style: TextStyle(color: Colors.grey, fontSize: 12)),
                        Container(
                          width: 600,
                          child: Divider(
                            color: Color(0xffebebec), // Change the color
                            thickness: 1, // Set thickness

                            height: 20,
                          ),
                        ),
                      ],
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
