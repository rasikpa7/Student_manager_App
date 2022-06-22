

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:student_manager/Screens/homeScreen/widgets/widgets.dart';
import 'package:student_manager/Screens/studentListScreem/stundentListScreen.dart';
import 'package:student_manager/main.dart';
import 'package:student_manager/model/StudentModel.dart';
import 'package:student_manager/providers/profileImageProvider.dart';
import 'package:student_manager/providers/studentProvider.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);
  TextEditingController StudentNameController = TextEditingController();
  TextEditingController StudentAgeController = TextEditingController();
  TextEditingController StudentBatchController = TextEditingController();
  TextEditingController StudentPlaceController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  dynamic imagepath;
  @override
  Widget build(BuildContext context) {
       imagepath=Provider.of<ProfileImageProvider>(context).image;
    const kHeight20 = SizedBox(
      height: 20,
    );
    const kHeight30 = SizedBox(
      height: 30,
    );

    return Container( decoration:const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.blue,
                Colors.blueGrey
              ],
            )
          ),
      child: Scaffold(
      
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Student Manager'),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
            
                  Navigator.of(context).pushNamed(StudentListScreen.routeName);
                },
                icon: const Icon(Icons.list))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: ListView(
            shrinkWrap: true,
  
            children: [
              kHeight20,
               Center(
                child: imagepath == null ? CircleAvatar(
                 child: ClipRRect(child: Lottie.network('https://assets3.lottiefiles.com/packages/lf20_gsiJ2w.json',fit: BoxFit.cover,)),
                 
                  radius: 70,
                ):
                CircleAvatar(
             
                  backgroundImage: FileImage(File(imagepath!))
               ,
           
                  radius: 70,
                ),
              ),
              kHeight20,
              studentTextFeild('Student Name', StudentNameController),
              kHeight20,
              studentTextFeild('Student Age', StudentAgeController),
              kHeight20,
              studentTextFeild('Student Batch', StudentBatchController),
              kHeight20,
              studentTextFeild('Student Place', StudentPlaceController),
              kHeight20,
              kHeight30,
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                ElevatedButton.icon(
                    onPressed: () async {
                      XFile? image =
                          await _picker.pickImage(source: ImageSource.gallery);
                      if (image == null) {
                       imagepath==null;
                      } else {
                        imagepath =Provider.of<ProfileImageProvider>(context,listen: false).changeImage(image: image.path);
                      }
                    },
                    icon: Icon(Icons.photo),
                    label: Text('Gallery')),
                ElevatedButton(
                    onPressed: () async {
                      XFile? image =
                          await _picker.pickImage(source: ImageSource.camera);
                      if (image == null) {
                        imagepath =
                            'https://cdn3.iconfinder.com/data/icons/google-material-design-icons/48/ic_account_circle_48px-512.png';
                      } else {
                        imagepath =Provider.of<ProfileImageProvider>(context,listen: false).changeImage(image: image.path);
                      }
                    },
                    child: Text('Open Camera')),
                ElevatedButton(
                    onPressed: () async {
                      _onAddStudentBtnclicked(context);
                      StudentNameController.clear();
                      StudentAgeController.clear();
                      StudentBatchController.clear();
                      StudentPlaceController.clear();
                      imagepath=Provider.of<ProfileImageProvider>(context,listen: false).changeImage(image:null);
                    },
                    child:const Text('Submit Form'))
              ])
            ],
          ),
        ),
      ),
    );
  }



  Future<void> _onAddStudentBtnclicked(BuildContext context) async {
    final _name = StudentNameController.text.trim();
    final _age = StudentAgeController.text.trim();
    final _batch = StudentBatchController.text.trim();
    final _place = StudentPlaceController.text.trim();
    final _image = imagepath;
    if (_name.isEmpty || _age.isEmpty || _batch.isEmpty || _place.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
        backgroundColor: Colors.red,
        content: Text('All Field is required'),
        duration: Duration(milliseconds: 300),
      ));
    } else {
      final _student = StudentDB(
          name: _name,
          age: _age,
          batch: _batch,
          Place: _place,
          image: imagepath!);
      Provider.of<StudentProvider>(context, listen: false).addStudent(_student);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
        backgroundColor: Colors.green,
        content: Text('Form submited'),
        duration: Duration(milliseconds: 300),

      ));
      StudentNameController.clear();
    }
  }
}
