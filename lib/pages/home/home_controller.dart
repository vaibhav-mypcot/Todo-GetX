import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';
import 'package:todo_app/routes/app_page.dart';
import 'package:todo_app/storage/local_storage.dart';
import 'package:todo_app/theme/app_theme.dart';

class HomeController extends GetxService {
  RxString selectedLanguage = 'English'.obs;
  var isDark = false.obs;

  //GetStorage().read('isDark') ??

  final RxMap userData = {}.obs;
  final RxMap userTaskData = {}.obs;
  List userTaskList = [].obs;

  RxBool hasInternet = true.obs;

  RxDouble width = 200.0.obs;
  RxDouble height = 50.0.obs;

  String userId = FirebaseAuth.instance.currentUser!.uid;

  void toggleSize() {
    // Change the width and height
    width.value = width.value == 200.0 ? 250.0 : 200.0;
    height.value = height.value == 50.0 ? 100.0 : 50.0;
  }

  @override
  void onInit() {
    super.onInit();
    getUserData();
    // getUserTaskData();
    fetchData();

    // Retrieve the selected language from GetStorage when the controller is initialized
    // selectedLanguage.value = box.read('language') ?? 'English';
  }

  void setLanguage(String language) {
    selectedLanguage.value = language;
    // languageBox.write('language', language);
  }

  void changeTheme(state) {
    if (state == true) {
      isDark.value = true;
      Get.changeTheme(KAppTheme.darkTheme);
    } else {
      isDark.value = false;
      Get.changeTheme(KAppTheme.lightTheme);
    }

    // box.write('isDark', isDark.value);
    // GetStorage().write('isDark', isDark.value);
  }

  // retrive userdata from firestore
  Future<void> getUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      String userId = user!.uid;
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userSnapshot.exists) {
        // User data exists, return it as a Map
        userData.value = userSnapshot.data() as Map<String, dynamic>;
      } else {
        // User data doesn't exist
        print("User data not found in Firestore");
        userData.value = {};
      }
    } catch (e) {
      print("Error retrieving user data from Firestore: $e");
      userData.value = {};
    }
  }

  //////////////////////

  void fetchData() async {
    User? user = FirebaseAuth.instance.currentUser;
    String userId = user!.uid;
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('task_list')
          .doc(userId)
          .collection('notes')
          .get();
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void gotoAddNewTaskScreen() {
    Get.toNamed(AppRoutes.addTaskScreen);
  }

  void checkBoxChanged(bool? value, index) async {
    Query<Map<String, dynamic>> querySnapshot = FirebaseFirestore.instance
        .collection('task_list')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('notes')
        .orderBy('currentTime');

    QuerySnapshot getData = await querySnapshot.get();
    Map data = getData.docs[index].data() as Map;

    String docID = getData.docs[index].reference.id;

    // Now you can access individual fields
    bool taskCompleted = data['isCompleted'];

    taskCompleted = !taskCompleted;

    // try to update value in fire store
    try {
      await FirebaseFirestore.instance
          .collection('task_list')
          .doc(userId) // Replace with the actual user ID
          .collection('notes')
          .doc(docID)
          .update({'isCompleted': value});
    } catch (e) {
      print('Error updating Firestore: $e');
    }
  }

  // delete tile
  void onDeleteTile(String docId) async {
    try {
      await FirebaseFirestore.instance
          .collection('task_list')
          .doc(userId)
          .collection('notes')
          .doc(docId)
          .delete();
    } catch (e) {
      print('Error deleting Firestore: $e');
    }
  }
}
