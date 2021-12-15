import 'package:work_today/components/input_field.dart';
import 'package:work_today/components/my_button.dart';
import 'package:work_today/constants.dart';
import 'package:work_today/screens/auth/login_screen.dart';
import 'package:work_today/screens/location_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:work_today/services/firebase_user.dart';
import 'package:work_today/services/location.dart';
import 'package:work_today/widgets/text.dart';

final _auth = FirebaseAuth.instance;
final _firestore = FirebaseFirestore.instance;

class RegistrationScreen extends StatefulWidget {
  final bool isHire;
  final bool isdark;
  final SignInMethod signInMethod;

  const RegistrationScreen({
    Key key,
    this.isHire,
    this.isdark,
    this.signInMethod,
  }) : super(key: key);
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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

  Future<bool> createUser() async {
    if (widget.signInMethod == SignInMethod.email)
      return _auth
          .createUserWithEmailAndPassword(
          email: _emailInputController.text,
          password: _pwdInputController.text)
          .then((currentUser) {
        updateUserData(currentUser.user);
        return true;
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
        return false;
      });

    return updateUserData(FirebaseCurrentUser.user).then((value) => true);
  }

  Future<void> updateUserData(User currentUser) async {
    print('DATA UPDATE STARTED');
    _firestore
        .collection('users')
        .doc(currentUser.uid)
        .set({
      "uid": currentUser.uid,
      "name": _usernameInputController.text,
      "phoneNo": _phoneNoController.text,
      "email": _emailInputController.text,
      "isHirer": isHirer,
      "signInMethod": widget.signInMethod.index,
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
  }

  void initialize() async {
    isHirer = widget.isHire;
    user = FirebaseCurrentUser.user;
    _usernameInputController =
        TextEditingController(text: user?.displayName ?? null);
    _emailInputController = TextEditingController(text: user?.email ?? null);
    _phoneNoController = TextEditingController(text: user?.phoneNumber ?? null);
  }

  void checkIfPasswordsMatch() {
    if (_pwdInputController.text != _confirmPwdInputController.text) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("The passwords do not match"),
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
    }
  }

  void displaySpinner() {
    setState(() {
      showSpinner = true;
    });
  }

  void stopDisplayingSpinner() {
    setState(() {
      showSpinner = false;
    });
  }

  void navigateToLocationScreen() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LocationScreen(
            isHirer: isHirer,
            isdark: widget.isdark,
          ),
          settings: RouteSettings(name: 'Location Screen'),
        ));
  }

  void signUp() async {
    checkIfPasswordsMatch();
    displaySpinner();

    createUser().then(
          (value) {
        stopDisplayingSpinner();
        if (value) {
          navigateToLocationScreen();
        }
      },
    );
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
    Widget backButton = Padding(
      // padding: const EdgeInsets.only(top: 20),
      padding: MediaQuery.of(context).orientation == Orientation.portrait
          ? EdgeInsets.only(right: 370, left: 20, top: 20)
          : EdgeInsets.only(top: 20, right: 830),
      child: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 18,
            color: widget.isdark ? Colors.white : Colors.black,
          )),
    );

    Widget header = Padding(
      padding: MediaQuery.of(context).orientation == Orientation.portrait
          ? EdgeInsets.only(right: 10, left: 115)
          : EdgeInsets.only(right: 300, left: 355),
      child: TextHelper(
        text: "Work Today",
        size: 30,
        weight: FontWeight.bold,
        color: widget.isdark ? Colors.white : Colors.black,
      ),
    );

    Widget subHeader = Padding(
      padding: MediaQuery.of(context).orientation == Orientation.portrait
          ? EdgeInsets.only(right: 80, left: 80)
          : EdgeInsets.only(right: 300, left: 325),
      child: TextHelper(
        text: "Join to get immediate updates",
        size: 18,
        weight: FontWeight.normal,
        color: widget.isdark ? Colors.white : Colors.black,
      ),
    );

    Widget nameForm = Container(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      child: TextInputField(
        color: widget.isdark ? Colors.white : Colors.grey[200],
        controller: _usernameInputController,
        label: "Name",
        validator: (value) {
          if (value.isEmpty) {
            return 'Name is required.';
          }
        },
      ),
    );

    Widget phoneNumForm = Container(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextInputField(
        color: widget.isdark ? Colors.white : Colors.grey[200],
        controller: _phoneNoController,
        textInputType: TextInputType.phone,
        maxLength: 10,
        label: "Phone No.",
        validator: (value) {
          if (value.isEmpty) {
            return 'Phone Number is required.';
          }
        },
      ),
    );

    Widget hirerButton = Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isHirer = true;
            });
          },
          child: TextHelper(
            text: "Hire",
            size: 18,
            color: widget.isdark ? Colors.white : Colors.black,
          ),
        ),
        SmallButton(
          text: "Hire",
          onPressed: () {},
          buttonColor: isHirer
              ? Color(0xff7f1cff)
              : widget.isdark
              ? Colors.grey[850]
              : Colors.white,
          width: 100.0,
        ),
      ],
    );

    Widget workerButton = Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isHirer = false;
            });
          },
          child: TextHelper(
            text: "Work",
            size: 18,
            color: widget.isdark ? Colors.white : Colors.black,
          ),
        ),
        SmallButton(
          text: "Hire",
          onPressed: () {},
          buttonColor: isHirer
              ? widget.isdark
              ? Colors.grey[850]
              : Colors.white
              : Color(0xff7f1cff),
          width: 100.0,
        ),
      ],
    );

    Widget emailForm = Container(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextInputField(
        color: widget.isdark ? Colors.white : Colors.grey[200],
        controller: _emailInputController,
        validator: (value) {
          if (value.isEmpty) {
            return 'Email is required';
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
        label: "Email",
      ),
    );

    Widget passwordForm = Container(
      padding: const EdgeInsets.only(bottom: 16),
      child: PasswordInputField(
        color: widget.isdark ? Colors.white : Colors.grey[200],
        controller: _pwdInputController,
        label: "Password",
        validator: (value) {
          if (value.isEmpty) {
            return 'Password is Required';
          }
          return null;
        },
      ),
    );

    Widget confirmPasswordForm = Container(
      padding: const EdgeInsets.only(bottom: 16),
      child: PasswordInputField(
        color: widget.isdark ? Colors.white : Colors.grey[200],
        controller: _confirmPwdInputController,
        label: "Confirm Password",
        validator: (value) {
          if (value.isEmpty) {
            return 'Confirm Password is Required';
          }
          return null;
        },
      ),
    );

    Widget formFields = Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                hirerButton,
                workerButton,
              ],
            ),
          ),
          nameForm,
          phoneNumForm,
          if (widget.signInMethod == SignInMethod.email) emailForm,
          passwordForm,
          confirmPasswordForm,
        ],
      ),
    );

    Widget signUpButton = Container(
      padding: const EdgeInsets.only(bottom: 20),
      child: MyButton(
        text: 'Signup',
        onPressed: signUp,
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: widget.isdark ? Colors.grey[900] : Colors.white,
      body: SafeArea(
        child: Container(
          child: ListView(
            // padding: const EdgeInsets.all(8),
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              backButton,
              header,
              subHeader,
              formFields,
              Spacer(),
              Container(
                height: 170.0,
                color: widget.isdark ? Colors.grey[900] : Colors.white
                // child: Container(),
              ),
              signUpButton,
            ],
          ),
        ),
      ),
    );
  }
}
