import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider_student_app/model/student_model.dart';
import 'package:provider_student_app/pages/add_student_screen.dart';
import 'package:provider_student_app/provider/student_provider.dart';

import '../widgets/details_text_widget.dart';
import '../widgets/popup_warning.dart';

class ScreenDetails extends ConsumerWidget {
  const ScreenDetails({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final student = getStudent(ref);
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  value: 0,
                  child: Text('Edit'),
                ),
                const PopupMenuItem(
                  value: 1,
                  child: Text('Delete'),
                ),
              ];
            },
            onSelected: (value) {
              if (value == 0) {
                onDelete(context, student!);
              } else if (value == 1) {
                onEdit(context, ref);
              }
            },
          )
        ],
      ),
      body: student == null
          ? const Center(
              child: Text(
                'No Student Available',
              ),
            )
          : SingleChildScrollView(
              child: BackdropFilter(
              filter: const ColorFilter.linearToSrgbGamma(),
              child: Container(
                height: size.height * .7,
                width: size.width,
                margin:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xffE9E6E2),
                        Colors.white,
                      ]),
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Image
                    Container(
                      height: size.height * .3,
                      width: size.width * .6,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: FileImage(File(student.imagePath)),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    const SizedBox(height: 50),
                    // details
                    DetailsTextWidget(
                      value: student.name,
                      label: 'Name',
                      isSub: false,
                    ),
                    DetailsTextWidget(
                      value: student.age,
                      label: 'Age',
                    ),
                    DetailsTextWidget(
                      value: student.batch,
                      label: 'Batch',
                    ),
                    DetailsTextWidget(
                      value: student.regNum,
                      label: 'Register Number',
                    ),
                  ],
                ),
              ),
            )),
    );
  }

  StudentModel? getStudent(WidgetRef ref) {
    try {
      return ref.watch(studentProvider)[index];
    } catch (e) {
      return null;
    }
  }

  onDelete(BuildContext context, StudentModel student) {
    popUpMessenger(
      buttonText: 'Edit',
      color: Colors.blue,
      context: context,
      text: "Edit Student Deatials ? ",
      onPressed: () {
        Navigator.of(context).pop();
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ScreenAddStudent(
                  student: student,
                  index: index,
                )));
      },
    );
  }

  onEdit(BuildContext context, WidgetRef ref) {
    popUpMessenger(
      buttonText: 'Delete',
      color: Colors.redAccent,
      context: context,
      text: "This Action can't be Undone",
      onPressed: () {
        ref.read(studentProvider.notifier).deleteStudent(index);
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      },
    );
  }
}
