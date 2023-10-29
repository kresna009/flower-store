import 'dart:convert';
import 'package:flower_store/model/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(FlowerList());

class FlowerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    );
  }
}
