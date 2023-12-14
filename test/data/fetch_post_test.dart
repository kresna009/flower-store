import 'package:flower_store/fetch_post.dart';
import 'package:flower_store/model/fetch_post_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

void main() {
  group('fetchPosts', () {
    test('returns Posts if the http call completes successfully', () async {
      final client = MockClient((request) async {
        return http.Response(
            '{"userId": 1, "id": 1, "title": "Test Title", "body": "Test Body"}',
            200);
      });
      final posts = await fetchPosts(client);

      expect(posts, isA<Posts>());
      expect(posts.userId, 1);
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
    test('throws an exception if the http call completes with an error',
        () async {
      final client = MockClient((request) async {
        return http.Response('Not Found', 404);
      });
      try {
        await fetchPosts(client);
        fail('Exception expected');
      } catch (e) {
        expect(e, isException);
      }
    });
  });
}
