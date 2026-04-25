import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spu_linux_app/Images/images_and_icons.dart';
import 'package:spu_linux_app/Screens/Home_Screen/widgets/Home_screen_appbar.dart';
import 'package:spu_linux_app/colors/App_colors.dart';
import 'package:spu_linux_app/widgets/Custom_text_feild.dart';

class DiameterSettingWidget extends StatefulWidget {
  final String? title;
  final String? img;
  final double? size;
  const DiameterSettingWidget({
    super.key,
    this.title = "title",
    this.img = AppIcons.motor_Icon,
    this.size = 20,
  });

  @override
  State<DiameterSettingWidget> createState() => _DiameterSettingWidgetState();
}

class _DiameterSettingWidgetState extends State<DiameterSettingWidget> {
  double diameter = 10;
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.text = diameter.toString();
  }

  void increase() {
    setState(() {
      diameter++;
      controller.text = diameter.toString();
    });
  }

  void decrease() {
    setState(() {
      if (diameter > 0) {
        diameter--;
        controller.text = diameter.toString();
      }
    });
  }

  void onTextChanged(String value) {
    final num? val = num.tryParse(value);
    if (val != null) {
      setState(() {
        diameter = val.toDouble();
      });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.Drawer_color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            //text
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title!,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.Drawer_text_color,
                  ),
                ),
                Gap(20),
                Image.asset(widget.img!, width: widget.size),
              ],
            ),
            // buttons and text feild
            Gap(30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // - button
                ElevatedButton(
                  onPressed: decrease,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(15),
                  ),
                  child: Center(
                    child: const Text(
                      "-",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: AppColors.Drawer_text_color,
                      ),
                    ),
                  ),
                ),
                Gap(5),
                // TextField
                SizedBox(
                  width: 120,
                  child: CustomTextField(
                    controller: controller,
                    show_icons: false,
                    show_hint_text: false,
                    text_align: TextAlign.center,
                    text_input: TextInputType.number,
                    onChanged: onTextChanged,
                    suffix_text: "mm",
                  ),
                ),
                Gap(5),
                // + button
                ElevatedButton(
                  onPressed: increase,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(15),
                  ),
                  child: Center(
                    child: const Text(
                      "+",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: AppColors.Drawer_text_color,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
