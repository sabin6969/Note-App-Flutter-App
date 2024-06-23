import 'package:flutter/material.dart';
import 'package:note_app_flutter_mobile_app/views/signup_view.dart';

void main() {
  runApp(const MyNoteApp());
}

// Global object for accessing instance of size
late Size size;

class MyNoteApp extends StatelessWidget {
  const MyNoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      title: "My Note App",
      home: const SignupView(),
    );
  }
}
