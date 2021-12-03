import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:work_today/constants.dart';
import 'package:work_today/screens/auth/login_screen.dart';
import 'package:work_today/screens/auth/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:work_today/widgets/text.dart';

final _firestore = FirebaseFirestore.instance;

class HomeScreen extends StatefulWidget {
  bool isdark;
  HomeScreen({this.isdark});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool inAsyncCall = false;

  void toggleDarkMode() {
    setState(() {
      widget.isdark = !widget.isdark;
    });
  }

  void navigateToHirerRegistrationPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegistrationScreen(
          isHire: true,
          isdark: widget.isdark,
          signInMethod: SignInMethod.email,
        ),
        settings:
          RouteSettings(name: 'Registration Screen'),
      ),
    );
  }

  void navigateToWorkerRegistrationPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegistrationScreen(
          isdark: widget.isdark,
          isHire: false,
          signInMethod: SignInMethod.email,
        ),
        settings:
          RouteSettings(name: 'Registration Screen'),
        ),
    );
  }

  void navigateToLoginPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(
          isdark: widget.isdark,
        ),
        settings: RouteSettings(name: 'Login Screen'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    Widget toggleDarkModeButton = Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        child: Icon(
          widget.isdark ? Icons.light_mode : Icons.dark_mode,
          color: widget.isdark
              ? Colors.white
              :  Color(0xff7f1cff),
          size: 20.0,
        ),
        onTap: toggleDarkMode,
      ),
    );

    Widget header = Container(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height / 6,
          bottom: 5
      ),
      child: TextHelper(
        weight: FontWeight.bold,
        text: "Work Today",
        size: 30,
        color: widget.isdark
            ? Colors.white
            : Color.fromRGBO(56, 56, 68, 1),
      ),
    );

    Widget subHeader = TextHelper(
      text: "Hire workers instantly",
      size: 20,
      color: widget.isdark
          ? Colors.white
          : Color.fromRGBO(56, 56, 68, 1),
    );

    Widget workTodayLogo = Container(
      height: MediaQuery.of(context).size.height / 3,
      child: Center(child: Image.asset("images/logo_bg_remove.png")),
    );

    Widget registerAsHirer = GestureDetector(
      onTap: navigateToHirerRegistrationPage,
      child: Center(
        child: TextHelper(
          weight: FontWeight.bold,
          text: "Hire | ",
          size: 18,
          color: widget.isdark ? Colors.white : Colors.black,
        ),
      ),
    );

    Widget registerAsWorker = GestureDetector(
      onTap: navigateToWorkerRegistrationPage,
      child: Center(
        child: TextHelper(
          weight: FontWeight.bold,
          text: "Work",
          size: 18,
          color: widget.isdark ? Colors.white : Colors.black,
        ),
      ),
    );

    Widget registrationOptions = Container(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          registerAsHirer,
          registerAsWorker,
        ],
      ),
    );

    Widget getStartedButton = GestureDetector(
      onTap: navigateToLoginPage,
      child: Padding(
        padding: EdgeInsets.only(left: 40, right: 40, bottom: 20),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
              color: widget.isdark ? Colors.white : Color(0xff7f1cff),
              borderRadius: BorderRadius.circular(40)),
          child: Center(
            child: TextHelper(
              text: "Get Started",
              size: 18,
              color: widget.isdark ? Colors.black : Colors.white,
            ),
          ),
        ),
      ),
    );

    return MaterialApp(
      theme: widget.isdark
          ? ThemeData.dark()
          : ThemeData.light().copyWith(primaryColor: Colors.white),
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: widget.isdark ? Colors.grey[900] : Colors.white,
            centerTitle: false,
            elevation: 0,
            actions: [
              toggleDarkModeButton,
            ],
          ),
          backgroundColor: widget.isdark ? Colors.grey[900] : Colors.white,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              header,
              subHeader,
              workTodayLogo,
              Spacer(),
              registrationOptions,
              getStartedButton,
            ],
          ),
        ),
      ),
    );
  }
}

//class HomeScreen extends StatefulWidget {
//  @override
//  _HomeScreenState createState() => _HomeScreenState();
//}
//
//class _HomeScreenState extends State<HomeScreen> {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      backgroundColor: Color(0xFF0A0E21),
//      body: SafeArea(
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: [
//            Expanded(
//              child: Column(
//                mainAxisAlignment: MainAxisAlignment.center,
//                children: [
//                  Center(
//                    child: Text(
//                      'LABOUR TODAY',
//                      style: TextStyle(
//                        fontSize: 40.0,
//                        fontWeight: FontWeight.bold,
//                        color: Colors.cyanAccent,
//                        letterSpacing: 2,
//                      ),
//                    ),
//                  ),
//                  SizedBox(
//                    height: 10,
//                  ),
//                  Text(
//                    'Hire Labours Instantly',
//                    style: TextStyle(
//                      color: Colors.cyanAccent,
//                      fontWeight: FontWeight.bold,
//                      fontSize: 20,
//                      letterSpacing: 1.0,
//                    ),
//                  ),
//                ],
//              ),
//            ),
//            Row(
//              children: [
//                Expanded(
//                  child: Card(
//                    elevation: 10,
//                    color: Color(0xFF1D1E33),
//                    child: FlatButton(
//                      onPressed: () {
//                        Navigator.push(
//                            context,
//                            MaterialPageRoute(
//                              builder: (context) => RegistrationScreen(isHire: true,),
//                              settings: RouteSettings(name: 'Registration Screen'),
//                            ));
//                      },
//                      child: Text(
//                        'HIRE',
//                        style: TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold),
//                      ),
//                    ),
//                  ),
//                ),
//                Expanded(
//                  child: Card(
//                    elevation: 10,
//                    color: Color(0xFF1D1E33),
//                    child: FlatButton(
//                      onPressed: () {
//                        Navigator.push(
//                            context,
//                            MaterialPageRoute(
//                              builder: (context) => RegistrationScreen(isHire: false,),
//                              settings: RouteSettings(name: 'Registration Screen'),
//                            ));
//                      },
//                      child: Text(
//                        'WORk',
//                        style: TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold),
//                      ),
//                    ),
//                  ),
//                ),
//              ],
//            ),
//            Row(
//              children: [
//                Expanded(
//                  child: Card(
//                    elevation: 10,
//                    color: Color(0xFF1D1E33),
//                    child: FlatButton(
//                      onPressed: () {
//                        Navigator.push(
//                            context,
//                            MaterialPageRoute(
//                              builder: (context) => LoginScreen(),
//                              settings: RouteSettings(name: 'Login Screen'),
//                            ));
//                      },
//                      child: Text(
//                        'LOGIN',
//                        style: TextStyle(
//                          color: Colors.cyanAccent,
//                          fontWeight: FontWeight.bold,
//                        ),
//                      ),
//                    ),
//                  ),
//                ),
//              ],
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//}
