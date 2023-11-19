import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flower_store/view/welcome/welcome_view.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:flower_store/model/model.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class FlowerController extends GetxController {
  static FlowerController get i => Get.find();
  Size size = MediaQuery.of(Get.context!).size;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  Rx<File?> pickedImage = Rx<File?>(null);
  RxList<FlowerImageModel> flowerImages = <FlowerImageModel>[].obs;
  var plants = <Plant>[].obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  RxBool isLoading = false.obs;
  final RxBool isLoggedIn = false.obs;

  // Define a getter for the current user's email
  String get currentUserEmail {
    firebase_auth.User? user = firebase_auth.FirebaseAuth.instance.currentUser;
    return user?.email ?? 'N/A';
  }

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      if (email.trim().isEmpty || password.trim().isEmpty) {
        // Display an error message if email or password is empty
        throw FirebaseAuthException(
          code: 'ERROR_INVALID_INPUT',
          message: 'Please enter both email and password.',
        );
      }

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      // Navigate to the next screen or perform other actions after successful login
      print('Email/Password Login Successful');
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase Auth exceptions
      print('Firebase Auth Exception: $e');
      // You can display an error message to the user based on the exception code
      // For example, check e.code and display an appropriate error message.
    } catch (e) {
      // Handle other exceptions
      print('Error during Email/Password Login: $e');
      // Display a generic error message to the user
    }
  }

  Future<void> registerUser(user) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
      Get.snackbar('Success', 'Registration successful',
          backgroundColor: Colors.green);
      Get.off(WelcomeView());
    } catch (error) {
      Get.snackbar('Error', 'Registration failed: $error',
          backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

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

  Future<void> logout() async {
    try {
      await _auth.signOut();
      Get.offAllNamed('/login'); 
    } catch (error) {
      print('Error during logout: $error');
    }
  }
}
