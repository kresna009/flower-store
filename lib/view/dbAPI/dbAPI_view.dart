import 'dart:convert';
import 'package:flower_store/model/model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class FlowerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Plant List App',
      home: PlantListScreen(),
    );
  }
}

class PlantListScreen extends StatefulWidget {
  @override
  _PlantListScreenState createState() => _PlantListScreenState();
}

class _PlantListScreenState extends State<PlantListScreen> {
  List<Plant> _plants = [];

  @override
  void initState() {
    super.initState();
    fetchPlantList();
  }

  Future<void> fetchPlantList() async {
    final apiKey =
        'mlBKGsf6yXuElxvrjzxwWefdpaBl771xLEFhWsgCJRY'; // Replace with your Trefle API key
    final apiUrl = 'https://trefle.io/api/v1/plants?token=$apiKey';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> plantList = data['data'];
      setState(() {
        _plants = plantList.map((item) => Plant.fromJson(item)).toList();
      });
    } else {
      throw Exception('Failed to load plant data');
    }
  }

  int _selectedIndex = 3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plant List'),
      ),
      body: _plants.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _plants.length,
              itemBuilder: (context, index) {
                final plant = _plants[index];
                return ListTile(
                  title: Text(plant.name),
                  subtitle: Text(plant.description),
                );
              },
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
      action: () {},
    ),
  ];

  Widget buildBottomNavItem(int index) {
    return InkWell(
      onTap: () {
        // Execute the action associated with the button.
        _bottomNavBarItems[index].action();
      },
      child: Container(
        padding: EdgeInsets.all(10),
        child: Icon(
          _bottomNavBarItems[index].icon,
          size: 30,
          color: _selectedIndex == index ? Colors.blue : Colors.grey,
        ),
      ),
    );
  }
}
