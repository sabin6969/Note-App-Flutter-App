import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final IconData prefixIcon;
  final FocusNode currentFocusNode;
  final FocusNode? nextFocusNode;
  final bool? obsecureText;
  final IconButton? suffixIconButton;
  final TextInputType textInputType;
  final TextCapitalization? textCapitalization;
  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.textEditingController,
    required this.prefixIcon,
    required this.currentFocusNode,
    required this.textInputType,
    this.nextFocusNode,
    this.obsecureText,
    this.suffixIconButton,
    this.textCapitalization,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: currentFocusNode,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
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
