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
    bool isdark;
   Check({this.isdark});
  @override
  _CheckState createState() => _CheckState();
}

class _CheckState extends State<Check> with TickerProviderStateMixin {
  AnimationController _animationController;
  AnimationController _animateController;
  bool iamhere = false;

  void check() async {
    Future.delayed(Duration(milliseconds: 4000), () async {
      if (FirebaseCurrentUser().currentUser == null) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(
                isdark: widget.isdark,
              ),
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
                builder: (context) => WorkerHome(
                  isdark: widget.isdark,
                ),
              ));
        else
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HirerHome(
                  isdark: widget.isdark,
                ),
              ));
      }
    });
  }

  void animationInitializer(){
    _animateController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _animateController.forward();
    _animateController.addListener(() {
      setState(() {});
    });
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
      upperBound: 1,
    );

    _animationController.reverse(from: 1);

    _animationController.addListener(() {
      setState(() {
        if (_animationController.value <= 0.154) {
          _animationController.stop();

          iamhere = true;
        }
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _animateController.dispose();
    super.dispose();
  }

  @override
  initState() {
    super.initState();
    check();
    animationInitializer();
  }


  Widget build(BuildContext context) {
    //Color(0xff383844)
    final double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xfff7ab37),
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Center(
            child: Container(
              height: 1000 * (_animateController.value),
              width: 1000 * (_animateController.value),
              decoration: BoxDecoration(
                color: Colors.white60,
                borderRadius:
                    BorderRadius.circular((1 - _animateController.value) * 600),
              ),
              child: Column(
                children: [
                  if (iamhere)
                    SizedBox(
                      height: _height * 0.65,
                    ),
                  if (iamhere)
                    Text(
                      'Work Today',
                      style: TextStyle(
                          color: Color(0xfff7ab37),
                          fontSize: 30,
                          fontFamily: 'FV_ALMELO'),
                    ),
                ],
              ),
            ),
          ),
          Center(
            child: Container(
              height: 1000 * _animationController.value,
              width: 1000 * _animationController.value,
              decoration: BoxDecoration(
                color: Color(0xfff7ab37),
                borderRadius: BorderRadius.circular(
                  600 * (1 - _animationController.value),
                ),
              ),
              child: Center(
                child: Opacity(
                  opacity: 1,
                  child: Container(
                    height: 160,
                    width: 160,
                    decoration: BoxDecoration(
                      color: Color(0xfff7ab37),
                      // image: DecorationImage(
                      //   image: AssetImage(
                      //     'images/logo2.jpg',
                      //   ),
                      // ),
                      //color: Colors.blue,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: CircleAvatar(
                      backgroundImage: AssetImage(
                        'images/logo.jpg',
                      ),
                    ),
                  ),
                ),
              ),

            ),
          ),
        ],
      ),
    );
  }
}
