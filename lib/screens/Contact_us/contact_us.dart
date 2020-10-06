import 'package:aqar_bazar/Utils/colors.dart';
import 'package:aqar_bazar/Utils/decorations.dart';
import 'package:aqar_bazar/screens/Landing_and_Home/Home.dart';

import 'package:flutter/material.dart';

class ContactUs extends StatefulWidget {
  ContactUs({Key key}) : super(key: key);

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: iconColor(),
          elevation: 4.0,
          child: Icon(
            Icons.search,
            color: Theme.of(context).accentColor,
          ),
          onPressed: () {},
        ),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            'Contact us',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Center(
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              spreadRadius: 4,
                              blurRadius: 5),
                        ],
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              Form(
                                child: Column(
                                  children: [
                                    TextFormField(
                                      decoration: inputDecoration()
                                          .copyWith(hintText: "Name"),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    TextFormField(
                                      decoration: inputDecoration()
                                          .copyWith(hintText: "Email"),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    TextFormField(
                                      decoration: inputDecoration()
                                          .copyWith(hintText: "Phone number"),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    SingleChildScrollView(
                                      child: TextField(
                                        decoration: inputDecoration()
                                            .copyWith(hintText: 'Message'),
                                        maxLines: 7,
                                        keyboardType: TextInputType.text,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  RaisedButton.icon(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width / 4,
                          vertical: 10),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => Home()),
                        );
                      },
                      icon: Icon(
                        Icons.message,
                        color: Colors.white,
                      ),
                      label: Text(
                        "Send message",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: iconColor(),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
