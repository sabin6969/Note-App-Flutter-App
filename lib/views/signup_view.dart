import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:note_app_flutter_mobile_app/main.dart';
import 'package:note_app_flutter_mobile_app/utils/image_picker_util.dart';
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

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Create Account",
        ),
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.03,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ValueListenableBuilder(
                  valueListenable: _profileImageValueNotifier,
                  builder: (context, value, child) {
                    return Stack(
                      children: [
                        const CircleAvatar(
                          radius: 60,
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
                  prefixIcon: Icons.person,
                  currentFocusNode: _fullNameFocusNode,
                  nextFocusNode: _emailFocusNode,
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
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
