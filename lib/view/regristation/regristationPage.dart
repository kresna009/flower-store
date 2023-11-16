import 'package:flower_store/controllers/controller.dart';
import 'package:flower_store/main.dart';
import 'package:flower_store/model/model.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FlowerController _authController = FlowerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                User user = User(
                  email: _emailController.text.trim(),
                  password: _passwordController.text.trim(),
                );
                _authController.registerUser(user);
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
