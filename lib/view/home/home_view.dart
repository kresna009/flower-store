import 'package:flower_store/model/model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flower_store/controllers/controller.dart';

class FlowerCard {
  final String image;
  final String name;
  final String scientificName;
  final String description;
  final String price;

  FlowerCard(
      this.image, this.name, this.scientificName, this.description, this.price);
}

class HomeView extends StatelessWidget {
  final FlowerController homeController = Get.put(FlowerController());

  final List<FlowerCard> flowerCards = [
    FlowerCard(
      'assets/images/daisy.png',
      "Daisy",
      "Bellis perennis",
      "Bunga daisy, atau yang juga dikenal sebagai bunga matahari...",
      "10k",
    ),
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/addImage'),
        child: const Icon(Icons.add_rounded),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ...flowerCards
                          .map((flowerCard) => cardBunga(flowerCard))
                          .toList(),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // Create a custom bottom navigation bar with clickable images.
      bottomNavigationBar: Container(
        height: 60, // Adjust the height as needed
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

  // Define the list of bottom navigation bar items without 'const'.
  static List<BottomNavBarItem> _bottomNavBarItems = [
    BottomNavBarItem(
      imagePath: 'assets/data.png',
      action: () {
        onPressed:
        () => Get.toNamed('/WebviewPage');
      },
    ),
    BottomNavBarItem(
      imagePath: 'assets/search.png',
      action: () {
        // Define the action for the "Search" button
      },
    ),
    BottomNavBarItem(
      imagePath: 'assets/favorite.png',
      action: () {
        // Define the action for the "Favorite" button
      },
    ),
    BottomNavBarItem(
      imagePath: 'assets/cart.png',
      action: () {
        // Define the action for the "Cart" button
      },
    ),
    BottomNavBarItem(
      imagePath: 'assets/profile.png',
      action: () {
        // Define the action for the "Profile" button
      },
    ),
  ];

  // Build a clickable image widget for each navigation item.
  Widget buildBottomNavItem(int index) {
    return InkWell(
      onTap: () {
        // Execute the action associated with the button.
        _bottomNavBarItems[index].action();
        // Update the selected tab.
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.all(10),
        child: Image.asset(
          _bottomNavBarItems[index].imagePath,
          width: 30,
          height: 30,
          color: _selectedIndex == index ? Colors.blue : Colors.grey,
        ),
      ),
    );
  }

  // Define the setState method to update the selected tab.
  void setState(VoidCallback fn) {}
}

Widget cardBunga(FlowerCard flowerCard) {
  return Container(
    width: FlowerController.i.size.width,
    margin: const EdgeInsets.only(
      bottom: 15,
    ),
    height: 100,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Stack(
      children: [
        Positioned(
          left: -10,
          top: 10,
          bottom: -30,
          child: Opacity(
            opacity: 0.5,
            child: Image.asset(flowerCard.image),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          flowerCard.name,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          "( ${flowerCard.scientificName} )",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Flexible(
                      child: Text(
                        flowerCard.description,
                        overflow: TextOverflow.clip,
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                flowerCard.price,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              )
            ],
          ),
        ),
      ],
    ),
  );
}
