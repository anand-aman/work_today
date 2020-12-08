import 'package:work_today/model/app_user.dart';
import 'package:work_today/screens/home_screen.dart';
import 'package:work_today/screens/location_screen.dart';
import 'package:work_today/screens/available_worker.dart';
import 'package:work_today/screens/worker_home.dart';
import 'package:flutter/material.dart';
import 'package:work_today/services/firebase_user.dart';
import 'package:work_today/screens/category_screen.dart';
import 'package:work_today/screens/hirer_home.dart';

class Check extends StatefulWidget {
  @override
  _CheckState createState() => _CheckState();
}

class _CheckState extends State<Check> {
  void check() async {
    Future.delayed(Duration(milliseconds: 500), () async {
      if (FirebaseCurrentUser().currentUser == null) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
              settings: RouteSettings(name: 'Sign In Screen'),
            ));
      } else {
        AppUser appUser = AppUser();
        await appUser.initialize();
        FirebaseCurrentUser.appUser = appUser;

        if (!appUser.isHirer)
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => WorkerHome(),
              ));
        else
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HirerHome(),
              ));
      }
    });
  }

  @override
  initState() {
    super.initState();
    check();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[900],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(45.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:<Widget> [
                Image(
                  image: AssetImage('images/work2.webp'),

                  height: 50.0,

                ),
                Text(
                  "orkToday",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35.0,
                    fontFamily: 'Fruktur',
                    fontWeight: FontWeight.w900,

                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
