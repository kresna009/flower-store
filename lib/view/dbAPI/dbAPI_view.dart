import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PlantList(),
    );
  }
}

class PlantList extends StatefulWidget {
  @override
  _PlantListState createState() => _PlantListState();
}

class _PlantListState extends State<PlantList> {
  final String apiUrl =
      "https://perenual.com/api/species-list?key=sk-1w81653cce73d827f2742";
  List<dynamic> plantData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      setState(() {
        plantData = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load data from the API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Plant List"),
      ),
      body: ListView.builder(
        itemCount: plantData.length,
        itemBuilder: (context, index) {
          final plant = plantData[index];
          return ListTile(
            title: Text(plant['common_name']),
            subtitle: Text(plant['scientific_name']),
            leading: Image.network(plant['image_url']),
          );
        },
      ),
    );
  }
}
