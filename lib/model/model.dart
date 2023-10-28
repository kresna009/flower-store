import 'dart:ui';

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
  final String imagePath;
  final VoidCallback action;

  BottomNavBarItem({
    required this.imagePath,
    required this.action,
  });
}
