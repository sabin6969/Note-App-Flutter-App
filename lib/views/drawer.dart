import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:note_app_flutter_mobile_app/blocs/auth/auth_bloc.dart';
import 'package:note_app_flutter_mobile_app/blocs/auth/auth_event.dart';
import 'package:note_app_flutter_mobile_app/blocs/auth/auth_state.dart';
import 'package:note_app_flutter_mobile_app/routes/app_route_names.dart';
import 'package:note_app_flutter_mobile_app/utils/loading_dialog.dart';
import 'package:note_app_flutter_mobile_app/utils/show_toast_message.dart';

class ProfileDrawer extends StatelessWidget {
  const ProfileDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(),
      child: BlocConsumer<AuthBloc, AuthState>(
        builder: (context, state) {
          return ListView(
            padding: EdgeInsets.zero,
            children: [
              const UserAccountsDrawerHeader(
                accountName: Text("Your Name"),
                accountEmail: Text(
                  "yourmail@gmail.com",
                ),
              ),
              ListTile(
                onTap: () {
                  context.read<AuthBloc>().add(AuthLogoutEvent());
                },
                title: const Text(
                  "Logout",
                ),
                leading: const Icon(
                  Icons.logout,
                ),
              )
            ],
          );
        },
        listener: (context, state) {
          if (state is AuthLoadingState) {
            showLoadingDialog(context: context);
          } else if (state is AuthLogoutState) {
            showToastMessage(message: state.message);
            GoRouter.of(context).pushReplacementNamed(AppRouteNames.login);
          }
        },
      ),
    );
  }
}
