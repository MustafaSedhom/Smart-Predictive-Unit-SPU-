import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spu_linux_app/colors/App_colors.dart';

class CustomContainerForMaxDays extends StatefulWidget {
  final String icon;
  final String text;
  final Color color;
  final List<BoxShadow> shadow;
  final String current_val;
  final Function(String val)? get_value;
  const CustomContainerForMaxDays({
    super.key,
    required this.icon,
    required this.text,
    required this.color,
    required this.shadow,
    this.get_value,
    required this.current_val,
  });

  @override
  State<CustomContainerForMaxDays> createState() =>
      _CustomContainerForMaxDaysState();
}

class _CustomContainerForMaxDaysState extends State<CustomContainerForMaxDays> {
  //---------------------------------------------------------
  late String selectedValue;

  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    //-------------------------------------------------
    // load current value
    //-------------------------------------------------

    selectedValue = widget.current_val;

    //-------------------------------------------------
    // if custom text
    //-------------------------------------------------

    if (selectedValue != "∞" && selectedValue != "~") {
      textController.text = selectedValue;
    }
  }

  //---------------------------------------------------------

  void updateValue(String value) {
    setState(() {
      selectedValue = value;
    });

    widget.get_value?.call(value);
  }

  //---------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: 240,

      padding: const EdgeInsets.all(15),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: widget.color,
        boxShadow: widget.shadow,
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          //-------------------------------------------------
          // icon + title
          //-------------------------------------------------
          Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Image.asset(
                widget.icon,
                width: 40,
                height: 40,
                color: AppColors.Drawer_text_color,
              ),

              const Gap(15),

              Expanded(
                child: Text(
                  widget.text,

                  overflow: TextOverflow.ellipsis,

                  style: TextStyle(
                    fontWeight: FontWeight.bold,

                    color: AppColors.Drawer_text_color,

                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),

          const Gap(20),

          //-------------------------------------------------
          // options
          //-------------------------------------------------
          Wrap(
            spacing: 10,
            runSpacing: 10,

            children: [
              ChoiceChip(
                label: Text("∞", style: TextStyle(color: widget.color)),

                selected: selectedValue == "∞",
                checkmarkColor: widget.color,
                onSelected: (value) {
                  updateValue("∞");
                },
              ),

              ChoiceChip(
                checkmarkColor: widget.color,
                label: Text("~", style: TextStyle(color: widget.color)),

                selected: selectedValue == "~",

                onSelected: (value) {
                  updateValue("~");
                },
              ),

              ChoiceChip(
                checkmarkColor: widget.color,
                label: Text("txt", style: TextStyle(color: widget.color)),

                selected: selectedValue != "∞" && selectedValue != "~",

                onSelected: (value) {
                  updateValue(textController.text);
                },
              ),
            ],
          ),

          const Gap(20),

          //-------------------------------------------------
          // text field
          //-------------------------------------------------
          TextField(
            controller: textController,

            style: TextStyle(color: AppColors.Drawer_text_color),
            decoration: InputDecoration(
              hintText: "Enter",
              hintStyle: TextStyle(color: AppColors.Drawer_text_color),
              filled: true,
              fillColor: widget.color,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.Drawer_text_color),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),

                borderSide: const BorderSide(
                  color: Colors.white, // border color
                  width: 2,
                ),
              ),
            ),

            onChanged: (value) {
              updateValue(value);
            },
          ),

          const Spacer(),

          //-------------------------------------------------
          // result
          //-------------------------------------------------
          Text(
            "Value : $selectedValue",

            overflow: TextOverflow.ellipsis,

            style: TextStyle(
              color: AppColors.Drawer_text_color,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
