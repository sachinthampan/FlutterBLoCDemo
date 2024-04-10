import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UserInterface{

  static void showSnack(BuildContext context, String message){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

}