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
  Rx<File?> pickedImage = Rx<File?>(null);
  RxList<FlowerImageModel> flowerImages = <FlowerImageModel>[].obs;
  var plants = <Plant>[].obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  RxBool isLoading = false.obs;
  final RxBool isLoggedIn = false.obs;

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

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Message received in background: ${message.notification?.title}');
}

class FirebaseMessagingHandler {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final _localNotification = FlutterLocalNotificationsPlugin();
  Future<void> initPushNotification() async {
//allow user to give permission for notification
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
//get token messaging
    _firebaseMessaging.getToken().then((token) {
      print('FCM Token: $token');
    });
//handler terminated message
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      print("terminatedNotification : ${message!.notification?.title}");
    });
//handler onbackground message
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
//handler when open the message
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
