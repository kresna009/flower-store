import 'package:flower_store/controllers/ClientController.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('ClientController initialization', () {
    // Inisialisasi ClientController dan panggil onInit secara manual
    final clientController = ClientController();
    clientController.onInit();

    // Pastikan nilai-nilai yang diatur sesuai dengan yang diharapkan
    expect(clientController.client.endPoint, equals('https://cloud.appwrite.io/v1'));

  });
}
