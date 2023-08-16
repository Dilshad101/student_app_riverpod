import 'dart:io';

import 'package:flutter/material.dart';
import '../model/student_model.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({super.key, required this.student});

  final StudentModel student;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 20),
      margin: const EdgeInsets.symmetric(vertical: 5),
      height: 100,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color(0xffE9E6E2), Colors.white]),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Container(
            height: 100,
            width: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              image: DecorationImage(
                  image: FileImage(File(student.imagePath)),
                  fit: BoxFit.cover)
            ),
          ),
          const SizedBox(width: 15),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  student.name,
                  style: const TextStyle(
                      fontSize: 20,
                      color: Color(0xff2F435A),
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: 'Batch : ',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.grey.shade600)),
                      TextSpan(
                          text: student.batch,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Colors.grey.shade600))
                    ],
                  ),
                )
              ],
            ),
          ),
          const Spacer(),
          const Icon(
            Icons.keyboard_arrow_right_rounded,
            size: 40,
          )
        ],
      ),
    );
  }
}
