import 'package:work_today/screens/auth/login_screen.dart';
import 'package:work_today/screens/auth/registration_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      'WORK TODAY',
                      style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF7F1CFF),
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Hire Worker Instantly',
                    style: TextStyle(
                      color: Color(0xFF7F1CFF),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          elevation: 5.0,
                          color: Colors.white,
                          child: FlatButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegistrationScreen(
                                      isHire: true,
                                    ),
                                    settings: RouteSettings(name: 'Registration Screen'),
                                  ));
                            },
                            child: Text(
                              'HIRE',
                              style: TextStyle(
                                color: Color(0xFF7F1CFF),
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          elevation: 5,
                          color: Colors.white,
                          child: FlatButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegistrationScreen(
                                      isHire: false,
                                    ),
                                    settings: RouteSettings(name: 'Registration Screen'),
                                  ));
                            },
                            child: Text(
                              'WORK',
                              style: TextStyle(
                                color: Color(0xFF7F1CFF),
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          margin: EdgeInsets.all(10),
                          elevation: 5,
                          color: Colors.white,
                          child: FlatButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginScreen(),
                                    settings: RouteSettings(name: 'Login Screen'),
                                  ));
                            },
                            child: Text(
                              'LOGIN',
                              style: TextStyle(
                                color: Color(0xFF7F1CFF),
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
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
