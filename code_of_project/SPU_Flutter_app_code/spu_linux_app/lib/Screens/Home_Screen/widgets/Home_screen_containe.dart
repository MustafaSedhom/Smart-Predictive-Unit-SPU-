import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spu_linux_app/Responsive/Screen_Area.dart';
import 'package:spu_linux_app/Screens/Home_Screen/widgets/Home_screen_Master_cards.dart';
import 'package:spu_linux_app/Screens/Home_Screen/widgets/Home_screen_appbar.dart';
import 'package:spu_linux_app/Screens/Home_Screen/widgets/Home_screen_titles.dart';

class HomeScreenContainers extends StatelessWidget {
  const HomeScreenContainers({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          HomeScreenAppbar(),
          Gap(10),
          Divider(),
          Gap(20),
          HomeScreenTitles(),
          Gap(20),
          HomeScreenMasterCard(),
        ],
      ),
    );
  }
}
