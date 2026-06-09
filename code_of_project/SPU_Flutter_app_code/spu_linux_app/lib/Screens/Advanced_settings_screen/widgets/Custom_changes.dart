// ignore_for_file: deprecated_member_use

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
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              height: 40,
              width: widget.is_saved! ? 45 : 90,
              decoration: BoxDecoration(
                color: widget.is_saved!
                    ? Colors.green
                    : AppColors.button_master_card_1_color,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color:
                        (widget.is_saved!
                                ? Colors.green
                                : AppColors.button_master_card_1_color)
                            .withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () async {
                    await widget.save_operation.call();
                  },
                  child: Center(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) {
                        return ScaleTransition(
                          scale: animation,
                          child: FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                        );
                      },
                      child: widget.is_saved!
                          ? const Icon(
                              Icons.check_rounded,
                              key: ValueKey("saved"),
                              color: Colors.white,
                              size: 22,
                            )
                          : const Text(
                              "Save",
                              key: ValueKey("save"),
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
