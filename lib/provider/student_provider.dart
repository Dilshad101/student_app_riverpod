import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider_student_app/model/student_model.dart';

final studentProvider =
    StateNotifierProvider<StudentNotifier, List<StudentModel>>(
  (ref) => StudentNotifier(),
);

class StudentNotifier extends StateNotifier<List<StudentModel>> {
  StudentNotifier() : super([]);
  void addStudent(StudentModel student) {
    state = [...state, student];
  }

  updateStudent(int index, StudentModel updatedStudent) {
    state = state
        .map((student) => student == state[index] ? updatedStudent : student)
        .toList();
  }

  deleteStudent(int index) {
   
    // state=[...state];
    // state.removeAt(index);
    state = state.where((student) => student != state[index]).toList();
  }
}
