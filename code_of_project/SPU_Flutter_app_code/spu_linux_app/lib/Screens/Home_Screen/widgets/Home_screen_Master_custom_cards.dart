import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:spu_linux_app/Screens/Home_Screen/widgets/Custom_Guage.dart';
import 'package:spu_linux_app/Screens/Home_Screen/widgets/custom_container_for_master_cards.dart';
import 'package:spu_linux_app/colors/App_colors.dart';

class HomeScreenMasterCustomCards extends StatefulWidget {
  final int value;
  final String name;
  final String img;
  // ignore: non_constant_identifier_names
  final String img_icon;
  // ignore: non_constant_identifier_names
  final IconData icon;
  // ignore: non_constant_identifier_names
  final String txt_1_up;
  // ignore: non_constant_identifier_names
  final String txt_1_down;
  // ignore: non_constant_identifier_names
  final String txt_2_up;
  // ignore: non_constant_identifier_names
  final String txt_2_down;
  // ignore: non_constant_identifier_names
  final String txt_3_up;
  // ignore: non_constant_identifier_names
  final String txt_3_down;
  // ignore: non_constant_identifier_names
  final String status_name;
  // ignore: non_constant_identifier_names
  final int Days;
  // ignore: non_constant_identifier_names
  final Function() view_details;
  // ignore: non_constant_identifier_names
  final Function() alarm;
  const HomeScreenMasterCustomCards({
    super.key,
    required this.value,
    required this.name,
    required this.img,
    required this.icon,
    // ignore: non_constant_identifier_names
    required this.status_name,
    // ignore: non_constant_identifier_names
    required this.img_icon,
    // ignore: non_constant_identifier_names
    required this.txt_1_up,
    // ignore: non_constant_identifier_names
    required this.txt_1_down,
    // ignore: non_constant_identifier_names
    required this.txt_2_up,
    // ignore: non_constant_identifier_names
    required this.txt_2_down,
    // ignore: non_constant_identifier_names
    required this.txt_3_up,
    // ignore: non_constant_identifier_names
    required this.txt_3_down,
    // ignore: non_constant_identifier_names
    required this.Days,
    // ignore: non_constant_identifier_names
    required this.view_details,
    required this.alarm,
  });

  @override
  State<HomeScreenMasterCustomCards> createState() =>
      _HomeScreenMasterCustomCardsState();
}

class _HomeScreenMasterCustomCardsState
    extends State<HomeScreenMasterCustomCards> {
  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    Color card_color = Colors.red;
    if (widget.status_name.toUpperCase() == "WARNING") {
      card_color = Colors.amber;
    } else if (widget.status_name.toUpperCase() == "NORMAL") {
      card_color = Colors.green;
    } else {
      card_color = Colors.red;
    }
    return Padding(
      padding: const EdgeInsetsGeometry.symmetric(horizontal: 5),
      child: Container(
        width: 250,
        decoration: BoxDecoration(
          // ignore: deprecated_member_use
          color: card_color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: card_color, width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // upper contain
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                // ignore: deprecated_member_use
                color: card_color.withOpacity(0.3),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                ),
                border: Border.all(color: card_color, width: 1),
              ),
              child: Row(
                children: [
                  Gap(5),
                  SimpleShadow(
                    opacity: 0.9,
                    color: card_color,
                    offset: Offset(2, 2),
                    sigma: 10,
                    child: Image.asset(
                      widget.img_icon,
                      width: 30,
                      height: 30,
                      color: card_color,
                    ),
                  ),
                  Gap(10),
                  Text(
                    widget.name,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColors.Drawer_text_color,
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        // ignore: deprecated_member_use
                        color: card_color,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 10,
                        ),
                        child: Center(
                          child: Text(
                            widget.status_name.toUpperCase(),
                            style: TextStyle(
                              color: AppColors.Drawer_text_color,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Gap(10),
                ],
              ),
            ),
            // image & Gauge in center
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(image: AssetImage(widget.img), width: 100, height: 100),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Draw Health Text
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Health :  ",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppColors.Drawer_text_color,
                            fontSize: 10,
                          ),
                        ),
                        Text(
                          "${widget.value} %",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: card_color,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    // Draw Guage
                    Gap(10),
                    CustomGuage(
                      value: widget.value,
                      Guage_color: card_color,
                      center: Text(
                        "${widget.value} %",
                        style: TextStyle(
                          fontWeight: FontWeight.w100,
                          fontSize: 10,
                          // ignore: deprecated_member_use
                          color: card_color.withOpacity(0.7),
                        ),
                      ),
                    ),
                    Gap(10),
                  ],
                ),
                Gap(10),
              ],
            ),
            // sensor cards
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Gap(5),
                CustomContainerForMasterCards(
                  txt_up: widget.txt_1_up,
                  txt_down: widget.txt_1_down,
                ),
                CustomContainerForMasterCards(
                  txt_up: widget.txt_2_up,
                  txt_down: widget.txt_2_down,
                ),
                CustomContainerForMasterCards(
                  txt_up: widget.txt_3_up,
                  txt_down: widget.txt_3_down,
                ),
                Gap(5),
              ],
            ),
            // time and days
            Row(
              children: [
                Gap(5),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 5,
                  ),
                  child: Text(
                    "Predicted Fault : ",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColors.Drawer_text_color,
                      fontSize: 12,
                    ),
                  ),
                ),
                Icon(Icons.timelapse_rounded, color: card_color, size: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 5,
                  ),
                  child: Text(
                    "in ${widget.Days} Days",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.amber,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
            Divider(color: card_color),
            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: widget.view_details,
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.button_master_card_1_color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 5,
                    ),
                    child: Text(
                      "VIEW DETAILS",
                      style: TextStyle(
                        color: AppColors.Drawer_text_color,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: widget.alarm,
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.button_master_card_2_color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      "ALARMS",
                      style: TextStyle(
                        color: AppColors.Drawer_text_color,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Gap(5),
          ],
        ),
      ),
    );
  }
}
