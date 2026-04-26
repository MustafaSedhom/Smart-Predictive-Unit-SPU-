
import 'package:flutter/material.dart';
import 'package:spu_linux_app/colors/App_colors.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  // ignore: non_constant_identifier_names
  final IconData prefix_icon;
  // ignore: non_constant_identifier_names
  final Function()? ontap_prefix_icon;
  // ignore: non_constant_identifier_names
  final TextStyle? Text_style;
  // ignore: non_constant_identifier_names
  final double? icon_size;
  // ignore: non_constant_identifier_names
  final bool? obscure_text;
  // ignore: non_constant_identifier_names
  final bool? show_icons;
  // ignore: non_constant_identifier_names
  final bool? show_hint_text;
  // ignore: non_constant_identifier_names
  final TextAlign? text_align;
  // ignore: non_constant_identifier_names
  final TextInputType? text_input;
  // ignore: non_constant_identifier_names
  final Function(String)? onChanged;
  // ignore: non_constant_identifier_names
  final String? suffix_text;

  const CustomTextField({
    super.key,
    required this.controller,
    this.hint = "Enter text",
    // ignore: non_constant_identifier_names, avoid_init_to_null
    this.ontap_prefix_icon = null,
    // ignore: non_constant_identifier_names
    this.prefix_icon = Icons.edit,
    // ignore: non_constant_identifier_names
    this.Text_style = const TextStyle(
      color: AppColors.Drawer_text_color,
      fontSize: 15,
      fontWeight: FontWeight.bold,
      // ignore: non_constant_identifier_names
    ),
    // ignore: non_constant_identifier_names
    this.icon_size = 25,
    // ignore: non_constant_identifier_names
    this.obscure_text = false,
    // ignore: non_constant_identifier_names
    this.show_icons = true,
    // ignore: non_constant_identifier_names
    this.show_hint_text = true,
    // ignore: non_constant_identifier_names
    this.text_align = TextAlign.start,
    // ignore: non_constant_identifier_names, avoid_init_to_null
    this.text_input = null,
    // ignore: avoid_init_to_null
    this.onChanged = null,
    // ignore: non_constant_identifier_names
    this.suffix_text,
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
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
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
          onChanged: widget.onChanged,
          obscureText: widget.obscure_text!,
          controller: widget.controller,
          style: widget.Text_style,
          textAlign: widget.text_align!,
          keyboardType: widget.text_input,

          decoration: InputDecoration(
            suffixText: widget.suffix_text,
            hintText: (widget.show_hint_text!) ? widget.hint : null,
            hintStyle: TextStyle(
              // ignore: deprecated_member_use
              color: AppColors.Drawer_text_color.withOpacity(0.5),
            ),

            prefixIcon: (widget.show_icons!)
                ? InkWell(
                    onTap: (widget.show_icons!)
                        ? widget.ontap_prefix_icon
                        : null,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 8,
                      ),
                      child: (widget.show_icons!)
                          ? Icon(
                              widget.prefix_icon,
                              color: AppColors.Drawer_text_color,
                              size: widget.icon_size,
                            )
                          : null,
                    ),
                  )
                : null,
            suffixIcon: (widget.show_icons!)
                ? widget.controller.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(
                            Icons.close,
                            color: Colors.red,
                            size: widget.icon_size,
                          ),
                          onPressed: () {
                            widget.controller.clear();
                            setState(() {});
                          },
                        )
                      : null
                : null,

            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,

            contentPadding: EdgeInsets.symmetric(vertical: 14),
          ),
          // onChanged: (_) => setState(() {}),
        ),
      ),
    );
  }
}
