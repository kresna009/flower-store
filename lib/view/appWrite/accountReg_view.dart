import 'package:flower_store/model/model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flower_store/controllers/AccountController.dart';

int _selectedIndex = 4;

class CreateAccountPage extends StatelessWidget {
  final AccountController accountController = Get.put(AccountController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController userIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create AppWrite Account',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Color(0xFFFFDDE4),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextFormField(
              controller: userIdController,
              decoration: InputDecoration(labelText: 'User ID'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                accountController.createAccount({
                  'userId': userIdController.text,
                  'email': emailController.text,
                  'password': passwordController.text,
                  'name': nameController.text,
                });
              },
              child: Text('Create Account'),
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
}

List<BottomNavBarItem> _bottomNavBarItems = [
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
