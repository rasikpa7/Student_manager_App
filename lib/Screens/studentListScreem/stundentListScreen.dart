import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:student_manager/Screens/homeScreen/homeScreen.dart';
import 'package:student_manager/Screens/homeScreen/widgets/widgets.dart';
import 'package:student_manager/Screens/seacrchScreen/searchScreen.dart';
import 'package:student_manager/Screens/studentListScreem/widgets/widgets.dart';
import 'package:student_manager/Screens/studentViewScreen/StudentDetailsScreen.dart';
import 'package:student_manager/model/StudentModel.dart';
import 'package:student_manager/providers/profileImageProvider.dart';
import 'package:student_manager/providers/studentProvider.dart';
import 'package:lottie/lottie.dart';

class StudentListScreen extends StatelessWidget {
  StudentListScreen({Key? key}) : super(key: key);
//  List<StudentDB> studentresult=studentProvider().student.values.toList();
// final studentList = Hive.box<StudentDB>('student').values.toList();
  TextEditingController StudentNameController = TextEditingController();
  TextEditingController StudentAgeController = TextEditingController();
  TextEditingController StudentBatchController = TextEditingController();
  TextEditingController StudentPlaceController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  var imagepath;
  static const routeName = '/student-list';
  @override
  Widget build(BuildContext context) {
      imagepath=Provider.of<ProfileImageProvider>(context).image;
    final student = Provider.of<StudentProvider>(context).studentBox;
            final studentList = student.values.toList();
    const  kheight = SizedBox(
      height: 10,
    );
    return Container(
       decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.blue,
                Colors.blueGrey,
              ],
            )
          ),
      child: Scaffold(backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text('Student List'),
            centerTitle: true,
            actions: [IconButton(onPressed: () {
              showSearch(context: context, delegate: CustomSearchDelegate(studentList));
            }, icon:const  Icon(Icons.search))],
          ),
          body:studentList.isEmpty?    Center(
                      child: 
                      Lottie.network('https://assets4.lottiefiles.com/packages/lf20_oga1x3jk.json'),
                    ):ListView.separated(itemCount: studentList.length,
            
            separatorBuilder: ((context, index) =>const SizedBox(height: 2.5,)),
            itemBuilder: (context, index) {
              final student = Provider.of<StudentProvider>(context).studentBox;
              final studentList = student.values.toList();
            
                return Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25)),
                        height: 70,
                        width: double.infinity,
                        child: Center(
                          child: ListTile(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => StudentDetailsScreen(
                                  index: index,
                                ),
                              ),
                            ),
                            leading: CircleAvatar(
                              radius: 27,
                              backgroundImage:

                              FileImage(
                                File(studentList[index].image),
                              )

                            ),
                            title: Text('${studentList[index].name}',style: 
                       const      TextStyle(fontWeight: FontWeight.w700,
                            fontSize: 15),),
                            subtitle: Text('${studentList[index].age}',
                            style: const TextStyle(fontWeight: FontWeight.w700,
                            fontSize: 15),),
                            trailing: Wrap(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Center(
                                              child: Text(
                                                'Update information'
                                                    .toUpperCase(),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            content: EditStudentList(
                                              studentList: studentList,
                                              kheight: kheight,
                                              StudentNameController:
                                                  StudentNameController,
                                              StudentAgeController:
                                                  StudentAgeController,
                                              StudentBatchController:
                                                  StudentBatchController,
                                              StudentPlaceController:
                                                  StudentPlaceController,
                                              index: index,
                                            ),
                                            actions: [
                                              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
    
                                                    ElevatedButton.icon(
                                                  onPressed: () async {
                                                    XFile? image =
                                                        await _picker.pickImage(
                                                            source: ImageSource
                                                                .gallery);
                                                    if (image == null) {
                                                      return;
                                                
                                                    } else {
                                                      imagepath = image.path;
                                                    }
                                                  },
                                                  icon:const Icon(Icons.photo),
                                                  label:const Text('')),
                                              
    
                                              ElevatedButton.icon(
                                                  onPressed: () async {
                                                    XFile? image =
                                                        await _picker.pickImage(
                                                            source: ImageSource
                                                                .camera);
                                                    if (image == null) {
                                                      imagepath =
                                                          'https://cdn3.iconfinder.com/data/icons/google-material-design-icons/48/ic_account_circle_48px-512.png';
                                                    } else {
                                                      imagepath = Provider.of<ProfileImageProvider>(context,listen: false).changeImage(image: image.path);
                                                    }
                                                  },
                                                  icon: const Icon(Icons.camera),
                                                  label:const  Text('')),
                                              ElevatedButton(
                                                  onPressed: () {
                                                    _onUpdateStudentBtnclicked(
                                                        context, index);
                                                  },
                                                  child: const  Text('submit'))
                                                ],
                                              )
                                              
                                            ],
                                          );
                                        });
                                  },
                                  icon:const Icon(Icons.edit,color: Colors.black,),
                                ),
                                IconButton(
                                    onPressed: () {
                                      Provider.of<StudentProvider>(context,
                                              listen: false)
                                          .deleteStudent(index);
                                    },
                                    icon:const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
              }
          
       
          )),
    );
  }

  Future<void> _onUpdateStudentBtnclicked(
      BuildContext context, int index) async {
    final _name = StudentNameController.text.trim();
    final _age = StudentAgeController.text.trim();
    final _batch = StudentBatchController.text.trim();
    final _place = StudentPlaceController.text.trim();
    final _image = imagepath;
    if (_name.isEmpty || _age.isEmpty || _batch.isEmpty || _place.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
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
          image: imagepath);
      Provider.of<StudentProvider>(context, listen: false)
          .editStudent(_student, index);
      ScaffoldMessenger.of(context).showSnackBar(
       const  SnackBar(
        backgroundColor: Colors.green,
        content: Text('Form Updated'),
        duration: Duration(milliseconds: 300),
      ));
      Navigator.of(context).pop();
    }
  }
}
