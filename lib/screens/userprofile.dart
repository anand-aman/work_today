import 'package:flutter/material.dart';
import 'package:work_today/services/firebase_user.dart';

class UserProfile extends StatefulWidget {
  final bool isdark;
  final Name ;
  final job;
  final location;
  final int amount;
  final bool category;
  final String email;
  final String phoneNo;
  const UserProfile({this.isdark,this.Name, this.job, this.location, this.amount, this.phoneNo, this.email, this.category});
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
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
                  child: Text("${widget.Name}", style: TextStyle(
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
                        Icons.email_outlined,
                        color: Color(0xff7f1cff),
                      ),
                      title: Text(
                        "${widget.email}",
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
                        Icons.phone,
                        color: Color(0xff7f1cff),
                      ),
                      title: Text(
                        "${widget.phoneNo}",
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
                        Icons.location_on_rounded,
                        color: Color(0xff7f1cff),
                      ),
                      title: Text(
                        "${widget.location}",
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
                        widget.category?"Hirer": "Worker",
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
