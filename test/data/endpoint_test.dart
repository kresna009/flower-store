import 'package:flower_store/controllers/ClientController.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('ClientController initialization', () {

    final clientController = ClientController();
    clientController.onInit();

    expect(clientController.client.endPoint, isNotEmpty);

    expect(clientController.client.endPoint, equals('https://cloud.appwrite.io/v1'));

  });
}
