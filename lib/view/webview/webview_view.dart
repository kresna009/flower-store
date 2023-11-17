import 'package:flower_store/model/model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.disabled)
    ..loadRequest(Uri.parse('https://www.flower-db.com/en'));

  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "WebView",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Color(0xFFFFDDE4),
      ),
      body: WebViewWidget(controller: controller),
      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0, -2),
              blurRadius: 6,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            _bottomNavBarItems.length,
            (index) => buildBottomNavItem(index),
          ),
        ),
      ),
    );
  }

  static List<BottomNavBarItem> _bottomNavBarItems = [
    BottomNavBarItem(
      icon: Icons.home,
      action: () {
        Get.toNamed("/home");
      },
    ),
    BottomNavBarItem(
      icon: Icons.search,
      action: () {
        Get.toNamed("/webView");
      },
    ),
    BottomNavBarItem(
      icon: Icons.add,
      action: () {
        Get.toNamed("/addImage");
      },
    ),
    BottomNavBarItem(
      icon: Icons.list,
      action: () {
        Get.toNamed("/flowerList");
      },
    ),
    BottomNavBarItem(
      icon: Icons.person,
      action: () {
        Get.toNamed("/loginPage");
      },
    ),
  ];

  Widget buildBottomNavItem(int index) {
    return InkWell(
      onTap: () {
        _bottomNavBarItems[index].action();
      },
      child: Container(
        padding: EdgeInsets.all(10),
        child: Icon(
          _bottomNavBarItems[index].icon,
          size: 30,
          color: _selectedIndex == index ? Color(0xFFFFDDE4) : Colors.grey,
        ),
      ),
    );
  }
}
