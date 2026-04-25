// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spu_linux_app/Screens/Details_screen/widgets/Sensor_details_container.dart';
import 'package:spu_linux_app/widgets/Custom_divider.dart';

class DetailsScreen extends StatefulWidget {
  DetailsScreen({super.key});
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Gap(10),
          // Appbar
          Row(
            children: [
              Gap(20),
              Text(
                "Sensors Details",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Spacer(),
            ],
          ),
          CustomDivider(),
          // screen body
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
                  return SensorDetailsContainer(
                    txt: "$index",
                    ontap: () {
                      // showAlarmDialog(
                      //   context,
                      //   // alarm_color: Colors.white,
                      //   auto_close: false,
                      //   message:
                      //       "Temprature Error\n : temp > 80 dccccccccegree",
                      // );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
