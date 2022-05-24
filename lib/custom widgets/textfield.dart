import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  bool? hasIcon = true;
  IconData icon;
  double width;
  int maxline;
  TextEditingController input;
  String label;
  CustomTextField(
      {required this.label,
      required this.input,
      required this.maxline,
      required this.width,
      required this.icon,
      this.hasIcon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        //shadowColor: Colors.grey,
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: width,
            child: TextField(
              maxLines: maxline,
              controller: input,
              style: TextStyle(fontSize: 20),
              //cursorColor: Colors.black,
              decoration: InputDecoration(
                  icon: (hasIcon == true)
                      ? (Icon(icon
                          //color: Colors.black,
                          ))
                      : Container(
                          width: 0,
                        ),
                  labelText: label,
                  labelStyle: TextStyle(fontSize: 15),
                  floatingLabelStyle: TextStyle(fontSize: 15),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  //focusColor: Colors.white,
                  //hoverColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide:
                          BorderSide(width: 0, style: BorderStyle.none)),
                  filled: true,
                  //fillColor: Colors.white,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0)),
            ),
          ),
        ),
      ),
    );
  }
}