  // ignore_for_file: deprecated_member_use, unused_element

  import 'package:flutter/material.dart';
import 'package:gap/gap.dart';


void custom_snake_bar(BuildContext context,String message, Color glowColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF16192B),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: glowColor.withOpacity(0.5), width: 1),
        ),
        content: Row(
          children: [
            Icon(Icons.gpp_good_rounded, color: glowColor, size: 20),
            const Gap(12),
            Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }