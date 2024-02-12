import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/routes/app_page.dart';
import 'package:uuid/uuid.dart';

class AddTaskController extends GetxService {
  final GlobalKey<FormState> taskFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> reminderFormKey = GlobalKey<FormState>();
  DateTime now = DateTime.now();

  String currentTime = DateFormat('HH:mm:ss').format(DateTime.now());

  final task = TextEditingController();
  static Map<DateTime, String> reminderMap = {};

  // Select Time method
  final selectedTime = TimeOfDay.now().obs;
  String timeValue = 'Select Time';

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> selectTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime.value,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );
    if (pickedTime != null && pickedTime != selectedTime) {
      selectedTime.value = pickedTime;
      pickedTime = TimeOfDay.now();
    }
  }

  // Select date method
  var selectedDate = DateTime.now().obs;
  String date = DateFormat('dd MMM yyyy').format(DateTime.now());
  String reminder = "";

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime.now().subtract(const Duration(days: 0)),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      selectedDate.value = picked;
      date = DateFormat('dd MMM yyyy').format(picked);
    }
  }

  // Check selected time
  void checkDateTime(BuildContext context, bool bellIc) async {
    DateTime currentDate = DateTime.now();
    DateTime selectedDateTime = DateTime(
        selectedDate.value.year,
        selectedDate.value.month,
        selectedDate.value.day,
        selectedTime.value.hour,
        selectedTime.value.minute);

    reminder = DateFormat('yyyy-MM-dd HH:mm:ss').format(selectedDateTime);

    // Check if selected time is 5 minutes greater than the current time
    if (selectedDateTime.isAfter(currentDate.add(const Duration(seconds: 5)))) {
      onAddReminderTaskClicked(context, bellIc);
    } else {
      // Handle the case where the condition is not met
      Get.snackbar('Error',
          'Selected time should be 5 minutes greater than current time.');
    }
    // Check if the selected date and time are in the past
    if (selectedDateTime.isBefore(currentDate)) {
      Get.snackbar(
          'Error', 'Selected date and time should not be in the past.');
    }
  }

  Future<void> onAddTaskClicked(BuildContext context, bool? bellIC) async {
    if (taskFormKey.currentState!.validate()) {
      try {
        User? user = FirebaseAuth.instance.currentUser;
        String userId = user!.uid;

        var uuid = const Uuid();

        // Generate a random unique string
        String randomString = uuid.v4();

        await FirebaseFirestore.instance
            .collection('task_list')
            .doc(userId)
            .collection('notes')
            .doc(randomString)
            .set({
          'task': task.text.toString(),
          'isCompleted': false,
          'date': date,
          'time': selectedTime.value.format(context),
          'taskId': DateFormat('HH:mm:ss').format(DateTime.now()),
          'bellIC': bellIC,
          'reminderTime': reminder,
        });

        Get.snackbar(
          "Congratulation",
          "Task task added successfully",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.green,
          backgroundColor: Colors.white,
        );

        taskFormKey.currentState!.reset();
        task.clear();
        Get.close(1);

        // Get.offAndToNamed(AppRoutes.homeScreen);
      } on FirebaseAuthException catch (error) {
        Get.snackbar(error.message ?? "task added failed", "Please try again",
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.red,
            backgroundColor: Colors.white);
      }
    }
  }
  // For reminder screen

  Future<void> onAddReminderTaskClicked(
      BuildContext context, bool? bellIC) async {
    if (reminderFormKey.currentState!.validate()) {
      try {
        User? user = FirebaseAuth.instance.currentUser;
        String userId = user!.uid;

        var uuid = const Uuid();

        // Generate a random unique string
        String randomString = uuid.v4();

        await FirebaseFirestore.instance
            .collection('task_list')
            .doc(userId)
            .collection('notes')
            .doc(randomString)
            .set({
          'task': task.text.toString(),
          'isCompleted': false,
          'date': date,
          'time': selectedTime.value.format(context),
          'taskId': DateFormat('HH:mm:ss').format(DateTime.now()),
          'bellIC': bellIC,
          'reminderTime': reminder,
        });

        Get.snackbar(
          "Congratulation",
          "Task task added successfully",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.green,
          backgroundColor: Colors.white,
        );

        reminderFormKey.currentState!.reset();
        task.clear();
        Get.close(1);

        // Get.offAllNamed(AppRoutes.homeScreen);
      } on FirebaseAuthException catch (error) {
        Get.snackbar(error.message ?? "task added failed", "Please try again",
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.red,
            backgroundColor: Colors.white);
      }
    }
  }

  Future<void> onAddTaskUpdateClicked(
      BuildContext context,
      String? task,
      bool? isCompleted,
      bool? bellIC,
      String? reminder,
      String randomString) async {
    if (taskFormKey.currentState!.validate() ||
        reminderFormKey.currentState!.validate()) {
      try {
        User? user = FirebaseAuth.instance.currentUser;
        String userId = user!.uid;

        var uuid = const Uuid();

        await FirebaseFirestore.instance
            .collection('task_list')
            .doc(userId)
            .collection('notes')
            .doc(randomString)
            .update({
          'task': task.toString(),
          'isCompleted': false,
          'date': date,
          'time': selectedTime.value.format(context),
          'taskId': DateFormat('HH:mm:ss').format(DateTime.now()),
          'bellIC': bellIC,
          'reminderTime': reminder,
        });

        Get.snackbar(
          "Congratulation",
          "Task task updated successfully",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.green,
          backgroundColor: Colors.white,
        );

        taskFormKey.currentState!.reset();
        Get.close(1);
      } on FirebaseAuthException catch (error) {
        Get.snackbar(
            error.message ?? "task updation failed", "Please try again",
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.red,
            backgroundColor: Colors.white);
      }
    }
  }

  Future<void> onReminderTaskUpdateClicked(
      BuildContext context,
      String? task,
      bool? isCompleted,
      bool? bellIC,
      String? reminder,
      String randomString) async {
    if (reminderFormKey.currentState!.validate()) {
      try {
        User? user = FirebaseAuth.instance.currentUser;
        String userId = user!.uid;

        var uuid = const Uuid();

        await FirebaseFirestore.instance
            .collection('task_list')
            .doc(userId)
            .collection('notes')
            .doc(randomString)
            .update({
          'task': task.toString(),
          'isCompleted': false,
          'date': date,
          'time': selectedTime.value.format(context),
          'taskId': DateFormat('HH:mm:ss').format(DateTime.now()),
          'bellIC': bellIC,
          'reminderTime': reminder,
        });

        Get.snackbar(
          "Congratulation",
          "Task task updated successfully",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.green,
          backgroundColor: Colors.white,
        );

        reminderFormKey.currentState!.reset();
        Get.close(1);
      } on FirebaseAuthException catch (error) {
        Get.snackbar(
            error.message ?? "task updation failed", "Please try again",
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.red,
            backgroundColor: Colors.white);
      }
    }
  }
}
