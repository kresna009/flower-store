import 'package:appwrite/appwrite.dart';
import 'package:flower_store/controllers/ClientController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DatabaseController extends ClientController {
  Databases? databases;
  @override
  void onInit() {
    super.onInit();
    databases = Databases(client);
  }

  Future storeUserName(Map map) async {
    try {
      final result = await databases!.createDocument(
        databaseId: "656a1d54766455b8728e",
        documentId: ID.unique(),
        collectionId: "656a1d749d956234915f",
        data: map,
        permissions: [
          Permission.read(Role.user("Test123")),
          Permission.update(Role.user("Test123")),
          Permission.delete(Role.user("Test123")),
        ],
      );
      print("DatabaseController:: storeUserName $databases");
    } catch (error) {
      Get.defaultDialog(
        title: "Error Database",
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
