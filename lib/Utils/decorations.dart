import 'package:flutter/material.dart';
InputDecoration passwordDecoration() {
  return InputDecoration(

    fillColor: Colors.grey[200],
    filled: true,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[400], width: 0.5),
      borderRadius: BorderRadius.all(
        Radius.circular(20),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.teal, width: 0.5),
      borderRadius: BorderRadius.all(
        Radius.circular(20),
      ),
    ),
    prefixIcon: Icon(
      Icons.lock,
    ),
  );
}


InputDecoration inputDecoration() {
  return InputDecoration(
    fillColor: Colors.grey[200],
    filled: true,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[400], width: 0.5),
      borderRadius: BorderRadius.all(
        Radius.circular(20),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue[600], width: 0.5),
      borderRadius: BorderRadius.all(
        Radius.circular(20),
      ),
    ),
  );
}


TextStyle textStyleBold(){
  return TextStyle(
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.bold);
}