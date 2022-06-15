import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

part 'StudentModel.g.dart';

@HiveType(typeId: 0)
class StudentDB extends HiveObject  {
  @HiveField(0)
   String name;
  @HiveField(1)
  late String age;
  @HiveField(2)
  late String batch;
  @HiveField(3)
  late String Place;
  @HiveField(4)
  final String image;

  StudentDB({required this.name,required  this.age,required  this.batch,required  this.Place,required this.image});


}
