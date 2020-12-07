import 'package:aqar_bazar/Utils/decorations.dart';
import 'package:aqar_bazar/Utils/form_validators.dart';
import 'package:aqar_bazar/localization/app_localization.dart';
import 'package:aqar_bazar/providers/forget_password_provider.dart';
import 'package:aqar_bazar/providers/reset_password_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _forgetPassKey = GlobalKey<FormState>();
  final _changePassKey = GlobalKey<FormState>();
  String email = '';
  String code = '';
  String password='';
  String cPassword='';
  bool codeSent=false;
  bool passReset = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cPasswordController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            codeSent == true ? Container() :
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AspectRatio(
                  aspectRatio: 1.5,
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
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              height: 0.0,
                            ),
                            Column(
                              children: [
                                Text(
                                  Applocalizations.of(context)
                                      .translate("enter-your-email"),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),

                                SizedBox(
                                  height: 15,
                                ),
                                Form(
                                  key: _forgetPassKey,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        decoration: inputDecoration().copyWith(
                                          hintText: Applocalizations.of(context)
                                              .translate("email"),
                                        ),
                                        controller: emailController,
                                        onChanged: (val) {
                                          setState(() => email = val);
                                        },
                                        validator: emailValidator(email),
                                      ),

                                      SizedBox(
                                        height: 15,
                                      ),

                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Provider.of<ForgetPasswordProvider>(
                              context,
                            ).isLoading()
                                ? CircularProgressIndicator(
                              backgroundColor: Colors.blue,
                            )
                                :
                            RaisedButton.icon(
                                padding: EdgeInsets.symmetric(
                                    horizontal: MediaQuery.of(context)
                                        .size
                                        .width /
                                        5,
                                    vertical: 10),
                                onPressed: () async {
                                  if (_forgetPassKey.currentState
                                      .validate()) {

                                    final String email =
                                    emailController.text.trim();

                                    final bool forget = await Provider
                                        .of<ForgetPasswordProvider>(
                                        context,
                                        listen: false)
                                        .forgetPass(email);



                                    if (forget) {
                                      setState(() {
                                        codeSent = true;
                                      });
                                    } else {
                                      // Scaffold.of(context).showSnackBar(SnackBar(content: Text("Wrong"),));
                                    }
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                  }
                                  _forgetPassKey.currentState.save();
                                },
                                icon: Icon(
                                  Icons.send,
                                  color: Colors.white,
                                ),
                                label: Text(
                                  Applocalizations.of(context)
                                      .translate("send"),
                                  style:
                                  TextStyle(color: Colors.white),
                                ),
                                color: Colors.lightBlue,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(15.0),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            codeSent == false?Container():
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
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              height: 0.0,
                            ),
                            Column(
                              children: [
                                Text(
                                  Applocalizations.of(context)
                                      .translate("change-pass"),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),

                                SizedBox(
                                  height: 15,
                                ),
                                Form(
                                  key: _changePassKey,
                                  child: Column(
                                    children: [

                                      TextFormField(
                                        onChanged: (val) {
                                          setState(() => code = val);
                                        },
                                        validator: emptyFieldVAlidator(code),
                                        obscureText: false,
                                        decoration: inputDecoration().copyWith(
                                          hintText: Applocalizations.of(context)
                                              .translate("code"),
                                        ),
                                        controller: codeController,
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      TextFormField(
                                        onChanged: (val) {
                                          setState(() => password = val);
                                        },
                                        validator: passwordValidator(),
                                        obscureText: true,
                                        decoration: inputDecoration().copyWith(
                                          hintText: Applocalizations.of(context)
                                              .translate("password"),
                                        ),
                                        controller: passwordController,
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      TextFormField(
                                        onChanged: (val) {
                                          setState(() => cPassword = val);
                                        },
                                        validator: passwordValidator(),
                                        obscureText: true,
                                        decoration: inputDecoration().copyWith(
                                          hintText: Applocalizations.of(context)
                                              .translate("reType-pass"),
                                        ),
                                        controller: cPasswordController,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Provider.of<ResetPasswordProvider>(
                              context,
                            ).isLoading()
                                ? CircularProgressIndicator(
                              backgroundColor: Colors.blue,
                            )
                                :
                            RaisedButton.icon(
                                padding: EdgeInsets.symmetric(
                                    horizontal: MediaQuery.of(context)
                                        .size
                                        .width /
                                        5,
                                    vertical: 10),
                                onPressed: () async {
                                  if (_changePassKey.currentState
                                      .validate()) {


                                    String code = codeController.text.trim();
                                    String password = passwordController.text.trim();
                                    String cPassword = cPasswordController.text.trim();


                                    final bool reset = await Provider
                                        .of<ResetPasswordProvider>(
                                        context,
                                        listen: false)
                                        .resetPass(code , password , cPassword);



                                    if (reset) {
                                      setState(() {
                                        passReset = true;
                                      });
                                    } else {
                                      // Scaffold.of(context).showSnackBar(SnackBar(content: Text("Wrong"),));
                                    }
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                  }
                                  _changePassKey.currentState.save();
                                },
                                icon: Icon(
                                  Icons.send,
                                  color: Colors.white,
                                ),
                                label: Text(
                                  Applocalizations.of(context)
                                      .translate("send"),
                                  style:
                                  TextStyle(color: Colors.white),
                                ),
                                color: Colors.lightBlue,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(15.0),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            passReset == false ? Container() :

            Column (
              children: [
                Text(Applocalizations.of(context).translate('success-change'),style: TextStyle(
                  fontSize: 15,
                  color: Colors.blue,

                ),),
                SizedBox(height: 20,),
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Text(
                    Applocalizations.of(context).translate("signInBtn"),
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            )

          ],
        ),
      ),
    );
  }
}
