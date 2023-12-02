import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flower_store/controllers/AccountController.dart';

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
        title: Text('Create Account'),
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
    );
  }
}

void main() {
  runApp(GetMaterialApp(
    home: CreateAccountPage(),
  ));
}
