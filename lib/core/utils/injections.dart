import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:todo/src/controllers/task_controller.dart';

class InjectDependencies {
  static Future<void> inject() async {
    await injectControllers();
  }

  static Future<void> injectControllers() async {
    Get.lazyPut(() => TaskController());

    debugPrint("Controllers Successfully Injected!");
  }
}
