import 'package:flutter/material.dart';
import 'package:work_today/services/firebase_user.dart';

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
      backgroundColor: widget.isdark?Colors.grey[900]:Colors.white,
      appBar: AppBar(

        backgroundColor: widget.isdark?Colors.black12:Colors.grey[900],
        elevation: 0,
        title: Row(

          children: <Widget>[
            Icon(

                Icons.account_circle,
                color: Colors.white),
            Text("User Profile")
          ],

        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: widget.isdark?Colors.black12: Colors.white,
          child: Expanded(
            child: Column(
              children: <Widget>[
                SizedBox(height: 16),
                Container(
                  alignment: Alignment.topCenter,

                  child: CircleAvatar(
                    radius: 80,
                    backgroundImage: AssetImage('images/user.png'),
                  ),

                ),
                SizedBox(height: 16),
                Container(
                  alignment: Alignment.center,
                  child: Text("${FirebaseCurrentUser.appUser.name}", style: TextStyle(
                      color: Color(0xff7f1cff),
                      fontSize: 32
                  ),),
                ),
                SizedBox(height: 32),

                Card(
                    color: Colors.black12,
                    margin:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                    child: ListTile(
                      leading: Icon(
                        Icons.email,
                        color: Color(0xff7f1cff),
                      ),
                      title: Text(
                        "${FirebaseCurrentUser.appUser.email}",
                        style:
                        TextStyle(fontFamily: '',
                            color: Color(0xff7f1cff),
                            fontSize: 20.0),
                      ),
                    )),
                Card(
                    color: Colors.black12,
                    margin:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                    child: ListTile(
                      leading: Icon(
                        Icons.phone_android,
                        color: Color(0xff7f1cff),
                      ),
                      title: Text(
                        "${FirebaseCurrentUser.appUser.phoneNo}",
                        style:
                        TextStyle(fontFamily: '',
                            color: Color(0xff7f1cff),
                            fontSize: 20.0),
                      ),
                    )
                ),
                Card(
                    color: Colors.black12,
                    margin:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                    child: ListTile(
                      leading: Icon(
                        Icons.location_on_rounded,
                        color: Color(0xff7f1cff),
                      ),
                      title: Text(
                        "${FirebaseCurrentUser.appUser.location}",
                        style:
                        TextStyle(fontFamily: '',
                            color: Color(0xff7f1cff),
                            fontSize: 20.0),
                      ),
                    )
                ),
                Card(
                    color: Colors.black12,
                    margin:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                    child: ListTile(
                      leading: Icon(
                        Icons.person,
                        color: Color(0xff7f1cff),
                      ),
                      title: Text(
                        FirebaseCurrentUser.appUser.isHirer?"Hirer": "Worker",
                        style:
                        TextStyle(fontFamily: '',
                            color: Color(0xff7f1cff),
                            fontSize: 20.0),
                      ),
                    )
                ),

                Card(
                    color: Colors.black12,
                    margin:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                    child: ListTile(
                      leading: Icon(
                        Icons.category_outlined,
                        color: Color(0xff7f1cff),
                      ),
                      title: Text(
                        "${FirebaseCurrentUser.appUser.category}",
                        style:
                        TextStyle(fontFamily: '',
                            color: Color(0xff7f1cff),
                            fontSize: 20.0),
                      ),
                    )
                ),

              ],
            ),
          ),
        ),
      ),


    );
  }
}

