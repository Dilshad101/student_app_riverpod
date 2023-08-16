import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider_student_app/pages/details_screen.dart';
import 'package:provider_student_app/provider/student_provider.dart';

import '../widgets/listtile_widget.dart';
import 'add_student_screen.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.school_outlined,
          size: 30,
        ),
        title: const Text(
          'University of Oxford',
          style: TextStyle(fontSize: 22),
        ),
        elevation: 0,
      ),
      body: Container(
        height: deviceSize.height,
        width: deviceSize.width,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Consumer(
          builder: (context, ref, child) {
            final studentList = ref.watch(studentProvider);
            return studentList.isEmpty
                ? const Center(
                    child: Text(
                      'No Student\'s Available',
                      style: TextStyle(
                        fontSize: 24,
                        letterSpacing: 1.5,
                        color: Colors.black26,
                      ),
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Students',
                        style: TextStyle(
                          fontSize: 24,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 15),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: studentList.length,
                        itemBuilder: (context, index) {
                          final student = studentList[index];
                          return GestureDetector(
                            child: CustomListTile(student: student),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      ScreenDetails(index: index)));
                            },
                          );
                        },
                      ),
                    ],
                  );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xff333F63),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const ScreenAddStudent()));
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Student'),
      ),
    );
  }
}
