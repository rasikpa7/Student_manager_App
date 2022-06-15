import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:student_manager/Screens/homeScreen/homeScreen.dart';
import 'package:student_manager/Screens/studentViewScreen/StudentDetailsScreen.dart';
import 'package:student_manager/model/StudentModel.dart';
import 'package:student_manager/providers/profileImageProvider.dart';
import 'package:student_manager/providers/studentProvider.dart';

import 'Screens/studentListScreem/stundentListScreen.dart';

late Box<StudentDB> studenData;
Future main() async {
 WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(StudentDBAdapter());
  await Hive.openBox<StudentDB>('student');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => StudentProvider(),),
         ChangeNotifierProvider(create: (context) => ProfileImageProvider(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryTextTheme: TextTheme()
        ),
        home: MyHomePage(),
        routes: {
          StudentListScreen.routeName:(context) => StudentListScreen(),
          StudentDetailsScreen.routeName:(context) => StudentDetailsScreen()
        },
      ),
    );
  }
}
