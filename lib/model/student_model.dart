class StudentModel {
  int? id;
  String name;
  String age;
  String batch;
  String regNum;
  String imagePath;

  StudentModel({
    required this.age,
    required this.name,
    required this.batch,
    required this.imagePath,
    required this.regNum,
    this.id,
  });
}
