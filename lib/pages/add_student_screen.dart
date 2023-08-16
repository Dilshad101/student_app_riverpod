// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider_student_app/model/student_model.dart';
import 'package:provider_student_app/provider/student_provider.dart';

import '../widgets/snackbar_widget.dart';
import '../widgets/text_widget.dart';

class ScreenAddStudent extends StatefulWidget {
  const ScreenAddStudent({super.key, this.student, this.index});
  final StudentModel? student;
  final int? index;

  @override
  State<ScreenAddStudent> createState() => _ScreenAddStudentState();
}

class _ScreenAddStudentState extends State<ScreenAddStudent> {
  File? profileImage;

  final nameController = TextEditingController();

  final ageController = TextEditingController();

  final batchController = TextEditingController();

  final regController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  populateData() {
    if (widget.student != null) {
      nameController.text = widget.student!.name;
      ageController.text = widget.student!.age;
      batchController.text = widget.student!.batch;
      regController.text = widget.student!.regNum;
      profileImage = File(widget.student!.imagePath);
    }
  }

  @override
  void initState() {
    super.initState();
    populateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(widget.student == null ? 'New Student' : 'Edit Student'),
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          children: [
            const SizedBox(height: 30),
            InkWell(
              onTap: getImage,
              child: Container(
                alignment: Alignment.center,
                height: 230,
                width: 180,
                margin: const EdgeInsets.only(right: 180),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.grey.shade300,
                  image: profileImage == null
                      ? null
                      : DecorationImage(
                          image: FileImage(File(profileImage!.path)),
                          fit: BoxFit.cover,
                        ),
                ),
                child: profileImage == null
                    ? Text(
                        'Tap To Add Image',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700,
                        ),
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 30),
            CustomTextField(
              controller: nameController,
              label: 'Name',
              type: TextInputType.text,
              onChanged: (value) {},
              validator: (value) {
                if (value.toString().isEmpty) {
                  return 'Please Enter Student Name';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: ageController,
              label: 'Age',
              type: TextInputType.number,
              onChanged: (value) {},
              validator: (value) {
                if (value.toString().isEmpty) {
                  return 'Please Enter Age';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: batchController,
              label: 'Batch',
              type: TextInputType.number,
              onChanged: (value) {},
              validator: (value) {
                if (value.toString().isEmpty) {
                  return 'Please Enter Batch';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: regController,
              label: 'Register Number',
              type: TextInputType.number,
              onChanged: (value) {},
              validator: (value) {
                if (value.toString().isEmpty) {
                  return 'Please Enter  RegisterNumber';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Consumer(builder: (context, ref, _) {
        return FloatingActionButton(
          backgroundColor: const Color(0xff333F63),
          onPressed: () {
            addStudent(ref, context,
                isEdit: widget.student == null ? false : true);
          },
          child: const Icon(Icons.done),
        );
      }),
    );
  }

  addStudent(WidgetRef ref, BuildContext context, {bool isEdit = false}) async {
    if (profileImage == null) {
      return snackBarMessenger(
          context: context,
          color: Colors.redAccent,
          message: 'Please Add Student Image');
    }
    if (_formKey.currentState!.validate()) {
      final name = nameController.text;
      final age = ageController.text;
      final batch = batchController.text;
      final regnum = regController.text;

      if (isEdit == false) {
        final newStudent = StudentModel(
            age: age,
            name: name,
            batch: batch,
            imagePath: profileImage!.path,
            regNum: regnum);
        ref.read(studentProvider.notifier).addStudent(newStudent);
        snackBarMessenger(
          context: context,
          color: Colors.green,
          message: 'Student Added Succesfully',
        );
      } else {
        widget.student!.name = name;
        widget.student!.age = age;
        widget.student!.batch = batch;
        widget.student!.regNum = regnum;
        widget.student!.imagePath = profileImage!.path;

        ref
            .read(studentProvider.notifier)
            .updateStudent(widget.index!, widget.student!);
        snackBarMessenger(
          context: context,
          color: Colors.green,
          message: 'Student Edited Succesfully',
        );
      }

      Navigator.of(context).pop();
    }
  }

  getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        profileImage = File(image.path);
      });
    }
  }
}
