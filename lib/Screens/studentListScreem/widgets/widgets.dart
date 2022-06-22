import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_manager/Screens/homeScreen/widgets/widgets.dart';
import 'package:student_manager/Screens/studentViewScreen/StudentDetailsScreen.dart';
import 'package:student_manager/model/StudentModel.dart';
import 'package:student_manager/providers/profileImageProvider.dart';
import 'package:student_manager/providers/studentProvider.dart';

class EditStudentList extends StatelessWidget {

  var imagepath;
  int index;
  EditStudentList({
    required this.index,
    Key? key,
    required this.studentList,
    required this.kheight,
    required this.StudentNameController,
    required this.StudentAgeController,
    required this.StudentBatchController,
    required this.StudentPlaceController,
  }) : super(key: key);

  final List<StudentDB> studentList;
  final SizedBox kheight;
  final TextEditingController StudentNameController;
  final TextEditingController StudentAgeController;
  final TextEditingController StudentBatchController;
  final TextEditingController StudentPlaceController;

  @override
  Widget build(BuildContext context) {
      var nameStudent=studentList[index].name;
    imagepath=Provider.of<ProfileImageProvider>(context).image;
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage:
              imagepath==null?

                              FileImage(
                                File(studentList[index].image),
                              ):
                               FileImage(
                                File(imagepath),
                ),
              ),
            ],
          ),
          kheight,
          studentTextFeild('${studentList[index].name}', StudentNameController),
          kheight,
          studentTextFeild('${studentList[index].age}', StudentAgeController),
          kheight,
          studentTextFeild(
              '${studentList[index].batch}', StudentBatchController),
          kheight,
          studentTextFeild(
              '${studentList[index].Place}', StudentPlaceController),
          kheight,
        ],
      ),
    );
  }
}


      
    



