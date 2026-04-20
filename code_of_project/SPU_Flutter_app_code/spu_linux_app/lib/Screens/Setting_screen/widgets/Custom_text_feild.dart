import 'package:flutter/material.dart';
import 'package:spu_linux_app/colors/App_colors.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  // ignore: non_constant_identifier_names
  final IconData prefix_icon;
  // ignore: non_constant_identifier_names
  final IconData suffix_icon;
  // ignore: non_constant_identifier_names
  final Function() ontap_suffix_icon;

  const CustomTextField({
    super.key,
    required this.controller,
    this.hint = "Enter text",
    // ignore: non_constant_identifier_names
    required this.ontap_suffix_icon,
    // ignore: non_constant_identifier_names
    this.prefix_icon = Icons.edit,
    // ignore: non_constant_identifier_names
    this.suffix_icon = Icons.edit,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (value) {
        setState(() => isFocused = value);
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.Home_screen_background,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isFocused
                ? AppColors.Drawer_icon_selected_color
                // ignore: deprecated_member_use
                : AppColors.Drawer_icon_selected_color.withOpacity(0.4),
            width: 3,
          ),
          boxShadow: [
            if (isFocused)
              BoxShadow(
                // ignore: deprecated_member_use
                color: Colors.greenAccent.withOpacity(0.3),
                blurRadius: 10,
                spreadRadius: 1,
              ),
          ],
        ),
        child: TextFormField(
          controller: widget.controller,
          style: TextStyle(
            color: AppColors.Drawer_text_color,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: TextStyle(
              // ignore: deprecated_member_use
              color: AppColors.Drawer_text_color.withOpacity(0.5),
            ),

            prefixIcon: Icon(
              widget.prefix_icon,
              color: AppColors.Drawer_text_color,
            ),
            suffix: InkWell(
              onTap: widget.ontap_suffix_icon,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 8,
                ),
                child: Icon(
                  widget.suffix_icon,
                  color: AppColors.Drawer_text_color,
                ),
              ),
            ),

            suffixIcon: widget.controller.text.isNotEmpty
                ? IconButton(
                    icon: Icon(Icons.close, color: Colors.red),
                    onPressed: () {
                      widget.controller.clear();
                      setState(() {});
                    },
                  )
                : null,

            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,

            contentPadding: EdgeInsets.symmetric(vertical: 14),
          ),
          onChanged: (_) => setState(() {}),
        ),
      ),
    );
  }
}
