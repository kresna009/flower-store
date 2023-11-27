import 'package:appwrite/appwrite.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ClientController extends GetxController {
  Client client = Client();
  @override
  void onInit() {
    super.onInit();
// appwrite
    const endPoint = "https://cloud.appwrite.io/v1";
    const projectID = "65646d930b9cf31edfb9";
    client
        .setEndpoint(endPoint)
        .setProject(projectID)
        .setSelfSigned(status: true);
  }
}
