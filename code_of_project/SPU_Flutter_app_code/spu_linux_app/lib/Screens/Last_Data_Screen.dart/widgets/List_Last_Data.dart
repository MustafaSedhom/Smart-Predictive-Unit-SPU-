// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ListLastData extends StatefulWidget {
  final List<String> data;

  const ListLastData({super.key, required this.data});

  @override
  State<ListLastData> createState() => _ListLastDataState();
}

class _ListLastDataState extends State<ListLastData> {
  String formatHeader(String text) {
    List<String> words = text.replaceAll("_", " ").split(" ");

    /// remove P if first word is Volt or Current
    if (words.isNotEmpty &&
        (words[0].toLowerCase() == "volt" ||
            words[0].toLowerCase() == "current")) {
      words.removeWhere((word) => word.toUpperCase() == "P");
    }

    /// change Temperature -> Temp
    if (words.isNotEmpty && words[0].toLowerCase() == "temperature") {
      words[0] = "Temp";
    }

    return words
        .map(
          (word) => word.isNotEmpty
              ? "${word[0].toUpperCase()}${word.substring(1).toLowerCase()}"
              : "",
        )
        .join(" ");
  }

  @override
  Widget build(BuildContext context) {
    // header
    List<String> headers = widget.data.first.replaceAll(", ", "").split(",");
    // rows
    List<String> rows = widget.data.sublist(1);
    return Column(
      children: [
        // HEADER
        Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
          decoration: BoxDecoration(
            color: const Color(0xff22C55E),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: List.generate(headers.length, (index) {
              return Expanded(
                flex: index == 0 ? 2 : 1,
                child: Text(
                  formatHeader(headers[index]),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              );
            }),
          ),
        ),
        Gap(10),
        // DATA
        Expanded(
          child: ListView.builder(
            itemCount: rows.length,
            itemBuilder: (context, index) {
              List<String> values = rows[index].replaceAll(", ", "").split(",");

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white12),
                ),
                child: Row(
                  children: List.generate(values.length, (i) {
                    return Expanded(
                      flex: i == 0 ? 2 : 1,
                      child: Text(
                        values[i],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: i == 0
                              ? const Color(0xff22C55E)
                              : Colors.white,

                          fontWeight: i == 0
                              ? FontWeight.bold
                              : FontWeight.normal,

                          fontSize: 13,
                        ),
                      ),
                    );
                  }),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
