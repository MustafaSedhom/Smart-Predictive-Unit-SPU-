import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spu_linux_app/colors/App_colors.dart';
import 'package:spu_linux_app/widgets/Custom_text_feild.dart';

class CustomChanges extends StatefulWidget {
  final TextEditingController controller;

  // ignore: non_constant_identifier_names
  final bool? is_saved;
  final String? hint;
  final String? title;
  // ignore: non_constant_identifier_names
  final IconData? prefix_icon;
  // ignore: non_constant_identifier_names
  final Function() ontap_prefix_icon;
  // ignore: non_constant_identifier_names
  final Function() save_operation;
  const CustomChanges({
    super.key,
    required this.controller,
    // ignore: non_constant_identifier_names
    this.is_saved = false,
    this.hint = "msg",
    // ignore: non_constant_identifier_names
    this.prefix_icon = Icons.upload_file,
    // ignore: non_constant_identifier_names
    required this.ontap_prefix_icon,
    // ignore: non_constant_identifier_names
    required this.save_operation,
    this.title = "title",
  });

  @override
  State<CustomChanges> createState() => _CustomChangesState();
}

class _CustomChangesState extends State<CustomChanges> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // title
            Text(
              widget.title!,
              style: TextStyle(
                color: AppColors.Drawer_text_color,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Gap(20),
            // Text field
            Expanded(
              child: CustomTextField(
                controller: widget.controller,
                hint: widget.hint!,
                prefix_icon: widget.prefix_icon!,
                ontap_prefix_icon: () async {
                  await widget.ontap_prefix_icon.call();
                },
              ),
            ),
            Gap(20),
            // Save Button
            TextButton(
              onPressed: () async {
                await widget.save_operation.call();
              },
              style: TextButton.styleFrom(
                backgroundColor: AppColors.button_master_card_1_color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: widget.is_saved!
                  ? SizedBox(
                      width: 15,
                      height: 15,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.Drawer_text_color,
                      ),
                    )
                  : Text(
                      "Save",
                      style: TextStyle(
                        color: AppColors.Drawer_text_color,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
