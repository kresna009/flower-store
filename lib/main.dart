import 'package:flower_store/controllers/controller.dart';
import 'package:flower_store/view/addImage/addImage_view.dart';
import 'package:flower_store/view/dbAPI/dbAPI_view.dart';
import 'package:flower_store/view/home/home_view.dart';
import 'package:flower_store/view/webview/webview_view.dart';
import 'package:flower_store/view/welcome/welcome_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
          name: "/",
          page: () => const WelcomeView(),
          binding: BindingsBuilder(
            () {
              Get.put(FlowerController());
            },
          ),
        ),
        GetPage(
          name: "/home",
          page: () => HomeView(),
        ),
        GetPage(
          name: "/addImage",
          page: () => AddImage(),
        ),
        GetPage(
          name: "/webView",
          page: () => const WebViewPage(),
        ),
        GetPage(
          name: "/flowerList",
          page: () => FlowerList(),
        )
      ],
      initialRoute: "/",
    );
  }
}
