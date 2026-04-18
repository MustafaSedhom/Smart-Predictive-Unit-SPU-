import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CustomContainerForMasterCards extends StatefulWidget {
  // ignore: non_constant_identifier_names
  final String txt_up;
  // ignore: non_constant_identifier_names
  final String txt_down;
  const CustomContainerForMasterCards({
    super.key,
    // ignore: non_constant_identifier_names
    required this.txt_up,
    // ignore: non_constant_identifier_names
    required this.txt_down,
  });

  @override
  State<CustomContainerForMasterCards> createState() =>
      _CustomContainerForMasterCardsState();
}

class _CustomContainerForMasterCardsState
    extends State<CustomContainerForMasterCards> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white, width: 0.25),
        // ignore: deprecated_member_use
        color: Colors.blue.withOpacity(0.1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.txt_up,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 10,
              color: Colors.white,
            ),
          ),
          Gap(5),
          Text(
            widget.txt_down,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
