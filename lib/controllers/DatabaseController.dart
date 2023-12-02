import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';

class DatabaseController {
  late final Databases database;

  DatabaseController() {
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

      if (response.documents is List<Document>) {
        return List<Map<String, dynamic>>.from(response.documents.map(
          (Document document) => document.data as Map<String, dynamic>,
        ));
      } else {
        print('Invalid response format when reading documents');
        return [];
      }
    } catch (e) {
      print('Error reading documents: $e');
      return [];
    }
  }

  Future<void> update(
      String documentId, String name, String description) async {
    try {
      await database.updateDocument(
          collectionId: 'tb_flowers',
          databaseId: '656a1d54766455b8728e',
          documentId: documentId,
          data: {
            'name': name,
            'description': description,
          });
    } catch (e) {
      print('Error updating document: $e');
    }
  }

  Future<void> delete(String documentId) async {
    try {
      await database.deleteDocument(
        collectionId: 'tb_flowers',
        databaseId: '656a1d54766455b8728e',
        documentId: documentId,
      );
    } catch (e) {
      print('Error deleting document: $e');
    }
  }
}
