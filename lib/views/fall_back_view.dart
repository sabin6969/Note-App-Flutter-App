import 'package:flutter/material.dart';

class FallBackView extends StatefulWidget {
  const FallBackView({super.key});

  @override
  State<FallBackView> createState() => _FallBackViewState();
}

// TODO: design this page!!!

class _FallBackViewState extends State<FallBackView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Fall back Page"),
      ),
    );
  }
}
