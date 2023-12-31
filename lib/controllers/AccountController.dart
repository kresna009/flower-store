import 'package:appwrite/appwrite.dart';
import 'package:flower_store/controllers/ClientController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountController extends ClientController {
  Account? account;
  @override
  void onInit() {
    super.onInit();

    client = Client()
        .setEndpoint('https://cloud.appwrite.io/v1')
        .setProject('656a01667089bdef83d1');

    account = Account(client);
  }

Future<void> createAccount(Map<String, dynamic> map) async {
  try {
    if (account == null) {
      throw 'Account is not initialized';
    }
    final result = await account!.create(
      userId: map['userId'],
      email: map['email'],
      password: map['password'],
      name: map['name'],
    );
    print("AccountController:: createAccount $result");
  } catch (error) {
    // Menggunakan print untuk melihat pesan error selama pengujian
    print("Error Account: $error");

    // Cek apakah Get.context tidak null sebelum menggunakan
    if (Get.context != null) {
      Get.defaultDialog(
        title: "Error Account",
        titlePadding: const EdgeInsets.only(top: 15, bottom: 5),
        titleStyle: Get.context!.theme.textTheme.titleLarge,
        content: Text(
          "$error",
          style: Get.context!.theme.textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        contentPadding: const EdgeInsets.only(top: 5, left: 15, right: 15),
      );
    }
  }
}

  Future createEmailSession(Map map) async {
    try {
      final result = await account!.createEmailSession(
        email: map['email'],
        password: map['password'],
      );
      print("AccountController:: createEmailSession $result");
    } catch (error) {
      Get.defaultDialog(
        title: "Error Account",
        titlePadding: const EdgeInsets.only(top: 15, bottom: 5),
        titleStyle: Get.context?.theme.textTheme.titleLarge,
        content: Text(
          "$error",
          style: Get.context?.theme.textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        contentPadding: const EdgeInsets.only(top: 5, left: 15, right: 15),
      );
    }
  }
}
