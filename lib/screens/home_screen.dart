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

  @override
  Widget build(BuildContext context) {
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  child: Icon(
                    widget.isdark ? Icons.light_mode : Icons.dark_mode,
                    color: widget.isdark
                        ? Colors.white
                        : Color.fromRGBO(56, 56, 68, 1),
                    size: 20.0,
                  ),
                  onTap: () {
                    setState(() {
                      widget.isdark = !widget.isdark;
                    });
                  },
                ),
              )
            ],
          ),
          backgroundColor: widget.isdark ? Colors.grey[900] : Colors.white,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 6,
              ),
              TextHelper(
                weight: FontWeight.bold,
                text: "Work Today",
                size: 30,
                color: widget.isdark
                    ? Colors.white
                    : Color.fromRGBO(56, 56, 68, 1),
              ),
              SizedBox(
                height: 5,
              ),
              TextHelper(
                text: "Hire workers instantly",
                size: 20,
                color: widget.isdark
                    ? Colors.white
                    : Color.fromRGBO(56, 56, 68, 1),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 3,
                child: Center(child: Image.asset("images/logo_bg_remove.png")),
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
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
                          ));
                    },
                    child: Center(
                      child: TextHelper(
                        weight: FontWeight.bold,
                        text: "Hire | ",
                        size: 18,
                        color: widget.isdark ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
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
                          ));
                    },
                    child: Center(
                      child: TextHelper(
                        weight: FontWeight.bold,
                        text: "Work",
                        size: 18,
                        color: widget.isdark ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(
                          isdark: widget.isdark,
                        ),
                        settings: RouteSettings(name: 'Login Screen'),
                      ));
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 40, right: 40),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: widget.isdark
                            ? Colors.white
                            : Color.fromRGBO(56, 56, 68, 1),
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
