import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:note_app_flutter_mobile_app/routes/go_route_configuration.dart';
import 'package:note_app_flutter_mobile_app/services/shared_preferences_services.dart';

// Global object for accessing instance of size
late Size size;
void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferenceServices.initSharedPreferenceService();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyNoteApp());
}

class MyNoteApp extends StatelessWidget {
  const MyNoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: GoRouteConfiguration.goRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
