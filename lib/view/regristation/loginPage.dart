import 'package:flower_store/controllers/controller.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatelessWidget {
  final RxBool isLoggedIn = false.obs;
  final FlowerController _flowerController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
        backgroundColor: Color(0xFFFFDDE4),
        actions: [
          Obx(() {
            if (_flowerController.isLoggedIn.value) {
              return IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  _flowerController.logout();
                },
              );
            } else {
              return SizedBox.shrink();
            }
          }),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Get.toNamed('/emailPage');
              },
              child: Text('Login with Email'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  UserCredential userCredential = await signInWithGoogle();
                  isLoggedIn.value = true;
                  print(
                      'Google Sign-In Successful: ${userCredential.user?.displayName}');
                  Get.offNamed('/home');
                } catch (e) {
                  print('Error during Google Sign-In: $e');
                }
              },
              child: Text('Login with Google'),
            ),
          ],
        ),
      ),
    );
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      throw FirebaseAuthException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Google Sign-In aborted by user',
      );
    }

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
