import 'package:flutter/material.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:spu_linux_app/colors/App_colors.dart';
import 'package:spu_linux_app/widgets/Custom_text_feild.dart';

Future<bool> showPasswordDialog(BuildContext context,String Password) async {
  TextEditingController controller = TextEditingController();
  bool isCorrect = false;
  // ignore: non_constant_identifier_names
  Color color_state = Colors.green;
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      bool showText = false;

      return StatefulBuilder(
        builder: (context, setState) {
          return SimpleShadow(
            opacity: 0.9,
            color: color_state,
            offset: Offset(0, 0),
            sigma: 30,
            child: AlertDialog(
              // ignore: deprecated_member_use
              backgroundColor: AppColors.Home_screen_background.withOpacity(
                0.5,
              ),
              title: Text(
                "Enter Password",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: AppColors.Drawer_text_color,
                ),
              ),
              content: CustomTextField(
                controller: controller,
                hint: "Password",
                obscure_text: !showText,
                prefix_icon: showText
                    ? Icons.visibility_off_rounded
                    : Icons.visibility_rounded,
                icon_size: 15,
                ontap_prefix_icon: () {
                  setState(() {
                    showText = !showText;
                  });
                },
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      // ignore: deprecated_member_use
                      color: AppColors.Drawer_text_color.withOpacity(0.7),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (controller.text == Password) {
                      isCorrect = true;
                      Navigator.pop(context, true);
                    } else {
                      setState(() => color_state = Colors.red);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("❌Wrong Password")),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                  ),
                  child: Text(
                    "OK",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );

  return isCorrect;
}
