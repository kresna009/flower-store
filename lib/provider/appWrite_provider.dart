import 'package:flower_store/controllers/DatabaseController.dart';
import 'package:flutter/material.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseController _databaseController = DatabaseController();
  List<Map<String, dynamic>> _flowers = [];
  List<String> _selectedDocumentIds = [];

  List<Map<String, dynamic>> get flowers => _flowers;

  List<String> get selectedDocumentIds => _selectedDocumentIds;

  Future<void> createFlower(String name, String description) async {
    final newFlower = {
      'documentId': DateTime.now().millisecondsSinceEpoch.toString(),
      'name': name,
      'description': description,
    };
    _flowers.add(newFlower);
    notifyListeners();
  }

  Future<void> readFlowers() async {
    _flowers = await _databaseController.read();
    notifyListeners();
  }

  Future<void> updateSelectedFlowers() async {
    notifyListeners();
  }

  Future<void> deleteSelectedFlowers(List selectedDocumentIds) async {
    print(selectedDocumentIds);
    for (var documentId in selectedDocumentIds) {
      _databaseController.delete(documentId);
    }
    notifyListeners();
  }

  void toggleSelectedDocument(String documentId, bool value) {
    if (value == true) {
      _selectedDocumentIds.add(documentId);
    } else {
      _selectedDocumentIds.remove(documentId);
    }
    notifyListeners();
  }
}
