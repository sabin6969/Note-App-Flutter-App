import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:note_app_flutter_mobile_app/blocs/auth/auth_bloc.dart';
import 'package:note_app_flutter_mobile_app/blocs/auth/auth_state.dart';
import 'package:note_app_flutter_mobile_app/routes/app_route_names.dart';
import 'package:note_app_flutter_mobile_app/utils/show_toast_message.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        builder: (context, state) {
          return const SizedBox();
        },
        listener: (context, state) {
          if (state is AuthSucessState) {
            debugPrint("Navigating to home page");
            FlutterNativeSplash.remove();
            context.goNamed(AppRouteNames.home);
          } else if (state is AuthFailedState) {
            /// Navigating user to login page!
            FlutterNativeSplash.remove();
            showToastMessage(message: state.errorMessage);
            context.goNamed(AppRouteNames.login);
          }
        },
      ),
    );
  }
}
