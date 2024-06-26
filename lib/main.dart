import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:note_app_flutter_mobile_app/blocs/note/note.bloc.dart';
import 'package:note_app_flutter_mobile_app/data/provider/note_provider.dart';
import 'package:note_app_flutter_mobile_app/data/repository/note_repository.dart';
import 'package:note_app_flutter_mobile_app/routes/go_route_configuration.dart';
import 'package:note_app_flutter_mobile_app/services/shared_preferences_services.dart';

// Global object for accessing instance of size
late Size size;
void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferenceServices.initSharedPreferenceService();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyNoteApp());
}

class MyNoteApp extends StatelessWidget {
  const MyNoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => NoteRepository(noteProvider: NoteProvider()),
      child: BlocProvider(
        create: (context) =>
            NoteBloc(noteRepository: context.read<NoteRepository>()),
        child: MaterialApp.router(
          routerConfig: GoRouteConfiguration.goRouter,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
