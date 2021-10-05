import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:work_today/components/my_button.dart';
import 'package:work_today/services/firebase_user.dart';

import 'home_screen.dart';

class ownProfile extends StatefulWidget {
  final bool isdark;
  const ownProfile({this.isdark});
  @override
  _ownProfileState createState() => _ownProfileState();
}

class _ownProfileState extends State<ownProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.isdark ? Colors.grey[900] : Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        iconTheme:
            IconThemeData(color: widget.isdark ? Colors.white : Colors.black),
        backgroundColor: widget.isdark ? Colors.black12 : Colors.white,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                FirebaseCurrentUser().signOut();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(
                        isdark: this.widget.isdark,
                      ),
                      settings: RouteSettings(name: 'Home Screen'),
                    ));
              },
              icon: Icon(
                Icons.logout_outlined,
                size: 20,
                color: widget.isdark ? Colors.white : Color(0xff7f1cff),
              ))
        ],
        title: Row(
          children: <Widget>[
            Text(
              "Account Settings",
              style: GoogleFonts.nunito(
                  color: widget.isdark ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: widget.isdark ? Colors.black12 : Colors.white,
          child: Column(
            children: <Widget>[
              SizedBox(height: 16),
              Container(
                alignment: Alignment.topCenter,
                child: CircleAvatar(
                  radius: 75,
                  backgroundImage: AssetImage('images/user.png'),
                ),
              ),
              SizedBox(height: 16),
              Container(
                alignment: Alignment.center,
                child: Text(
                  "${FirebaseCurrentUser.appUser.name}",
                  style: GoogleFonts.nunito(
                    textStyle: Theme.of(context).textTheme.headline4,
                    fontSize: 28,
                    color: this.widget.isdark ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 10),
              carder(
                name: FirebaseCurrentUser.appUser.email.toString(),
              ),
              SizedBox(
                height: 10,
              ),
              carder(
                name: FirebaseCurrentUser.appUser.phoneNo.toString(),
              ),
              SizedBox(
                height: 10,
              ),
              carder(
                name: FirebaseCurrentUser.appUser.location.toString(),
              ),
              SizedBox(
                height: 10,
              ),
              carder(
                name: FirebaseCurrentUser.appUser.isHirer ? "Hirer" : "Worker",
              ),
              SizedBox(
                height: 10,
              ),
              carder(
                name: FirebaseCurrentUser.appUser.category.toString(),
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

class carder extends StatelessWidget {
  final String name;
  final Icon icon;
  final Function fn;
  const carder({Key key, this.name, this.icon, this.fn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //this.fn;
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Center(
            child: Text(
              this.name,
              style: GoogleFonts.nunito(
                textStyle: Theme.of(context).textTheme.headline4,
                fontSize: 19,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          height: 45,
          width: MediaQuery.of(context).size.width - 50,
          decoration: BoxDecoration(
              color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
