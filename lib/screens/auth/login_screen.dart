import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:work_today/components/my_button.dart';
import 'package:work_today/screens/auth/registration_screen.dart';
import 'package:work_today/services/check.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:work_today/components/input_field.dart';
import 'package:work_today/widgets/text.dart';
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
      backgroundColor: widget.isdark ? Colors.grey[850] : Colors.white,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_new_outlined,
                          size: 18,
                          color: widget.isdark ? Colors.white : Colors.black,
                        )),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 20),
                child: TextHelper(
                  text: "Welcome Back !",
                  size: 30,
                  color: widget.isdark ? Colors.white : Colors.black,
                  weight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: TextHelper(
                  text: "Login to cherish the journey",
                  size: 18,
                  color: widget.isdark ? Colors.white : Colors.black,
                  weight: FontWeight.normal,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextInputField(
                color: widget.isdark ? Colors.white : Colors.grey[200],
                controller: _emailInputController,
                validator: (input) =>
                    !input.contains('@') ? 'Not a valid Email' : null,
                textInputType: TextInputType.emailAddress,
                label: "Email",
              ),
              SizedBox(
                height: 20,
              ),
              PasswordInputField(
                color: widget.isdark ? Colors.white : Colors.grey[200],
                controller: _pwdInputController,
                validator: (input) =>
                    input.length < 8 ? 'You need at least 8 characters' : null,
                label: "Password",
              ),
              Spacer(),
              MyButton(
                text: 'Signin',
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
              Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FacebookSignInButton(
                      onPressed: () {
                        var firebaseUser = new FirebaseCurrentUser();
                        var currentUser = firebaseUser.signInWithFacebook();
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
