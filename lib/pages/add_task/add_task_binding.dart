import 'package:get/get.dart';
import 'package:todo_app/pages/add_task/add_task_controller.dart';

class AddTaskBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => AddTaskController());
  }
}