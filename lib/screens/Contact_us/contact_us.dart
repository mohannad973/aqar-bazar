import 'package:aqar_bazar/Utils/colors.dart';
import 'package:aqar_bazar/Utils/decorations.dart';
import 'package:aqar_bazar/Utils/form_validators.dart';
import 'package:aqar_bazar/constants.dart';
import 'package:aqar_bazar/providers/contact_us_provider.dart';
import 'package:aqar_bazar/screens/Landing_and_Home/Home.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactUs extends StatefulWidget {
  ContactUs({Key key}) : super(key: key);

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _contactusKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  String email = '',
      name = '',
      phone = '',
      message = '';

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      child: Scaffold(
        key: _scaffoldKey,
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: iconColor(),
        //   elevation: 4.0,
        //   child: Icon(
        //     Icons.search,
        //     color: Theme.of(context).accentColor,
        //   ),
        //   onPressed: () {},
        // ),
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
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 15,
                                ),
                                Form(
                                  key: _contactusKey,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        onChanged: (val) {
                                          setState(() => name = val);
                                        },
                                        validator:
                                        emptyFieldVAlidator(name),
                                        controller: nameController,
                                        decoration: inputDecoration()
                                            .copyWith(hintText: "Name"),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      TextFormField(
                                        onChanged: (val) {
                                          setState(() => email = val);
                                        },
                                        validator:
                                        emailValidator(email),
                                        controller: emailController,
                                        decoration: inputDecoration()
                                            .copyWith(hintText: "Email"),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      TextFormField(
                                        onChanged: (val) {
                                          setState(() => phone = val);
                                        },
                                        validator:
                                        emptyFieldVAlidator(phone),
                                        controller: phoneController,
                                        decoration: inputDecoration()
                                            .copyWith(hintText: "Phone number"),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      SingleChildScrollView(
                                        child: TextFormField(
                                          onChanged: (val) {
                                            setState(() => message = val);
                                          },
                                          validator:
                                          emptyFieldVAlidator(message),
                                          controller: messageController,
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
                  ),
                  SizedBox(
                    height: 25,
                  ),

                  Provider.of<ContactUSProvider>(context).isLoading()?Center(child: CircularProgressIndicator(backgroundColor: fBlue,)):
                  RaisedButton.icon(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width / 4,
                          vertical: 10),
                      onPressed: () async{
                        if (_contactusKey.currentState
                            .validate()) {
                          final String email =
                          emailController.text
                              .trim();
                          final String phone =
                          phoneController.text
                              .trim();
                          final String name =
                          nameController.text
                              .trim();
                          final String message =
                          messageController.text
                              .trim();


                          bool contact = await Provider.of<
                              ContactUSProvider>(
                              context,
                              listen: false)
                              .contactUs(
                              email,
                              name,
                              phone,
                              message);

                          if (contact) {

                            nameController.clear();
                            emailController.clear();
                            phoneController.clear();
                            messageController.clear();
                            _scaffoldKey.currentState.showSnackBar(SnackBar(
                              content: Text(
                                'Your Message were sent successfully',
                              ),
                              duration: Duration(seconds: 2),
                            ));

                            // Navigator.of(context)
                            //     .pushReplacement(
                            //   MaterialPageRoute(
                            //       builder: (_) =>
                            //           NewHome()),
                            // );
                            print("contactUs Success");
                          } else {
                            print(contact.toString());
                            // Scaffold.of(context).showSnackBar(SnackBar(content: Text("Wrong"),));
                          }
                        }
                        _contactusKey.currentState.save();
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
