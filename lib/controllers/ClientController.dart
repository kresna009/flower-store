import 'package:appwrite/appwrite.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ClientController extends GetxController {
  late Client client;

  @override
  void onInit() {
    super.onInit();
    const endPoint = "https://cloud.appwrite.io/v1";
    const projectId = "6569f57da65129d3fd36";

    client = Client()
        .setEndpoint(endPoint)
        .setProject(projectId)
        .setSelfSigned(status: true);
  }

  String getEndpoint() {
    return client.endPoint;
  }

}
