import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flower_store/controllers/controller.dart';

class EmailLogin extends StatelessWidget {
  final FlowerController flowerController = Get.put(FlowerController());
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _loginWithEmailAndPassword() async {
    flowerController.isLoading.value = true;

    try {
      await flowerController.loginWithEmailAndPassword(
        _emailController.text,
        _passwordController.text,
      );
      Get.offNamed('/home');
    } catch (e) {
      print('Login Error: $e');
    } finally {
      flowerController.isLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Email Login'),
        backgroundColor: Color(0xFFFFDDE4),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loginWithEmailAndPassword,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
