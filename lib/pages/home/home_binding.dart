import 'package:get/get.dart';
import 'package:todo_app/pages/add_task/add_task_controller.dart';
import 'package:todo_app/pages/home/home_controller.dart';
import 'package:todo_app/pages/signin/signin_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => SigninController());
    // Get.put(HomeController());
    // Get.put(SigninController());
  }
}
