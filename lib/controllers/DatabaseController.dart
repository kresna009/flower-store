import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';

class DatabaseController {
  late final Databases database;

  DatabaseController() {
    init();
  }

  void init() {
    final client = Client()
        .setEndpoint('https://cloud.appwrite.io/v1')
        .setProject('656a01667089bdef83d1');

    database = Databases(client);
  }

  Future<void> create(
      String documentId, String name, String description) async {
    try {
      await database.createDocument(
        documentId: documentId,
        collectionId: 'tb_flowers',
        databaseId: '656a1d54766455b8728e',
        data: {
          'name': name,
          'description': description,
        },
      );
    } catch (e) {
      print('Error creating document: $e');
    }
  }

  Future<List<Map<String, dynamic>>> read() async {
    try {
      final response = await database.listDocuments(
        collectionId: 'tb_flowers',
        databaseId: '656a1d54766455b8728e',
      );
      return List<Map<String, dynamic>>.from(response.documents.map(
        (Document document) => document.data as Map<String, dynamic>,
      ));
    } catch (e) {
      print('Error reading documents: $e');
      return [];
    }
  }

  Future<void> update(
      String documentId, String name, String description) async {
    try {
      await database.updateDocument(
          documentId: documentId,
          collectionId: 'tb_flowers',
          databaseId: '656a1d54766455b8728e',
          data: {
            'name': name,
            'description': description,
          });
    } catch (e) {
      print('Error updating document: $e');
    }
  }

  void delete(String documentId) async {
    database ?? init();
    try {
      await database!.deleteDocument(
        documentId: documentId,
        collectionId: 'tb_flowers',
        databaseId: '656a1d54766455b8728e',
      );
    } catch (e) {
      rethrow;
    }
  }
}
