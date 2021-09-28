import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:work_today/constants.dart';
import 'package:work_today/screens/auth/login_screen.dart';
import 'package:work_today/screens/auth/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:work_today/model/app_user.dart';
import 'package:work_today/screens/category_screen.dart';
import 'package:work_today/screens/hirer_home.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:work_today/services/check.dart';
import 'package:work_today/services/firebase_user.dart';

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
      theme: widget.isdark?ThemeData.dark():ThemeData.light().copyWith(primaryColor:  Colors.white),
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: false,
            elevation: 0,
            actions: [

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(

                  child:Icon(Icons.brightness_4_outlined,color: Colors.deepPurple,size: 30.0, ) ,
                  onTap: (){
                    setState(() {
                      widget.isdark = !widget.isdark;
                    });
                  },
                ),
              )



            ],


          ),
          backgroundColor: widget.isdark?Colors.grey[900]:Colors.white,
          body: ModalProgressHUD(
            inAsyncCall: inAsyncCall,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        'WORK TODAY',
                        style: TextStyle(
                          fontFamily: 'Dancing',
                          fontSize: 40.0,
                          fontWeight: FontWeight.w900,
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
                        fontSize: 17,
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
                            color: widget.isdark?Colors.black12: Colors.white,
                            child: FlatButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RegistrationScreen(
                                        isHire: true,
                                        isdark: widget.isdark,
                                        signInMethod: SignInMethod.email,
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
                            color: widget.isdark?Colors.black12: Colors.white,
                            child: FlatButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RegistrationScreen(
                                        isdark: widget.isdark,
                                        isHire: false,
                                        signInMethod: SignInMethod.email,
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
                            color: widget.isdark?Colors.black12: Colors.white,
                            child: FlatButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginScreen(
                                        isdark : widget.isdark,
                                      ),
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
                    SizedBox(
                      height: 30,
                    ),
                    // GoogleSignInButton(
                    //   darkMode: true,
                    //   centered: true,
                    //   onPressed: ()async{
                    //     setState(() {
                    //       inAsyncCall=true;
                    //     });
                    //       await FirebaseCurrentUser().signInWithGoogle().then((user)async{
                    //         DocumentSnapshot snapshot = await _firestore
                    //             .collection('users')
                    //             .doc(user.uid).get();
                    //         setState(() {
                    //           inAsyncCall=false;
                    //         });
                    //
                    //         if(snapshot.exists){
                    //           print("User Exists");
                    //           Navigator.push(
                    //               context,
                    //               MaterialPageRoute(
                    //                 builder: (context) => Check(
                    //                   isdark: widget.isdark,
                    //                 ),
                    //               ));
                    //         }
                    //         else{
                    //           print("User Does not exist");
                    //           Navigator.push(
                    //               context,
                    //               MaterialPageRoute(
                    //                 builder: (context) => RegistrationScreen(
                    //                   isHire: false,
                    //                   signInMethod: SignInMethod.google,
                    //                 ),
                    //                 settings: RouteSettings(name: 'Google Registration Screen'),
                    //               ));
                    //         }
                    //       });
                    //
                    //   },
                    // ),
                  ],
                ),
              ],
            ),
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
