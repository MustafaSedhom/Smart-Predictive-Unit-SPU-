import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spu_linux_app/colors/App_colors.dart';

class CustomContainerForMaxDays extends StatefulWidget {
  final String icon;
  final String text;
  final Color color;
  final List<BoxShadow> shadow;
  const CustomContainerForMaxDays({
    super.key,
    required this.icon,
    required this.text,
    required this.color, required this.shadow,
  });

  @override
  State<CustomContainerForMaxDays> createState() =>
      _CustomContainerForMaxDaysState();
}

class _CustomContainerForMaxDaysState extends State<CustomContainerForMaxDays> {
  //---------------------------------------------------------

  TextEditingController textController = TextEditingController();

  String selectedValue = "∞";

  //---------------------------------------------------------

  void updateValue(String value) {
    setState(() {
      selectedValue = value;
    });

    print(selectedValue);
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
        boxShadow: widget.shadow
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
              Gap(15),
              Text(
                widget.text,

                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.Drawer_text_color,
                  fontSize: 16,
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
                label: const Text("∞"),

                selected: selectedValue == "∞",

                onSelected: (value) {
                  updateValue("∞");
                },
              ),

              ChoiceChip(
                label: const Text("~"),

                selected: selectedValue == "~",

                onSelected: (value) {
                  updateValue("~");
                },
              ),

              ChoiceChip(
                label: const Text("Val"),

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

            decoration: InputDecoration(
              hintText: "Enter",

              filled: true,
              fillColor: Colors.white,

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),

            onChanged: (value) {
              setState(() {
                selectedValue = value;
              });

              print(selectedValue);
            },
          ),

          const Gap(15),

          //-------------------------------------------------
          // result
          //-------------------------------------------------
          Expanded(
            child: Text(
              "Value : $selectedValue",

              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
