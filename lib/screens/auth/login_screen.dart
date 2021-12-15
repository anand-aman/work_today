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

  void displaySpinner () {
    setState() {
      showSpinner = true;
    }
  }

  void stopDisplayingSpinner () {
    setState() {
      showSpinner = false;
    }
  }

  void navigateToHomePage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Check(
          isdark: widget.isdark,
        ),
      ),
    );
  }

  AlertDialog errorMessage(err) {
    return AlertDialog(
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

  void signIn () async {
    displaySpinner();
    try {
      print('Signin execution started');
      final user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: _emailInputController.text,
          password: _pwdInputController.text);
      stopDisplayingSpinner();
      if (user != null) {
        // SharedPreferences prefs = await SharedPreferences.getInstance();
        // prefs.setString('email', _emailInputController.text);
        navigateToHomePage();
      }
    } catch (err) {
      errorMessage(err);
    }
  }

  @override
  Widget build(BuildContext context) {

    final isKeyboard = MediaQuery.of(context).viewInsets.bottom;

    Widget backButton = Padding(
      padding: const EdgeInsets.only(top: 20),
      child: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 18,
            color: widget.isdark ? Colors.white : Colors.black,
          )
      ),
    );


    Widget header = Padding(
      padding: const EdgeInsets.only(left: 20, top: 20, bottom: 10),
      child: TextHelper(
        text: "Welcome Back !",
        size: 30,
        color: widget.isdark ? Colors.white : Colors.black,
        weight: FontWeight.bold,
      ),
    );

    Widget subHeader = Padding(
      padding: const EdgeInsets.only(left: 20, bottom: 30),
      child: TextHelper(
        text: "Login to cherish the journey",
        size: 18,
        color: widget.isdark ? Colors.white : Colors.black,
        weight: FontWeight.normal,
      ),
    );

    Widget emailForm = Container(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextInputField(
        color: widget.isdark ? Colors.white : Colors.grey[200],
        controller: _emailInputController,
        validator: (input) =>
        !input.contains('@') ? 'Not a valid Email' : null,
        textInputType: TextInputType.emailAddress,
        label: "Email",
      ),
    );

    Widget passwordForm = Container(
      padding: const EdgeInsets.only(bottom: 20),
      child: PasswordInputField(
        color: widget.isdark ? Colors.white : Colors.grey[200],
        controller: _pwdInputController,
        validator: (input) =>
        input.length < 8 ? 'You need at least 8 characters' : null,
        label: "Password",
      ),
    );


    Widget signInButton = MyButton(
      text: 'Sign in',
      onPressed: signIn,
    );


    Widget facebookSignInButton = Container(
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
    );
    if(isKeyboard==0){
      return Scaffold(
        backgroundColor: widget.isdark ? Colors.grey[850] : Colors.white,
        resizeToAvoidBottomInset: false,
        body:  Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              backButton,
              header,
              subHeader,
              emailForm,
              passwordForm,
              Spacer(),
              signInButton,
              facebookSignInButton,
            ],
          ),
        ),
      );
    }
    else{
      return Scaffold(
        backgroundColor: widget.isdark ? Colors.grey[850] : Colors.white,
        resizeToAvoidBottomInset: false,
        body:  Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              backButton,
              header,
              subHeader,
              emailForm,
              passwordForm,
              signInButton,
              facebookSignInButton,
            ],
          ),
        ),
      );
    }
  }
}