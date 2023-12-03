import 'package:firebase_core/firebase_core.dart';
import 'package:flower_store/controllers/AccountController.dart';
import 'package:flower_store/controllers/controller.dart';
import 'package:flower_store/view/appWrite/database_view.dart';
import 'package:flower_store/view/dbAPI/dbAPI_view.dart';
import 'package:flower_store/view/home/home_view.dart';
import 'package:flower_store/view/regristation/emailPage.dart';
import 'package:flower_store/view/regristation/loginPage.dart';
import 'package:flower_store/view/regristation/regristationPage.dart';
import 'package:flower_store/view/webview/webview_view.dart';
import 'package:flower_store/view/welcome/welcome_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'view/appWrite/accountReg_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Get.putAsync(() async => await SharedPreferences.getInstance());
  Get.put(AccountController());
  await FirebaseMessagingHandler().initPushNotification();
  await FirebaseMessagingHandler().initLocalNotification();
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
          page: () => DatabaseView(),
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
          name: "/regPage",
          page: () => RegistrationPage(),
        ),
        GetPage(
          name: "/loginPage",
          page: () => LoginPage(),
        ),
        GetPage(
          name: "/emailPage",
          page: () => EmailLogin(),
        ),
        GetPage(
          name: "/profilePage",
          page: () => CreateAccountPage(),
        )
      ],
      initialRoute: "/",
    );
  }
}
