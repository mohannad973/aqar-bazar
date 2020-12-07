import 'package:aqar_bazar/Utils/form_validators.dart';
import 'package:aqar_bazar/Utils/secure_storage.dart';
import 'package:aqar_bazar/Utils/session_manager.dart';
import 'package:aqar_bazar/localization/app_localization.dart';
import 'package:aqar_bazar/providers/login_provider.dart';
import 'package:aqar_bazar/providers/search_result_provider.dart';
import 'package:aqar_bazar/screens/Auth/forget_password.dart';
import 'package:aqar_bazar/screens/Auth/signup.dart';
import 'package:aqar_bazar/screens/Landing_and_Home/new_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:provider/provider.dart';

import '../Landing_and_Home/Home.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final _signInKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  BuildContext scaffoldContext;
  SecureStorage secureStorage = SecureStorage();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  _getSessionManager() async {
    print('token3333');
    SessionManager sessionManager = SessionManager();
    if (await sessionManager.getAuthToken() == null) {
      print('token4444');
    } else {
      print('token5555' + await sessionManager.getAuthToken());
    }
  }

  String token = '';
  String locale;
  String lang;
  String currency;

  _getPreferences() async {
    SessionManager sessionManager = SessionManager();

    locale = await sessionManager.getLocale();
    lang = await sessionManager.getLang();
    currency = await sessionManager.getCurrency();

    if (currency == null) {
      sessionManager.setCurrency('USD');
    } else {
      sessionManager.setCurrency(currency);
    }

    if (lang == null) {
      sessionManager.setLang('en');
      print('login-lang');
    } else {
      print('login-lang ' + lang);
      sessionManager.setLang(lang);
    }

    print('main token' + (token == null).toString());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getPreferences();
    _getSessionManager();
  }

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
                              Applocalizations.of(context)
                                  .translate("signInBtn"),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
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
                            Form(
                              key: _signInKey,
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
                                  Provider.of<LogInProvider>(
                                    context,
                                  ).isLoading()
                                      ? CircularProgressIndicator(
                                          backgroundColor: Colors.blue,
                                        )
                                      : RaisedButton.icon(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  5,
                                              vertical: 10),
                                          onPressed: () async {
                                            if (_signInKey.currentState
                                                .validate()) {
                                              print('11111111');
                                              final String email =
                                                  emailController.text.trim();
                                              final String password =
                                                  passwordController.text
                                                      .trim();
                                              final bool user = await Provider
                                                      .of<LogInProvider>(
                                                          context,
                                                          listen: false)
                                                  .logIn(email, password);

                                              print('00000' + user.toString());

                                              if (user) {
                                                secureStorage
                                                    .deleteAllSecureStorage();
                                                secureStorage.writeSecureEmail(
                                                    'email',
                                                    emailController.text
                                                        .trim());
                                                secureStorage.writeSecurePass(
                                                    'pass',
                                                    passwordController.text
                                                        .trim());

                                                // Provider.of<SearchResultProvider>(context,listen: false)
                                                //     .search(furnished: "",category: "",capacity: "",price: "",bathrooms: "",rooms: "",city: "",type: "");
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          NewHome()),
                                                );
                                              } else {
                                                // Scaffold.of(context).showSnackBar(SnackBar(content: Text("Wrong"),));
                                              }
                                              FocusScope.of(context)
                                                  .requestFocus(FocusNode());
                                            }
                                            _signInKey.currentState.save();
                                          },
                                          icon: Icon(
                                            Icons.person_add,
                                            color: Colors.white,
                                          ),
                                          label: Text(
                                            Applocalizations.of(context)
                                                .translate("signInBtn"),
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
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => SignUp()),
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: Applocalizations.of(context)
                              .translate("dont have account"),
                        ),
                        TextSpan(
                          text: Applocalizations.of(context)
                              .translate("signUpBtn"),
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
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgetPassword()));
              },
              child: Center(
                child: Text(
                  Applocalizations.of(context).translate("forget-pass"),
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            )
          ],
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
