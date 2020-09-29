import 'package:flutter/material.dart';
Widget profileListItem(String text, IconData icon) {
  return Container(
    height: 55,
    margin: EdgeInsets.symmetric(
      horizontal: 40,
    ),
    padding: EdgeInsets.symmetric(
      horizontal: 20,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Colors.white,
    ),
    child: Row(
      children: <Widget>[
        Icon(
          icon,
          size: 25,
        ),
        SizedBox(
          width: 50,
        ),
        Text(text,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            )),
        Spacer(),
      ],
    ),
  );
}