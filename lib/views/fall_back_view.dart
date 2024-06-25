import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:note_app_flutter_mobile_app/constants/app_constant.dart';

class FallBackView extends StatefulWidget {
  const FallBackView({super.key});

  @override
  State<FallBackView> createState() => _FallBackViewState();
}

class _FallBackViewState extends State<FallBackView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Lottie.asset(
        AppConstant.notFoundAnimationPath,
      ),
    );
  }
}
