import 'dart:convert';
import 'package:flower_store/controllers/ApiController.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  group('ApiController Tests', () {
    late http.Client client;
    late ApiController apiController;

    setUp(() {
      client = http.Client();
      apiController = ApiController(client: client);
    });

    tearDown(() {
      client.close();
    });

    test('Fetch plant list successfully', () async {
      // Arrange
      final apiKey = 'mlBKGsf6yXuElxvrjzxwWefdpaBl771xLEFhWsgCJRY';
      final apiUrl = 'https://trefle.io/api/v1/plants?token=$apiKey';

      // Act
      await apiController.fetchPlantList();

      // Assert
      expect(apiController.plants, isNotEmpty);
      // Add more specific assertions based on your API response structure
      // For example, you can check that the names are not null
      expect(apiController.plants.every((plant) => plant.name != null), isTrue);
    });
  });
}
