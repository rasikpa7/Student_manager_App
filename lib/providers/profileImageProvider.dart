import 'package:flutter/cupertino.dart';

class ProfileImageProvider with ChangeNotifier{
  var image;

   changeImage({var image}){
  this.image=image;
  notifyListeners();
  }

}