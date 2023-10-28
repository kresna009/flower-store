import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flower_store/controllers/controller.dart';

class SearchView extends StatelessWidget {
  final FlowerController searchController = Get.put(FlowerController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Post Your Own Flowers',
          style: TextStyle(
            color: Colors.black,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(() {
              if (searchController.pickedImage.value != null) {
                return Column(
                  children: [
                    Image.file(searchController.pickedImage.value!),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        controller: searchController.titleController,
                        decoration: InputDecoration(labelText: 'Flower name'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        controller: searchController.descriptionController,
                        decoration:
                            InputDecoration(labelText: 'Desc your flower'),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: searchController.savePicture,
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                      ),
                      child: Text(
                        'Simpan',
                        style: TextStyle(
                          color: Colors.pink,
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return ElevatedButton(
                  onPressed: searchController.pickImage,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                  ),
                  child: Text(
                    'Pilih Gambar',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                );
              }
            }),
            Obx(() {
              if (searchController.flowerImages.isNotEmpty) {
                return ListView(
                  shrinkWrap: true,
                  children: searchController.flowerImages.map((flowerImage) {
                    return ListTile(
                      leading: Image.file(File(flowerImage.imagePath)),
                      title: Text(
                        flowerImage.title,
                        style: TextStyle(color: Colors.black),
                      ),
                      subtitle: Text(
                        flowerImage.description,
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  }).toList(),
                );
              } else {
                return Container();
              }
            }),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(
    GetMaterialApp(
      home: SearchView(),
    ),
  );
}
