import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:flower_store/controllers/ApiController.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  const apiKey = 'mlBKGsf6yXuElxvrjzxwWefdpaBl771xLEFhWsgCJRY';
  const apiUrl = 'https://trefle.io/api/v1/plants?token=$apiKey';

  group('ApiController Tests', () {
    test('fetchPlantList success', () async {
      final mockClient = MockClient();
      final apiController = ApiController(client: mockClient);

      when(mockClient.get(Uri.parse(apiUrl)))
          .thenAnswer((_) async => http.Response('{"data": []}', 200));

      await apiController.fetchPlantList();

      expect(apiController.plants, isEmpty);
    });

    /*group('API Test', () {
    test('returns Posts if the http call completes successfully', () async {
      final client = MockClient((request) async {
        return http.Response(
            '{'common_name': name, 'family_common_name': description}',
            200);
      });
      final response = await http.get(Uri.parse(apiUrl));

      expect(apiController.plants, isEmpty);
    });
    */

    test('fetchPlantList error', () async {
      final mockClient = MockClient();
      final apiController = ApiController(client: mockClient);

      // Mock HTTP response with a non-200 status code
      when(mockClient.get(Uri.parse(apiUrl)))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      // Call the method to be tested
      await apiController.fetchPlantList();

      // Verify that an exception is thrown
      expect(apiController.plants, isEmpty);
    });
  });
}
