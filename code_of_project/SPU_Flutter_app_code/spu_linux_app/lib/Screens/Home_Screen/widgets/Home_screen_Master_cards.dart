// ignore_for_file: non_constant_identifier_names, unused_local_variable

import 'package:flutter/material.dart';
import 'package:spu_linux_app/Screens/Home_Screen/widgets/Home_screen_Master_custom_cards.dart';
import 'package:spu_linux_app/Screens/Home_Screen/widgets/machine_card_data.dart';
import 'package:spu_linux_app/widgets/remove_dalaog_card.dart';

class HomeScreenMasterCard extends StatefulWidget {
  final VoidCallback details;
  final VoidCallback alarm;
  final List<MachineCardData> cards;
  const HomeScreenMasterCard({
    super.key,
    required this.details,
    required this.alarm,
    required this.cards,
  });

  @override
  State<HomeScreenMasterCard> createState() => _HomeScreenMasterCardState();
}

class _HomeScreenMasterCardState extends State<HomeScreenMasterCard> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    int crossAxisCount;

    if (width >= 1400) {
      crossAxisCount = 3;
    } else if (width >= 800) {
      crossAxisCount = 2;
    } else {
      crossAxisCount = 1;
    }

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Wrap(
        spacing: 8,
        runSpacing: 20,
        children: widget.cards.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;

          return GestureDetector(
            onLongPress: () {
              removeDialogCard(context, index);
            },
            child: SizedBox(
              width: 260,
              height: 310,
              child: HomeScreenMasterCustomCards(
                value: item.value.toInt(),
                name: item.name,
                img: item.img,
                img_icon: item.imgIcon,
                icon: Icons.macro_off,
                status_name: item.statusName,
                txt_1_up: item.sensor_1_name,
                txt_1_down: item.sensor_1_value,
                txt_2_up: item.sensor_2_name,
                txt_2_down: item.sensor_2_value,
                txt_3_up: item.sensor_3_name,
                txt_3_down: item.sensor_3_value,
                Days: item.days,
                view_details: widget.details,
                alarm: widget.alarm,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
