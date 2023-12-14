import 'dart:convert';
import 'package:flower_store/model/model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiController extends GetxController {
  var plants = <Plant>[].obs;

  late http.Client httpClient;

  ApiController({http.Client? client}) : httpClient = client ?? http.Client();

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
}
