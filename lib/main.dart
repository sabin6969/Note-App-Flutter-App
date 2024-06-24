import 'package:flutter/material.dart';
import 'package:note_app_flutter_mobile_app/routes/app_route_configuration.dart';

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
      onGenerateRoute: AppRouteConfiguration.generateRoute,
    );
  }
}
