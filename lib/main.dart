import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_flutter_mobile_app/blocs/signup/signup_bloc.dart';
import 'package:note_app_flutter_mobile_app/data/provider/user_provider.dart';
import 'package:note_app_flutter_mobile_app/data/repository/user_repository.dart';
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
      home: RepositoryProvider(
        create: (context) => UserRepository(
          userProvider: UserProvider(),
        ),
        child: BlocProvider(
          create: (context) => SignupBloc(
            userRepository: context.read<UserRepository>(),
          ),
          child: const SignupView(),
        ),
      ),
    );
  }
}
