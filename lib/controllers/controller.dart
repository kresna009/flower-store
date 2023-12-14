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
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FlowerController extends GetxController {
  static FlowerController get i => Get.find();
  Size size = MediaQuery.of(Get.context!).size;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  Rx<File?> pickedImage = Rx<File?>(null);
  RxList<FlowerImageModel> flowerImages = <FlowerImageModel>[].obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  RxBool isLoading = false.obs;
  final RxBool isLoggedIn = false.obs;

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

  Future<void> pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      this.pickedImage.value = File(pickedImage.path);
    }
  }

  String get currentUserEmail {
    firebase_auth.User? user = firebase_auth.FirebaseAuth.instance.currentUser;
    return user?.email ?? 'N/A';
  }

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      if (email.trim().isEmpty || password.trim().isEmpty) {
        throw FirebaseAuthException(
          code: 'ERROR_INVALID_INPUT',
          message: 'Please enter both email and password.',
        );
      }
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      print('Email Login Successful');
    } on FirebaseAuthException catch (e) {
      print('Firebase Auth Exception: $e');
    } catch (e) {
      print('Error during Email/Password Login: $e');
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

  Future<void> _loginWithEmailAndPassword() async {
    isLoading.value = true;

    try {
      await loginWithEmailAndPassword(
        _emailController.text,
        _passwordController.text,
      );
      Get.offNamed('/home');
    } catch (e) {
      print('Login Error: $e');
    } finally {
      isLoading.value = false;
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

  void addFlower(createdFlower) {}

  getFlower(String documentId) {}

  void updateFlower(String documentId, updatedFlower) {}

  void removeFlower(String documentId) {}

  void setFlowers(List list) {}
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Message received in background: ${message.notification?.title}');
}

class FirebaseMessagingHandler {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final _localNotification = FlutterLocalNotificationsPlugin();
  Future<void> initPushNotification() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    print('User granted permission: ${settings.authorizationStatus}');
    _firebaseMessaging.getToken().then((token) {
      print('FCM Token: $token');
    });
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      print("terminatedNotification : ${message!.notification?.title}");
    });
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;
      _localNotification.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
            android: AndroidNotificationDetails(
                _androidChannel.id, _androidChannel.name,
                channelDescription: _androidChannel.description,
                icon: '@drawable/ic_launcher')),
        payload: jsonEncode(message.toMap()),
      );
      print(
          'Message received while app is in foreground: ${message.notification?.title}');
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message opened from notification: ${message.notification?.title}');
    });
  }

  Future initLocalNotification() async {
    const ios = DarwinInitializationSettings();
    const android = AndroidInitializationSettings('@drawable/ic_launcher');
    const settings = InitializationSettings(android: android, iOS: ios);
    await _localNotification.initialize(settings);
  }

  final _androidChannel = const AndroidNotificationChannel(
    'channel_notification',
    'High Importance Notification',
    description: 'Used For Notification',
    importance: Importance.defaultImportance,
  );
}
