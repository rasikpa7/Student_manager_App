import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:student_manager/Screens/homeScreen/widgets/widgets.dart';
import 'package:student_manager/model/StudentModel.dart';
import 'package:student_manager/providers/studentProvider.dart';

class StudentDetailsScreen extends StatelessWidget {
  int index;
  StudentDetailsScreen({Key? key, this.index = 0}) : super(key: key);
  static const routeName = '/student-details';

  @override
  Widget build(BuildContext context) {
    const kheight = SizedBox(
      height: 10,
    );
    const kheight30 = SizedBox(
      height: 30,
    );
    final student = Provider.of<StudentProvider>(context).studentBox;
    final studentList = student.values.toList();
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Colors.blue,
          Colors.blueGrey,
        ],
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('STUDENT INFO'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: ListView(
            children: [
              kheight,
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    File(studentList[index].image),
                    fit: BoxFit.cover,
                    height: 250,
                    width: 300,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start, 
                children: [
                  kheight30,
                StudentDetails(str: 'name   :'.toUpperCase(), main: studentList[index].name.toUpperCase()),
                kheight30,
                 StudentDetails(str: 'age       :'.toUpperCase(), main: studentList[index].age.toUpperCase()),
                 kheight30,
                  StudentDetails(str:'place  : '.toUpperCase(), main: studentList[index].Place.toUpperCase()),
                  kheight30,
                   StudentDetails(str: 'batch  :'.toUpperCase(), main: studentList[index].batch.toUpperCase()),

                  // StudentTextField(studentList[index].name.toUpperCase(),'Name : '),
                  // kheight30,
                  // StudentTextField(studentList[index].age.toUpperCase(),'Age : '),
                  // kheight30,
                  // StudentTextField(studentList[index].Place.toUpperCase(),'Place : '),
                  // kheight30,
                  // StudentTextField(studentList[index].batch.toUpperCase(),'Batch : '),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}

class StudentDetails extends StatelessWidget {

  const StudentDetails({
    Key? key,
    required this.str,
   required this.main
  }) : super(key: key);
final String main;
  final String str;

  @override
  Widget build(BuildContext context) {
    return Row(             mainAxisAlignment: MainAxisAlignment.start,
     
      children: [
       const  SizedBox(width: 50,),
        Text(str, style:  const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),),
        const SizedBox(width: 25,),
        Expanded(
          child: Text(
            main, style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis
          ),
            
          ),
        ),
      ],
    );
  }
}