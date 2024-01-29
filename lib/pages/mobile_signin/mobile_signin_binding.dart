import 'package:get/get.dart';
import 'package:todo_app/pages/mobile_signin/mobile_signin_controller.dart';

class MobileSigninBinding extends Bindings{
  @override
  void dependencies() {
   Get.lazyPut(() => MobileSigninController());
  }

}