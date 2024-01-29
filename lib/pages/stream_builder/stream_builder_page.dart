import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/pages/home/home_screen.dart';
import 'package:todo_app/pages/welcome_page/welcome_screen.dart';

class StreamBuilderPage extends StatelessWidget {
  const StreamBuilderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return WelcomeScreen();
              }
              if (snapshot.hasData) {
                return HomeScreen();
              }
              return WelcomeScreen();
            }),
    );
  }
}