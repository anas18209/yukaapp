import 'package:flutter/material.dart';
import 'package:yukaapp/Constant/const.dart';

class OverviewScreen extends StatefulWidget {
  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  bool isFoodSelected = true;
  void toggleSwitch() {
    setState(() {
      isFoodSelected = !isFoodSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f7),
      appBar: AppBar(
        backgroundColor: Color(0xfff2f2f7),

        title: const Text(""),

        elevation: 0,
        actions: [IconButton(icon: Icon(Icons.info_outline, color: Colors.green), onPressed: () {})],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isFoodSelected
                  ? const Text("My food", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold))
                  : const Text("My beauty", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),

              const SizedBox(height: 8),

              // Date Range
              isFoodSelected
                  ? Center(
                    child: const Text("17 January → 17 February", style: TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.bold)),
                  )
                  : Container(),
              const SizedBox(height: 20),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    isFoodSelected
                        ? Image.asset(animatedfoodlogo, fit: BoxFit.cover, height: 200)
                        : Image.asset(animatedproductlogo, fit: BoxFit.cover, height: 200),
                    SizedBox(height: 30),
                    GestureDetector(
                      onHorizontalDragUpdate: (details) {
                        if (details.primaryDelta! > 5) {
                          setState(() => isFoodSelected = false);
                        } else if (details.primaryDelta! < -2) {
                          setState(() => isFoodSelected = true);
                        }
                      },

                      child: Container(
                        width: 300,
                        height: 35,
                        decoration: BoxDecoration(color: Color(0xffe2e2e8), borderRadius: BorderRadius.circular(10)),
                        child: Stack(
                          children: [
                            AnimatedAlign(
                              alignment: isFoodSelected ? Alignment.centerLeft : Alignment.centerRight,
                              duration: const Duration(milliseconds: 300),
                              child: Container(
                                width: 150,
                                height: 40,
                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 5, spreadRadius: 1)],
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      if (!isFoodSelected) toggleSwitch();
                                    },
                                    child: Center(
                                      child: Text(
                                        "Food",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: isFoodSelected ? Colors.black : Colors.black54,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      if (isFoodSelected) toggleSwitch();
                                    },
                                    child: Center(
                                      child: Text(
                                        "Beauty",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: !isFoodSelected ? Colors.black : Colors.black54,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              Text("GRADING OVERVIEW", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xff87878d))),
              Padding(
                padding: const EdgeInsets.only(right: 10, top: 10),
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(color: Color(0xffffffff), borderRadius: BorderRadius.circular(6)),
                  child: ListView.builder(
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                CircleAvatar(radius: 7, backgroundColor: Colors.green),
                                SizedBox(width: 20),
                                Text("Excellent", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                SizedBox(width: 10),
                                Spacer(),

                                Text("0", style: TextStyle(fontSize: 18, color: Color(0xffc5c5c7))),
                                IconButton(onPressed: () {}, icon: Icon(size: 20, Icons.arrow_forward_ios_outlined, color: Color(0xffc5c5c7))),
                              ],
                            ),
                          ),
                          Divider(thickness: 1, indent: 40, color: Color(0xffeaeaea)),
                        ],
                      );
                      // return ListTile(
                      //   // contentPadding: EdgeInsets.all(2),
                      //   leading: CircleAvatar(radius: 5, backgroundColor: Colors.green),
                      //   title: Text("Excellent"),
                      //   trailing: ExpandIcon(child: Row(children: [Text("0"), IconButton(onPressed: () {}, icon: Icon(size: 20, Icons.arrow_forward_ios_outlined))])),
                      // );
                    },
                  ),
                ),
              ),
              SizedBox(height: 8),
              Text("1 unknown product", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xff87878d))),
            ],
          ),
        ),
      ),
    );
  }
}
