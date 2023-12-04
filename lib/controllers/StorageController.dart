import 'package:appwrite/appwrite.dart';
import 'package:flower_store/controllers/ClientController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StorageController extends ClientController {
  Storage? storage;

  @override
  void onInit() {
    super.onInit();
    storage = Storage(client);
  }

  Future<void> storeImage() async {
    try {
      final result = await storage!.createFile(
        bucketId: '656a07047fef6ede410e',
        fileId: ID.unique(),
        file: InputFile.fromPath(
          path: 'flower-store/assets/images/lily.png',
          filename: 'lily.png',
        ),
      );
      print("StorageController:: storeImage $result");
    } catch (error) {
      Get.defaultDialog(
        title: "Error Storage",
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
