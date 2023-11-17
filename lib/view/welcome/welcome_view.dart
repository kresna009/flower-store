import 'package:flower_store/controllers/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/bg.png',
            height: FlowerController.i.size.height,
            fit: BoxFit.fitHeight,
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                ),
                const Text(
                  "Griya Flower",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 48,
                  ),
                ),
                const Text(
                  "Explore the world of Flutter",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Image.asset('assets/images/deco.png'),
                GestureDetector(
                  onTap: () => Get.toNamed('/home'),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFFFDDE4),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    margin: const EdgeInsets.only(top: 0),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 30),
                    child: const Text(
                      "Get Started",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
