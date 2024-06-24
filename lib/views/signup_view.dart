import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:note_app_flutter_mobile_app/blocs/signup/signup_bloc.dart';
import 'package:note_app_flutter_mobile_app/blocs/signup/signup_event.dart';
import 'package:note_app_flutter_mobile_app/blocs/signup/signup_state.dart';
import 'package:note_app_flutter_mobile_app/constants/app_constant.dart';
import 'package:note_app_flutter_mobile_app/main.dart';
import 'package:note_app_flutter_mobile_app/routes/app_route_names.dart';
import 'package:note_app_flutter_mobile_app/utils/image_picker_util.dart';
import 'package:note_app_flutter_mobile_app/utils/loading_dialog.dart';
import 'package:note_app_flutter_mobile_app/utils/show_toast_message.dart';
import 'package:note_app_flutter_mobile_app/widgets/custom_auth_button.dart';
import 'package:note_app_flutter_mobile_app/widgets/custom_text_field.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _fullNameFocusNode = FocusNode();

  final ValueNotifier<bool> _passwordFieldValueNotifier = ValueNotifier(true);
  final ValueNotifier<XFile?> _profileImageValueNotifier = ValueNotifier(null);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Signup",
        ),
      ),
      body: BlocConsumer<SignupBloc, SignupState>(
        builder: (context, state) {
          return SizedBox(
            height: size.height,
            width: size.width,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.03,
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      ValueListenableBuilder(
                        valueListenable: _profileImageValueNotifier,
                        builder: (context, value, child) {
                          return Stack(
                            children: [
                              CircleAvatar(
                                radius: 60,
                                backgroundImage: value == null
                                    ? AssetImage(AppConstant.avatarImagePath)
                                    : FileImage(
                                        File(value.path),
                                      ) as ImageProvider,
                              ),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: CircleAvatar(
                                  backgroundColor: Colors.amber,
                                  child: IconButton(
                                    onPressed: () async {
                                      _profileImageValueNotifier.value =
                                          await ImagePickerUtil
                                              .pickImageFromGallery();
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      CustomTextFormField(
                        hintText: "Enter FullName",
                        textEditingController: _fullNameController,
                        textCapitalization: TextCapitalization.words,
                        prefixIcon: Icons.person,
                        currentFocusNode: _fullNameFocusNode,
                        nextFocusNode: _emailFocusNode,
                        textInputType: TextInputType.name,
                      ),
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
                        buttonName: "Create Account",
                        onPressed: () {
                          context.read<SignupBloc>().add(
                                SignupButtonPressedEvent(
                                  fullName: _fullNameController.text,
                                  password: _passwordController.text,
                                  email: _emailController.text,
                                  imageFile: _profileImageValueNotifier.value,
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
                          const Text("Already have an account?"),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                context,
                                AppRouteNames.login,
                              );
                            },
                            child: const Text("Login"),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state is SignupFailedState) {
            Navigator.pop(context);
            showToastMessage(message: state.errorMessage);
          } else if (state is SignupSucessState) {
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, AppRouteNames.login);
            showToastMessage(message: state.message);
          } else if (state is SignupLoadingState) {
            showLoadingDialog(context: context);
          } else if (state is SignupValidationError) {
            showToastMessage(message: state.message);
          }
        },
      ),
    );
  }
}
