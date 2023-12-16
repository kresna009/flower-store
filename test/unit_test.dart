import 'dart:convert';
import 'package:flower_store/controllers/fetch_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';


void main() {
  test('fetchPosts returns a Posts object if the http call completes successfully', () async {
    final client = http.Client();
    final posts = await fetchPosts(client);

    expect(posts, isA<Posts>());
    expect(posts.userId, isNotNull);
    expect(posts.id, isNotNull);
    expect(posts.title, isNotNull);
    expect(posts.body, isNotNull);

    client.close();
  });

  test('fetchPosts throws an exception if the http call completes with an error status code', () async {
    final client = http.Client();
    final expectedException = 'Failed to load album';

    expect(() async => await fetchPostsError(client), throwsA(expectedException));

    client.close();
  });
}

fetchPostsError(http.Client client) {
}


