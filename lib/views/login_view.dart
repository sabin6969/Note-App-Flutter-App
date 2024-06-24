import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_flutter_mobile_app/blocs/login/login_bloc.dart';
import 'package:note_app_flutter_mobile_app/blocs/login/login_event.dart';
import 'package:note_app_flutter_mobile_app/blocs/login/login_state.dart';
import 'package:note_app_flutter_mobile_app/main.dart';
import 'package:note_app_flutter_mobile_app/routes/app_route_names.dart';
import 'package:note_app_flutter_mobile_app/utils/loading_dialog.dart';
import 'package:note_app_flutter_mobile_app/utils/show_toast_message.dart';
import 'package:note_app_flutter_mobile_app/widgets/custom_auth_button.dart';
import 'package:note_app_flutter_mobile_app/widgets/custom_text_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ValueNotifier<bool> _passwordFieldValueNotifier = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
      ),
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginLoadingState) {
            showLoadingDialog(context: context);
          } else if (state is LoginSucessState) {
            Navigator.pop(context);

            showToastMessage(
                message: state.loginResponse.message ?? "Login Sucess Vayo");
            // TODO: navigate user to home page
          } else if (state is LoginFailedState) {
            Navigator.pop(context);
            showToastMessage(message: state.message);
          } else if (state is LoginValidationErrorState) {
            showToastMessage(message: state.message);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.03,
            ),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    CustomTextFormField(
                      hintText: "Enter Email",
                      textEditingController: _emailController,
                      currentFocusNode: _emailFocusNode,
                      nextFocusNode: _passwordFocusNode,
                      prefixIcon: Icons.email,
                      textInputType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    ValueListenableBuilder(
                      valueListenable: _passwordFieldValueNotifier,
                      builder: (context, value, child) {
                        return CustomTextFormField(
                          hintText: "Enter Password",
                          textEditingController: _passwordController,
                          currentFocusNode: _passwordFocusNode,
                          prefixIcon: Icons.lock,
                          obsecureText: value,
                          textInputType: TextInputType.visiblePassword,
                          suffixIconButton: IconButton(
                            onPressed: () {
                              _passwordFieldValueNotifier.value =
                                  !_passwordFieldValueNotifier.value;
                            },
                            icon: Icon(
                              value ? Icons.visibility : Icons.visibility_off,
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    CustomAuthButton(
                      buttonName: "Login",
                      onPressed: () {
                        context.read<LoginBloc>().add(
                              LoginButtonPressedEvent(
                                email: _emailController.text,
                                password: _passwordController.text,
                              ),
                            );
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("New here?"),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                              context,
                              AppRouteNames.signup,
                            );
                          },
                          child: const Text("Signup"),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
