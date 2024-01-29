import 'package:get/get.dart';
import 'package:todo_app/pages/profile_page/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileController());
  }
}
