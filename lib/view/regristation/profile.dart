import 'package:flower_store/model/model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flower_store/controllers/Controller.dart';

// ignore: must_be_immutable
class ProfilePage extends StatelessWidget {
  final FlowerController flowerController = Get.find();
  int _selectedIndex = 4;
  final RxBool isLoggedIn = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Color(0xFFFFDDE4),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome, ${flowerController.currentUserEmail}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                flowerController.logout();
                Get.offNamed("/");
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
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
        Get.toNamed("/profilePage");
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
