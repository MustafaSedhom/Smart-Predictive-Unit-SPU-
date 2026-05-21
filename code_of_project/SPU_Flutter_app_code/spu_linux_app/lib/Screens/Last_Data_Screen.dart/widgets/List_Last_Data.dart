// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ListLastData extends StatefulWidget {
  final List<String> Data;
  const ListLastData({super.key, required this.Data});

  @override
  State<ListLastData> createState() => _ListLastDataState();
}
class _ListLastDataState extends State<ListLastData> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.Data.length,
      itemBuilder: (context, index) {
        final data = widget.Data[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 14),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.06),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xff22C55E).withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.analytics, color: Color(0xff22C55E)),
              ),
              Gap(15),
              Expanded(
                child: Text(
                  data,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
