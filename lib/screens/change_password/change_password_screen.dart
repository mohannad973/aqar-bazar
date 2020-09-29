import 'package:aqar_bazar/Utils/decorations.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey, spreadRadius: 4, blurRadius: 5),
                      ],
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 0.0,
                            ),
                            Text(
                              "Change password",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),


                            SizedBox(
                              height: 30,
                            ),
                            Form(
                              child: Column(
                                children: [
                                  TextFormField(
                                    decoration: inputDecoration()
                                        .copyWith(hintText: "new password"),
                                      obscureText:true
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  TextFormField(
                                    decoration: inputDecoration()
                                        .copyWith(hintText: "confirm password"),
                                      obscureText:true
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  RaisedButton.icon(
                                    onPressed: (){
                                      Navigator.of(context).pop();
                                    },
                                      padding: EdgeInsets.symmetric(
                                          horizontal: MediaQuery.of(context)
                                              .size
                                              .width /
                                              3,
                                          vertical: 10),

                                      icon: Icon(
                                        Icons.lock,
                                        color: Colors.white,
                                      ),
                                      label: Text(
                                        "Apply",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      color: Colors.lightBlue,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(15.0),
                                      ))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}




