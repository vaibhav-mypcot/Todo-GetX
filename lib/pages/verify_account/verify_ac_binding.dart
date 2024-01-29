import 'package:get/get.dart';
import 'package:todo_app/pages/verify_account/verify_ac_controller.dart';

class VerifyAccountBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => VerifyAccountController());
  }
}