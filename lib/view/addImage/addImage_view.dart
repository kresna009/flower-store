import 'dart:io';

import 'package:flower_store/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flower_store/controllers/controller.dart';

int _selectedIndex = 2;

class AddImage extends StatelessWidget {
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
                        primary: Color(0xFFFFDDE4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                      ),
                      child: Text(
                        'Simpan',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return ElevatedButton(
                  onPressed: searchController.pickImage,
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFFFDDE4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                  ),
                  child: Text(
                    'Pilih Gambar',
                    style: TextStyle(
                      color: Colors.black,
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
      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0, -2),
              blurRadius: 6,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            _bottomNavBarItems.length,
            (index) => buildBottomNavItem(index),
          ),
        ),
      ),
    );
  }

  static List<BottomNavBarItem> _bottomNavBarItems = [
    BottomNavBarItem(
      icon: Icons.home,
      action: () {
        Get.toNamed("/home");
      },
    ),
    BottomNavBarItem(
      icon: Icons.search,
      action: () {
        Get.toNamed("/webView");
      },
    ),
    BottomNavBarItem(
      icon: Icons.add,
      action: () {
        Get.toNamed("/addImage");
      },
    ),
    BottomNavBarItem(
      icon: Icons.list,
      action: () {
        Get.toNamed("/flowerList");
      },
    ),
    BottomNavBarItem(
      icon: Icons.person,
      action: () {
        Get.toNamed("/loginPage");
      },
    ),
  ];

  Widget buildBottomNavItem(int index) {
    return InkWell(
      onTap: () {
        _bottomNavBarItems[index].action();
      },
      child: Container(
        padding: EdgeInsets.all(10),
        child: Icon(
          _bottomNavBarItems[index].icon,
          size: 30,
          color: _selectedIndex == index ? Color(0xFFFFDDE4) : Colors.grey,
        ),
      ),
    );
  }
}
