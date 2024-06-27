import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:note_app_flutter_mobile_app/blocs/auth/auth_bloc.dart';
import 'package:note_app_flutter_mobile_app/blocs/auth/auth_event.dart';
import 'package:note_app_flutter_mobile_app/blocs/login/login_bloc.dart';
import 'package:note_app_flutter_mobile_app/blocs/signup/signup_bloc.dart';
import 'package:note_app_flutter_mobile_app/data/provider/auth_provider.dart';
import 'package:note_app_flutter_mobile_app/data/provider/user_provider.dart';
import 'package:note_app_flutter_mobile_app/data/repository/auth_repository.dart';
import 'package:note_app_flutter_mobile_app/data/repository/user_repository.dart';
import 'package:note_app_flutter_mobile_app/routes/app_route_names.dart';
import 'package:note_app_flutter_mobile_app/views/add_note_view.dart';
import 'package:note_app_flutter_mobile_app/views/fall_back_view.dart';
import 'package:note_app_flutter_mobile_app/views/home_view.dart';
import 'package:note_app_flutter_mobile_app/views/login_view.dart';
import 'package:note_app_flutter_mobile_app/views/signup_view.dart';
import 'package:note_app_flutter_mobile_app/views/splash_view.dart';

class GoRouteConfiguration {
  static GoRouter goRouter = GoRouter(
    errorBuilder: (context, state) {
      return const FallBackView();
    },
    routes: [
      GoRoute(
        path: "/",
        builder: (context, state) {
          return RepositoryProvider(
            create: (context) => AuthRepository(
              authProvider: AuthProvider(),
            ),
            child: BlocProvider(
              create: (context) => AuthBloc(
                authRepository: context.read<AuthRepository>(),
              )..add(
                  AuthVerifyAcesstokenEvent(),
                ),
              child: const SplashView(),
            ),
          );
        },
      ),
      GoRoute(
        path: "/${AppRouteNames.login}",
        name: AppRouteNames.login,
        builder: (context, state) {
          return RepositoryProvider(
            create: (context) => UserRepository(userProvider: UserProvider()),
            child: BlocProvider(
              create: (context) => LoginBloc(
                userRepository: context.read<UserRepository>(),
              ),
              child: const LoginView(),
            ),
          );
        },
      ),
      GoRoute(
        path: "/${AppRouteNames.signup}",
        name: AppRouteNames.signup,
        builder: (context, state) {
          return RepositoryProvider(
            create: (context) => UserRepository(userProvider: UserProvider()),
            child: BlocProvider(
              create: (context) => SignupBloc(
                userRepository: context.read<UserRepository>(),
              ),
              child: const SignupView(),
            ),
          );
        },
      ),
      GoRoute(
        path: "/${AppRouteNames.home}",
        name: AppRouteNames.home,
        builder: (context, state) {
          return const HomeView();
        },
      ),
      GoRoute(
        path: "/${AppRouteNames.addNote}",
        name: AppRouteNames.addNote,
        builder: (context, state) {
          return const AddNoteView();
        },
      )
    ],
  );
}
