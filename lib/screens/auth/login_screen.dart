import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:work_today/components/my_button.dart';

import 'package:work_today/services/check.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:work_today/components/input_field.dart';
import 'package:work_today/services/firebase_user.dart';

class LoginScreen extends StatefulWidget {
  final bool isdark;
  const LoginScreen({this.isdark});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
//  final _auth=FirebaseAuth.instance;
  String email;
  String password;
  final _firestore = FirebaseFirestore.instance;

  final _emailInputController = TextEditingController();
  final _pwdInputController = TextEditingController();

  bool showSpinner = false;

  @override
  void dispose() {
    _emailInputController.dispose();
    _pwdInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.isdark? Colors.grey[850]:Colors.white,
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(left: 16, right: 16),
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Transform.translate(
                        offset: Offset(80.0, 12.0),
                        child: Container(
                          width: 55.0,
                          height: 55.0,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.elliptical(27.5, 27.5)),
                            color: const Color(0xff7F1CFF),
                          ),
                        ),
                      ),
                      Text(
                        'Sign In',
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 35,
                          color: widget.isdark?Colors.white:const Color(0xff404040),
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      TextInputField(
                        controller: _emailInputController,
                        validator: (input) =>
                            !input.contains('@') ? 'Not a valid Email' : null,
                        textInputType: TextInputType.emailAddress,
                        label: "Email ID",
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      PasswordInputField(
                        controller: _pwdInputController,
                        validator: (input) => input.length < 8
                            ? 'You need at least 8 characters'
                            : null,
                        label: "Password",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      MyButton(
                        text: 'Login',
                        onPressed: () async {
                          setState(() {
                            showSpinner = true;
                          });
                          try {
                            print('Signin execution started');
                            final user = await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: _emailInputController.text,
                                    password: _pwdInputController.text);
                            setState(() {
                              showSpinner = false;
                            });
                            if (user != null) {
//                      SharedPreferences prefs = await SharedPreferences.getInstance();
//                      prefs.setString('email', _emailInputController.text);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Check(
                                      isdark: widget.isdark,
                                    ),
                                  ));
                            }
                          } catch (err) {
                            AlertDialog(
                              title: Text("Error"),
                              content: Text(err.toString()),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text("Close"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            );
                          }
                        },
                      ),


                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
