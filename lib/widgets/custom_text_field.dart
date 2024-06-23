import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final IconData prefixIcon;
  final FocusNode currentFocusNode;
  final FocusNode? nextFocusNode;
  final bool? obsecureText;
  final IconButton? suffixIconButton;
  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.textEditingController,
    required this.prefixIcon,
    required this.currentFocusNode,
    this.nextFocusNode,
    this.obsecureText,
    this.suffixIconButton,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: currentFocusNode,
      obscureText: obsecureText ?? false,
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus(nextFocusNode);
      },
      controller: textEditingController,
      decoration: InputDecoration(
        prefixIcon: Icon(
          prefixIcon,
        ),
        suffixIcon: suffixIconButton,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            15,
          ),
        ),
      ),
    );
  }
}
