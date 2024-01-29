import 'package:get/get.dart';
import 'package:todo_app/pages/home/home_controller.dart';
import 'package:todo_app/pages/stream_builder/stream_builder_controller.dart';

class StreamBuilderBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => StreamBuilderController());
    Get.lazyPut(() => HomeController());
  }

}