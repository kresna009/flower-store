import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:flower_store/model/model.dart';
import 'package:http/http.dart' as http;

class FlowerController extends GetxController {
  static FlowerController get i => Get.find();
  Size size = MediaQuery.of(Get.context!).size;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  Rx<File?> pickedImage = Rx<File?>(null);
  RxList<FlowerImageModel> flowerImages = <FlowerImageModel>[].obs;
  var plants = <Plant>[].obs;

  Future<void> pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      this.pickedImage.value = File(pickedImage.path);
    }
  }

  void onInit() {
    super.onInit();
    fetchPlantList();
  }

  Future<void> fetchPlantList() async {
    final apiKey = 'mlBKGsf6yXuElxvrjzxwWefdpaBl771xLEFhWsgCJRY';
    final apiUrl = 'https://trefle.io/api/v1/plants?token=$apiKey';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> plantList = data['data'];
        plants.value = plantList.map((item) => Plant.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load plant data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void savePicture() {
    if (pickedImage.value != null) {
      String title = titleController.text;
      String description = descriptionController.text;

      if (title.isNotEmpty && description.isNotEmpty) {
        FlowerImageModel flowerImage =
            FlowerImageModel(pickedImage.value!.path, title, description);
        flowerImages.add(flowerImage);

        titleController.clear();
        descriptionController.clear();
        pickedImage.value = null;
      }
    }
  }
}
