import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spu_linux_app/Screens/Home_Screen/widgets/Home_screen_appbar.dart';
import 'package:spu_linux_app/colors/App_colors.dart';

class HomeScreenContainers extends StatelessWidget {
  const HomeScreenContainers({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: HomeScreenAppbar());
  }
}
