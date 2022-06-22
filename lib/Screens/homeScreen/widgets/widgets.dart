
  import 'package:flutter/material.dart';

  
SizedBox kWidth20() =>const  SizedBox(
        width: 20,
      );

  ElevatedButton btn(String textbtn) =>
      ElevatedButton(onPressed: () {}, child: Text(textbtn));

  TextFormField studentTextFeild(String text,
  TextEditingController controller) {
    return TextFormField(
      controller:controller,
      decoration: InputDecoration(
        
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          filled: true,
          hintStyle: TextStyle(color: Colors.grey[800]),
         hintText: text,
          fillColor: Colors.white),
    );
  }


  




