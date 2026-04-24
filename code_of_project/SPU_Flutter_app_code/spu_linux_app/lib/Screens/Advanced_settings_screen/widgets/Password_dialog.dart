import 'package:flutter/material.dart';

Future<bool> showPasswordDialog(BuildContext context) async {
  TextEditingController controller = TextEditingController();
  bool isCorrect = false;

  await showDialog(
    context: context,
    barrierDismissible: false, // يمنع القفل بدون إدخال
    builder: (context) {
      return AlertDialog(
        title: Text("Enter Password"),
        content: TextField(
          controller: controller,
          obscureText: true,
          decoration: InputDecoration(hintText: "Password"),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text == "1234") {
                isCorrect = true;
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text("Wrong Password")));
              }
            },
            child: Text("OK"),
          ),
        ],
      );
    },
  );

  return isCorrect;
}
