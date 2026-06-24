import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spu_linux_app/Screens/Details_screen/widgets/Motor_details.dart';
import 'package:spu_linux_app/Screens/Details_screen/widgets/belt_Driver_details.dart';
import 'package:spu_linux_app/Screens/Details_screen/widgets/pump_details.dart';
import 'package:spu_linux_app/widgets/Custom_divider.dart';
import 'package:spu_linux_app/widgets/settings_global.dart';

class DetailsScreen extends StatefulWidget {
  final Actuator? goto;

  const DetailsScreen({super.key, this.goto = Actuator.Motor});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final ScrollController _controller = ScrollController();
  final GlobalKey motorKey = GlobalKey();
  final GlobalKey beltKey = GlobalKey();
  final GlobalKey pumpKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollTo();
    });
  }

  void scrollTo() {
    GlobalKey selectedKey;

    if (widget.goto == Actuator.Motor) {
      selectedKey = motorKey;
    } else if (widget.goto == Actuator.Belt) {
      selectedKey = beltKey;
    } else {
      selectedKey = pumpKey;
    }

    final context = selectedKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F111A),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF1A1F38), Color(0xFF0F111A)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: AppBar(
            title: const Text(
              'ACTUATORS DETAILS',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: 1.5,
                fontSize: 18,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Column(
          children: [
            const CustomDivider(),
            const Gap(12),
            Expanded(
              child: ListView(
                controller: _controller,
                physics: const BouncingScrollPhysics(),
                children: [
                  _buildSectionCard(key: motorKey, child: const MotorDetails()),
                  const Gap(20),
                  _buildSectionCard(
                    key: beltKey,
                    child: const BeltDriverDetails(),
                  ),
                  const Gap(20),
                  _buildSectionCard(key: pumpKey, child: const PumpDetails()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard({required Key key, required Widget child}) {
    return Container(
      key: key,
      decoration: BoxDecoration(
        color: const Color(0xFF16192B),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFF00F5D4).withOpacity(0.1),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: child,
    );
  }
}
