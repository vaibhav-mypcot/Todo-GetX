import 'package:get/get.dart';
import 'package:todo_app/pages/otp/otp_controller.dart';

class OtpBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => OtpController());
  }
}