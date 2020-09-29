import 'package:flutter/material.dart';
Widget settingsItem(String text,IconData icon){
  return Padding(
    padding: const EdgeInsets.only(left: 8,right: 8),
    child: ListTile(

      title: Text(text,style: TextStyle(fontSize: 16),),
      trailing: Icon(icon),
    ),
  );
}
