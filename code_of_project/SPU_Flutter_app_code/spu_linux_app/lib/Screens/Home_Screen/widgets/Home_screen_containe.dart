// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spu_linux_app/Screens/Home_Screen/widgets/Home_screen_Master_cards.dart';
import 'package:spu_linux_app/Screens/Home_Screen/widgets/Home_screen_appbar.dart';
import 'package:spu_linux_app/Screens/Home_Screen/widgets/Home_screen_titles.dart';

class HomeScreenContainers extends StatelessWidget {
  const HomeScreenContainers({super.key});

  @override
  Widget build(BuildContext context) {
    double screen_hight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          Gap(10),
          HomeScreenAppbar(),
          Gap(5),
          Divider(),
          Gap(screen_hight * 0.05),
          HomeScreenTitles(),
          Gap(screen_hight * 0.1),
          HomeScreenMasterCard(),
        ],
      ),
    );
  }
}
