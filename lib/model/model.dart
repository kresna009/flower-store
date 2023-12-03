import 'package:flutter/material.dart';

class FlowerImageModel {
  final String imagePath;
  final String title;
  final String description;

  FlowerImageModel(this.imagePath, this.title, this.description);
}

class FlowerCard {
  final String image;
  final String name;
  final String scientificName;
  final String description;
  final String price;

  FlowerCard(
      this.image, this.name, this.scientificName, this.description, this.price);
}

class BottomNavBarItem {
  final IconData icon;
  final Function action;

  BottomNavBarItem({required this.icon, required this.action});
}

class Plant {
  final String name;
  final String description;

  Plant({required this.name, required this.description});

  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
      name: json['common_name'] ?? json['scientific_name'],
      description: json['family_common_name'] ?? 'N/A',
    );
  }
}

class User {
  String email;
  String password;

  User({required this.email, required this.password});
}

class AccountData {
  final String userId;
  final String name;
  final String email;

  AccountData({
    required this.userId,
    required this.name,
    required this.email,
  });
}

class Flower {
  final String documentId;
  final String name;
  final String description;
  bool isSelected; // Add isSelected property

  Flower({
    required this.documentId,
    required this.name,
    required this.description,
    this.isSelected = false, // Provide a default value
  });
}
