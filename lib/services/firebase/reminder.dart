import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Reminder {
  final String task;
  final DateTime reminderTime;

  Reminder({
    required this.task,
    required this.reminderTime,
  });
}

