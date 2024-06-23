import 'package:flutter/material.dart';
import 'package:note_app_flutter_mobile_app/main.dart';

class CustomAuthButton extends StatelessWidget {
  final String buttonName;
  final void Function()? onPressed;
  const CustomAuthButton({
    super.key,
    required this.buttonName,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.sizeOf(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.03,
      ),
      child: MaterialButton(
        color: Colors.blue,
        onPressed: () {},
        height: size.height * 0.07,
        minWidth: size.width,
        shape: const StadiumBorder(),
        child: Text(
          buttonName,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
