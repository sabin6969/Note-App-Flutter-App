import 'package:flutter/material.dart';

void showInfoDialog({required BuildContext context}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Info"),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Note App"),
            Divider(),
            Text("Powered by Flutter, NodeJs, ExpressJs, MongoDb, Railway"),
            Divider(),
            Text("Developed by Sabin Poudel"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Ok"),
          )
        ],
      );
    },
  );
}
