

import 'package:flutter/material.dart';

class DetailsTextWidget extends StatelessWidget {
  const DetailsTextWidget({
    super.key,
    required this.label,
    required this.value,
    this.isSub = true,
  });

  final String label;
  final String value;
  final bool isSub;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black.withOpacity(.6),
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        Container(
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            // border: Border.all(width: 1, color: Colors.grey),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 5),
          alignment: Alignment.centerLeft,
          child: Text(
            value,
            style: TextStyle(
              fontSize: isSub ? 18 : 25,
              color: Colors.black87,
              letterSpacing: 1,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
