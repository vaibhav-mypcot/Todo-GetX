import 'package:get/get.dart';
import 'package:todo_app/pages/create_new_password/create_new_password_controller.dart';

class CreateNewPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateNewPasswordController());
  }
}
