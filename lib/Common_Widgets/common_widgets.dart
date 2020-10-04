import 'package:flutter/material.dart';

AppBar buildAppBar(context) {
  return AppBar(
    backgroundColor: Theme.of(context).primaryColor,
    elevation: 0,
    leading: IconButton(
      icon: Icon(Icons.arrow_back, color: Colors.white),
      onPressed: () => Navigator.of(context).pop(),
    ),
  );
}

AppBar buildAppBarWithText(context, String text) {
  return AppBar(
    backgroundColor: Theme.of(context).primaryColor,
    elevation: 0,
    leading: IconButton(
      icon: Icon(Icons.arrow_back, color: Colors.white),
      onPressed: () => Navigator.of(context).pop(),
    ),
    title: Text(
      text,
      style: TextStyle(color: Colors.white, fontSize: 20),
    ),
  );
}
