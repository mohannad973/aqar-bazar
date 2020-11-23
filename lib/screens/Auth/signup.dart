import 'package:aqar_bazar/Utils/form_validators.dart';
import 'package:aqar_bazar/localization/app_localization.dart';
import 'package:aqar_bazar/providers/register_provider.dart';
import 'package:aqar_bazar/screens/Auth/login.dart';
import 'package:aqar_bazar/screens/Landing_and_Home/new_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:provider/provider.dart';

import '../Landing_and_Home/Home.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _signUpKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController passwordConfirmationController =
      TextEditingController();

  String email = '',
      firstName = '',
      lastName = '',
      password = '',
      confirmPasswod = '';

  TextStyle defaultStyle = TextStyle(
    color: Colors.grey,
  );
  TextStyle linkStyle = TextStyle(color: Colors.blue);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AspectRatio(
                    aspectRatio: 0.7,
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
                                height: 0.0,
                              ),
                              Text(
                                Applocalizations.of(context).translate("signUpBtn"),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              _socialMediaButtons(),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                Applocalizations.of(context).translate("or"),
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Expanded(
                                child: Form(
                                  key: _signUpKey,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        onChanged: (val) {
                                          setState(() => firstName = val);
                                        },
                                        validator:
                                            emptyFieldVAlidator(firstName),
                                        decoration: inputDecoration()
                                            .copyWith(hintText: Applocalizations.of(context).translate("first name"),),
                                        controller: firstNameController,
                                      ),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      TextFormField(
                                        onChanged: (val) {
                                          setState(() => lastName = val);
                                        },
                                        validator:
                                            emptyFieldVAlidator(lastName),
                                        decoration: inputDecoration()
                                            .copyWith(hintText:  Applocalizations.of(context).translate("last name"),),
                                        controller: lastNameController,
                                      ),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      TextFormField(
                                        onChanged: (val) {
                                          setState(() => email = val);
                                        },
                                        validator: emailValidator(email),
                                        decoration: inputDecoration()
                                            .copyWith(hintText: Applocalizations.of(context).translate("email"),),
                                        controller: emailController,
                                      ),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      TextFormField(
                                        onChanged: (val) {
                                          setState(() => password = val);
                                        },
                                        validator: passwordValidator(),
                                        obscureText: true,
                                        decoration: inputDecoration()
                                            .copyWith(hintText: Applocalizations.of(context).translate("password"),),
                                        controller: passwordController,
                                      ),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      TextFormField(
                                        onChanged: (val) {
                                          setState(() => confirmPasswod = val);
                                        },
                                        validator: passwordValidator(),
                                        obscureText: true,
                                        decoration: inputDecoration().copyWith(
                                            hintText: Applocalizations.of(context).translate("repeat password"),),
                                        controller:
                                            passwordConfirmationController,
                                      ),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      Provider.of<RegisterProvider>(context,
                                                  )
                                              .isLoading()
                                          ? CircularProgressIndicator(
                                              backgroundColor: Colors.blue,
                                            )
                                          : RaisedButton.icon(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          3,
                                                  vertical: 10),
                                              onPressed: () async {
                                                if (_signUpKey.currentState
                                                    .validate()) {
                                                  final String email =
                                                      emailController.text
                                                          .trim();
                                                  final String password =
                                                      passwordController.text
                                                          .trim();
                                                  final String fName =
                                                      firstNameController.text
                                                          .trim();
                                                  final String lNAme =
                                                      lastNameController.text
                                                          .trim();
                                                  final String passwordConfirm =
                                                      passwordConfirmationController
                                                          .text
                                                          .trim();

                                                  bool user = await Provider.of<
                                                              RegisterProvider>(
                                                          context,
                                                          listen: false)
                                                      .register(
                                                          email,
                                                          password,
                                                          fName,
                                                          lNAme,
                                                          passwordConfirm);

                                                  if (user) {
                                                    Navigator.of(context)
                                                        .pushReplacement(
                                                      MaterialPageRoute(
                                                          builder: (_) =>
                                                              NewHome()),
                                                    );
                                                  } else {
                                                    print(user.toString());
                                                    // Scaffold.of(context).showSnackBar(SnackBar(content: Text("Wrong"),));
                                                  }
                                                }
                                                _signUpKey.currentState.save();

                                                // Navigator.of(context).pushReplacement(
                                                //   MaterialPageRoute(
                                                //       builder: (_) => NewHome()),
                                                // );
                                              },
                                              icon: Icon(
                                                Icons.person_add,
                                                color: Colors.white,
                                              ),
                                              label: Text(
                                                Applocalizations.of(context).translate("signInBtn"),
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              color: Colors.lightBlue,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ))
                                    ],
                                  ),
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
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text:
                          Applocalizations.of(context).translate("by clicking1"),),
                      TextSpan(
                        text:  Applocalizations.of(context).translate("by clicking2"),
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.blue,
                        ),
                      ),
                      TextSpan(text:  Applocalizations.of(context).translate("by clicking3"),),
                      TextSpan(
                        text:  Applocalizations.of(context).translate("by clicking4"),
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                child: Center(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.of(context)
                          .pushReplacement(
                        MaterialPageRoute(
                            builder: (_) =>
                                LogIn()),
                      );
                    },
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                        children: <TextSpan>[
                          TextSpan(text:  Applocalizations.of(context).translate("already have account"),),
                          TextSpan(
                            text: Applocalizations.of(context).translate("signInBtn"),
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
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
}

class _socialMediaButtons extends StatelessWidget {
  const _socialMediaButtons({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SignInButton(
          Buttons.Facebook,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          mini: true,
          text: 'FaceBook',
          onPressed: () {},
        ),
        SizedBox(
          width: 8,
        ),
        SignInButton(
          Buttons.Twitter,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          mini: true,
          text: 'FaceBook',
          onPressed: () {},
        ),
        SizedBox(width: 8),
        SignInButton(
          Buttons.LinkedIn,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          mini: true,
          text: 'FaceBook',
          onPressed: () {},
        ),
      ],
    );
  }
}
