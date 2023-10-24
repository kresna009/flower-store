import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Controller extends GetxController {
  static Controller get i => Get.find();

  Size size = MediaQuery.of(Get.context!).size;
}
