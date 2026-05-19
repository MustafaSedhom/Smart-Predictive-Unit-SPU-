//---------------------------------------------------------
// Bottom Picker
// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

Future<DateTime?> Show_Bottom_Picker_For_Time(
  BuildContext context,
  DateTime initialDateTime,
) async {
  DateTime tempDate = initialDateTime;

  final result = await showModalBottomSheet<DateTime>(
    context: context,

    backgroundColor: Colors.white,

    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
    ),

    builder: (context) {
      return SizedBox(
        height: 320,

        child: Column(
          children: [
            Gap(15),

            Text(
              "Select Time",

              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            Expanded(
              child: CupertinoDatePicker(
                //-------------------------------------------------
                // Date Only
                mode: CupertinoDatePickerMode.time,

                //-------------------------------------------------
                initialDateTime: tempDate,

                //-------------------------------------------------
                minimumYear: 2020,
                maximumYear: 2100,

                //-------------------------------------------------
                onDateTimeChanged: (DateTime newDateTime) {
                  tempDate = newDateTime;
                },
              ),
            ),

            //-------------------------------------------------
            // Done Button
            Padding(
              padding: const EdgeInsets.all(15),

              child: SizedBox(
                width: double.infinity,

                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, tempDate);
                  },

                  child: Text("Done"),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );

  return result;
}

Future<DateTime?> Show_Bottom_Picker_For_Date(
  BuildContext context,
  DateTime initialDateTime,
) async {
  DateTime tempDate = initialDateTime;

  final result = await showModalBottomSheet<DateTime>(
    context: context,

    backgroundColor: Colors.white,

    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
    ),

    builder: (context) {
      return SizedBox(
        height: 320,

        child: Column(
          children: [
            Gap(15),

            Text(
              "Select Date",

              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            Expanded(
              child: CupertinoDatePicker(
                //-------------------------------------------------
                // Date Only
                mode: CupertinoDatePickerMode.date,

                //-------------------------------------------------
                initialDateTime: tempDate,

                //-------------------------------------------------
                minimumYear: 2020,
                maximumYear: 2100,

                //-------------------------------------------------
                onDateTimeChanged: (DateTime newDateTime) {
                  tempDate = newDateTime;
                },
              ),
            ),

            //-------------------------------------------------
            // Done Button
            Padding(
              padding: const EdgeInsets.all(15),

              child: SizedBox(
                width: double.infinity,

                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, tempDate);
                  },

                  child: Text("Done"),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );

  return result;
}
