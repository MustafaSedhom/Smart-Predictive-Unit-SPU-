// ignore_for_file: non_constant_identifier_names, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:spu_linux_app/Providers/machine_provider.dart';
import 'package:spu_linux_app/Screens/Home_Screen/widgets/Home_screen_Master_cards.dart';
import 'package:spu_linux_app/Screens/Home_Screen/widgets/Home_screen_appbar.dart';
import 'package:spu_linux_app/Screens/Home_Screen/widgets/Home_screen_titles.dart';
import 'package:spu_linux_app/widgets/Custom_divider.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback details;
  final VoidCallback alarm;
  final VoidCallback addCard;

  const HomeScreen({
    super.key,
    required this.details,
    required this.alarm,
    required this.addCard,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final cards = context.watch<MachineProvider>().cards;

    double screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const Gap(10),
          HomeScreenAppbar(),
          const Gap(5),
          CustomDivider(),
          const Gap(5),
          HomeScreenTitles(),
          Gap(screenHeight * 0.02),
          addCardButton(onTap: widget.addCard),
          Gap(screenHeight * 0.02),
          HomeScreenMasterCard(
            details: widget.details,
            alarm: widget.alarm,
            cards: cards,
          ),
        ],
      ),
    );
  }
}

Widget addCardButton({required VoidCallback onTap}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(25),
    child: Container(
      width: 300,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xff1E3A8A), Color(0xff2563EB), Color(0xff06B6D4)],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff2563EB).withOpacity(0.35),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: const Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: Color(0x33FFFFFF),
            child: Icon(Icons.add_rounded, color: Colors.white, size: 32),
          ),
          SizedBox(width: 18),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Add New Card",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Create a custom machine card",
                  style: TextStyle(color: Colors.white70, fontSize: 11),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white70,
              size: 16,
            ),
          ),
        ],
      ),
    ),
  );
}
