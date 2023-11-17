import 'package:firebase_core/firebase_core.dart';
import 'package:flower_store/controllers/controller.dart';
import 'package:flower_store/view/addImage/addImage_view.dart';
import 'package:flower_store/view/dbAPI/dbAPI_view.dart';
import 'package:flower_store/view/home/home_view.dart';
import 'package:flower_store/view/regristation/regristationPage.dart';
import 'package:flower_store/view/webview/webview_view.dart';
import 'package:flower_store/view/welcome/welcome_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        ),
        GetPage(
          name: "/loginPage",
          page: () => RegistrationPage(),
        )
      ],
      initialRoute: "/",
    );
  }
}
