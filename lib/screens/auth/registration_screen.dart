import 'package:work_today/components/input_field.dart';
import 'package:work_today/components/my_button.dart';
import 'package:work_today/screens/location_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:work_today/services/firebase_user.dart';
import 'package:work_today/services/location.dart';

import 'login_screen.dart';

final _auth = FirebaseAuth.instance;
final _firestore = FirebaseFirestore.instance;

class RegistrationScreen extends StatefulWidget {
  final bool isHire;
  final bool isGoogleSignin;

  const RegistrationScreen({Key key, this.isHire, this.isGoogleSignin = false})
      : super(key: key);
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
//  final _auth= FirebaseAuth.instance;
  int e = 0;
  bool isHirer;
  User user;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _usernameInputController = TextEditingController();
  TextEditingController _emailInputController = TextEditingController();
  TextEditingController _phoneNoController = TextEditingController();
  TextEditingController _pwdInputController = TextEditingController();
  TextEditingController _confirmPwdInputController = TextEditingController();

  bool showSpinner = false;
  void initialize() async {
    isHirer = widget.isHire;
    user = FirebaseCurrentUser.user;
    _usernameInputController =
        TextEditingController(text: user?.displayName ?? null);
    _emailInputController = TextEditingController(text: user?.email ?? null);
    _phoneNoController = TextEditingController(text: user?.phoneNumber ?? null);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialize();
  }

  @override
  void dispose() {
    _usernameInputController.dispose();
    _phoneNoController.dispose();
    _confirmPwdInputController.dispose();
    _emailInputController.dispose();
    _pwdInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 10.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Transform.translate(
                        offset: Offset(100.0, 12.0),
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
                        'Sign Up',
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 35,
                          color: const Color(0xff404040),
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                    ],
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              MyButton(
                                text: "Hire",
                                onPressed: () {
                                  setState(() {
                                    isHirer = true;
                                  });
                                },
                                buttonColor:
                                    isHirer ? Color(0xff7f1cff) : Colors.white,
                                width: 100.0,
                              ),
                              MyButton(
                                text: "Work",
                                onPressed: () {
                                  setState(() {
                                    isHirer = false;
                                  });
                                },
                                buttonColor:
                                    isHirer ? Colors.white : Color(0xff7f1cff),
                                width: 100.0,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TextInputField(
                          controller: _usernameInputController,
                          label: "Name",
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TextInputField(
                          controller: _phoneNoController,
                          textInputType: TextInputType.phone,
                          maxLength: 10,
                          label: "Phone No.",
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TextInputField(
                          controller: _emailInputController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Email is Required';
                            }

                            if (!RegExp(
                                    r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                .hasMatch(value)) {
                              return 'Please enter a valid email Address';
                            }
                            if (e == 1) {
                              return 'This Email is already used';
                            }

                            return null;
                          },
                          textInputType: TextInputType.emailAddress,
                          label: "Email ID",
                        ),
                        if (!widget.isGoogleSignin)
                          SizedBox(
                            height: 16,
                          ),
                        if (!widget.isGoogleSignin)
                          PasswordInputField(
                            controller: _pwdInputController,
                            label: "Password",
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Password is Required';
                              }
                              return null;
                            },
                          ),
                        if (!widget.isGoogleSignin)
                          SizedBox(
                            height: 20,
                          ),
                        if (!widget.isGoogleSignin)
                          PasswordInputField(
                            controller: _confirmPwdInputController,
                            label: "Confirm Password",
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Confirm Password is Required';
                              }
                              return null;
                            },
                          ),
                        SizedBox(
                          height: 20,
                        ),
                        MyButton(
                          text: 'Create Account',
                          onPressed: () async {
                            if (widget.isGoogleSignin) {
                              print('DATA UPDATE STARTED');
                              _firestore
                                  .collection('users')
                                  .doc(_auth.currentUser.uid)
                                  .set({
                                "uid": _auth.currentUser.uid,
                                "name": _usernameInputController.text,
                                "phoneNo": _phoneNoController.text,
                                "email": _emailInputController.text,
                                "isHirer": isHirer,
                              }).then((value) {
                                print('DATA UPDATED');

                                setState(() {
                                  showSpinner = false;
                                });
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LocationScreen(
                                        isHirer: isHirer,
                                      ),
                                      settings: RouteSettings(
                                          name: 'Location Screen'),
                                    ));
                              });
                              // .catchError((onError) {
                              //   setState(() {
                              //     showSpinner = false;
                              //   });
                              //   showDialog(
                              //     context: context,
                              //     builder: (BuildContext context) {
                              //       return AlertDialog(
                              //         title: Text("Error"),
                              //         content: Text(onError.toString()),
                              //         actions: <Widget>[
                              //           FlatButton(
                              //             child: Text("Close"),
                              //             onPressed: () {
                              //               Navigator.of(context).pop();
                              //             },
                              //           )
                              //         ],
                              //       );
                              //     },
                              //   );
                              // });
                            } else {
                              if (_pwdInputController.text !=
                                  _confirmPwdInputController.text) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Error"),
                                      content:
                                          Text("The passwords do not match"),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text("Close"),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        )
                                      ],
                                    );
                                  },
                                );
                                return;
                              }

                              setState(() {
                                showSpinner = true;
                              });
                              _auth
                                  .createUserWithEmailAndPassword(
                                      email: _emailInputController.text,
                                      password: _pwdInputController.text)
                                  .then((currentUser) {
                                print('DATA UPDATE STARTED');
                                _firestore
                                    .collection('users')
                                    .doc(currentUser.user.uid)
                                    .set({
                                      "uid": currentUser.user.uid,
                                      "name": _usernameInputController.text,
                                      "phoneNo": _phoneNoController.text,
                                      "email": _emailInputController.text,
                                      "isHirer": isHirer,
                                    })
                                    .then((value) => print('DATA UPDATED'))
                                    .catchError((onError) {
                                      setState(() {
                                        showSpinner = false;
                                      });
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text("Error"),
                                            content: Text(onError.toString()),
                                            actions: <Widget>[
                                              FlatButton(
                                                child: Text("Close"),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              )
                                            ],
                                          );
                                        },
                                      );
                                    });
                              }).then(
                                (value) {
                                  setState(() {
                                    showSpinner = false;
                                  });
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LocationScreen(
                                          isHirer: isHirer,
                                        ),
                                        settings: RouteSettings(
                                            name: 'Location Screen'),
                                      ));
                                },
                              ).catchError((onError) {
                                setState(() {
                                  showSpinner = false;
                                });
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Error"),
                                      content: Text(onError.toString()),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text("Close"),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        )
                                      ],
                                    );
                                  },
                                );
                              }).catchError((onError) {
                                setState(() {
                                  showSpinner = false;
                                });
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Error"),
                                      content: Text(onError.toString()),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text("Close"),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        )
                                      ],
                                    );
                                  },
                                );
                              });
                            }
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
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
