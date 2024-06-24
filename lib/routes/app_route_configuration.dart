import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_flutter_mobile_app/blocs/login/login_bloc.dart';
import 'package:note_app_flutter_mobile_app/blocs/signup/signup_bloc.dart';
import 'package:note_app_flutter_mobile_app/data/provider/user_provider.dart';
import 'package:note_app_flutter_mobile_app/data/repository/user_repository.dart';
import 'package:note_app_flutter_mobile_app/routes/app_route_names.dart';
import 'package:note_app_flutter_mobile_app/views/fall_back_view.dart';
import 'package:note_app_flutter_mobile_app/views/login_view.dart';
import 'package:note_app_flutter_mobile_app/views/signup_view.dart';

class AppRouteConfiguration {
  static MaterialPageRoute generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouteNames.signup:
        return MaterialPageRoute(
          builder: (context) => RepositoryProvider(
            create: (context) => UserRepository(userProvider: UserProvider()),
            child: BlocProvider(
              create: (context) => SignupBloc(
                userRepository: context.read<UserRepository>(),
              ),
              child: const SignupView(),
            ),
          ),
        );
      case AppRouteNames.login:
        return MaterialPageRoute(
          builder: (context) => RepositoryProvider(
            create: (context) => UserRepository(userProvider: UserProvider()),
            child: BlocProvider(
              create: (context) => LoginBloc(
                userRepository: context.read<UserRepository>(),
              ),
              child: const LoginView(),
            ),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const FallBackView(),
        );
    }
  }
}
