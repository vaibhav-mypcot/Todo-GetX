import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/components/home_components/empty_screen.dart';
import 'package:todo_app/pages/home/home_controller.dart';
import 'package:todo_app/pages/signin/signin_controller.dart';
import 'package:todo_app/routes/app_page.dart';
import 'package:todo_app/services/firebase/notification_services.dart';
import 'package:todo_app/theme/colors.dart';
import 'package:todo_app/widget/appdrawer.dart';
import 'package:todo_app/widget/bottom_appbar.dart';
import 'package:todo_app/widget/task_tile.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final homeController = Get.find<HomeController>();
  // final homeController = Get.put(HomeController());
  // final signinController = Get.find<SigninController>();
  final signinController = Get.put(SigninController());

  final player = AudioPlayer();

  Future<void> playAudio() async {
    String url =
        "https://codeskulptor-demos.commondatastorage.googleapis.com/pang/pop.mp3";

    await player.play(
      UrlSource(url),
    );
  }

  // +++++++ Calling reminders from firestore +++++++
  // Stream<List<Reminder>> fetchRemindersFromFirestore() {
  //   try {
  //     User? user = FirebaseAuth.instance.currentUser;
  //     String userId = user!.uid;

  //     Stream<QuerySnapshot<Map<String, dynamic>>> stream = FirebaseFirestore
  //         .instance
  //         .collection('task_list')
  //         .doc(userId)
  //         .collection('notes')
  //         .snapshots();

  //     return stream.map((querySnapshot) {
  //       return querySnapshot.docs.map((doc) {
  //         // Assuming your Firestore document has 'task' and 'reminderTime' fields
  //         String task = doc['task'];
  //         String timestamp = doc['reminderTime'];
  //         bool bellIC = doc['bellIC'];
  //         return Reminder(
  //           task: task,
  //           reminderTime: timestamp,
  //           bellIc: bellIC,
  //         );
  //       }).toList();
  //     });
  //   } catch (e) {
  //     print("Error fetching reminders: $e");
  //     return Stream.value([]); // Return an empty stream in case of an error
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // List remindersList = [];
    bool isTapped = false;
    Query<Map<String, dynamic>> querySnapshot = FirebaseFirestore.instance
        .collection('task_list')
        .doc(signinController.auth.currentUser!.uid)
        .collection('notes')
        .orderBy(
          'taskId',
        );

    return Scaffold(
      bottomNavigationBar: BottomAppbarWidget(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          homeController.gotoAddNewTaskScreen();
        },
        backgroundColor: kColorPrimary,
        shape: CircleBorder(),
        child: Icon(
          Icons.add,
          color: kColorWhite,
          size: 24.h,
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        actions: [
          Obx(
            () => GestureDetector(
              onTap: () {
                if (!isTapped) {
                  homeController.changeTheme(isTapped);
                  isTapped = true;
                } else {
                  homeController.changeTheme(isTapped);
                  isTapped = false;
                }
              },
              child: Container(
                margin: EdgeInsets.only(right: 20.h),
                child: homeController.isDark.value
                    ? Icon(
                        Icons.dark_mode,
                        color: homeController.isDark.value
                            ? Colors.grey
                            : Colors.orange,
                      )
                    : Icon(
                        Icons.light_mode,
                        color: homeController.isDark.value
                            ? Colors.purple
                            : Colors.grey,
                      ),
              ),
            ),
          ),
        ],
      ),
      drawer: AppDrawerWidget(onClearData: () {
        signinController.onClearData();
      }),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder(
              stream: querySnapshot.snapshots(),
              builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.data!.docs.isNotEmpty) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: List.generate(
                        snapshot.data!.docs.length,
                        (index) {
                          Map data = snapshot.data?.docs[index].data() as Map;

                          String task = data['task'];
                          bool isCompleted = data['isCompleted'];
                          String time = data['time'];
                          String date = data['date'];
                          bool isBellIc = data['bellIC'];
                          String reminder = data['reminderTime'];

                          QueryDocumentSnapshot documentSnapshot =
                              snapshot.data!.docs[index];
                          String docID = documentSnapshot.reference.id;

                          if (isBellIc) {
                            // Start a periodic timer to check reminders every minute
                            // Timer.periodic(Duration(minutes: 1), (timer) {
                            //   // Get the current time
                            //   DateTime currentTime = DateTime.now();

                            //   // Format the current time to match the format of reminders
                            //   String formattedTime =
                            //       DateFormat("HH:mm").format(currentTime);

                            //   if (remindersList.contains(formattedTime)) {
                            //     // Trigger notification or any other action
                            //     NotifyHelper().scheduledNotification(
                            //       int.parse(
                            //           formattedTime.toString().split(":")[0]),
                            //       int.parse(
                            //           formattedTime.toString().split(":")[1]),
                            //       task,
                            //     );
                            //     print("Reminder matched: $formattedTime");
                            //     // Call your notification handling method here
                            //   }
                            // });

                            // Schedule notification using NotificationService
                            DateTime reminderDate = DateTime.parse(reminder);
                            var myTime =
                                DateFormat("HH:mm").format(reminderDate);
                            print("ge bellic true");
                            NotifyHelper().scheduledNotification(
                              int.parse(myTime.toString().split(":")[0]),
                              int.parse(myTime.toString().split(":")[1]),
                              task,
                            );
                          }

                          return Dismissible(
                            key: Key(docID),
                            background: const Card(
                              color: Colors.red,
                              child: Center(
                                child: Text(
                                  "Deleted",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                            ),
                            onDismissed: (direction) {
                              FirebaseFirestore.instance
                                  .collection('task_list')
                                  .doc(signinController.auth.currentUser!.uid)
                                  .collection('notes')
                                  .doc(docID)
                                  .delete();
                            },
                            child: GestureDetector(
                              onTap: () {
                                if (isBellIc) {
                                  Get.toNamed(AppRoutes.reminderScreen,
                                      arguments: {
                                        'documentId': docID,
                                        'isCompleted': isCompleted,
                                        'currentTime': time,
                                        'currentDate': date,
                                        'taskName': task.toString(),
                                        'isBellIc': isBellIc,
                                        'reminderTime': reminder,
                                      });
                                } else {
                                  Get.toNamed(AppRoutes.addTaskScreen,
                                      arguments: {
                                        'documentId': docID,
                                        'isCompleted': isCompleted,
                                        'currentTime': time,
                                        'currentDate': date,
                                        'taskName': task.toString(),
                                        'isBellIc': isBellIc,
                                        'reminderTime': reminder,
                                      });
                                }
                              },
                              child: TaskTile(
                                documentId: docID,
                                currentTime: time,
                                currentDate: date,
                                taskName: task.toString(),
                                taskCompleted: isCompleted,
                                onChanged: (value) {
                                  print("pressed index: $index");
                                  homeController.checkBoxChanged(value, index);
                                  playAudio();
                                },
                                onDelete: (docId) {
                                  FirebaseFirestore.instance
                                      .collection('task_list')
                                      .doc(signinController
                                          .auth.currentUser!.uid)
                                      .collection('notes')
                                      .doc(docID)
                                      .delete();
                                },
                                bellIc: isBellIc,
                              ),
                            ),
                          );
                        },
                      ).reversed.toList(),
                    ),
                  );
                } else {
                  return Container(
                    margin: EdgeInsets.only(top: 90.h),
                    child: Center(child: EmptyScreen()),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
