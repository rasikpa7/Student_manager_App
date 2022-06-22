import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_manager/model/StudentModel.dart';



class StudentProvider extends ChangeNotifier{
  final studentBox = Hive.box<StudentDB>('student');

  void addStudent(StudentDB student){
   
    studentBox.add(student);
  
    notifyListeners();
  }

  void editStudent(StudentDB student, int key){
    studentBox.putAt(key, student);
    notifyListeners();
  }
  void deleteStudent(int index){
    studentBox.deleteAt(index);

    notifyListeners();
  }
}