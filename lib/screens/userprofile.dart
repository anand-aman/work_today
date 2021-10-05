import 'package:flutter/material.dart';
import 'package:work_today/services/firebase_user.dart';
import 'package:work_today/widgets/text.dart';

class UserProfile extends StatefulWidget {
  final bool isdark;
  final Name;
  final job;
  final location;
  final int amount;
  final bool category;
  final String email;
  final String phoneNo;
  const UserProfile(
      {this.isdark,
      this.Name,
      this.job,
      this.location,
      this.amount,
      this.phoneNo,
      this.email,
      this.category});
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.isdark ? Colors.grey[900] : Colors.white,
      appBar: AppBar(
        backgroundColor: widget.isdark?Colors.grey[900]:Colors.white,
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
        elevation: 0,
        title: Row(
          children: <Widget>[TextHelper(
                        text: "${widget.Name}'s profile",
                        color: widget.isdark ? Colors.white : Colors.black,
                        size: 25,
                        weight: FontWeight.bold,),],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: widget.isdark ? Colors.black12 : Colors.white,
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
                    child: TextHelper(
                        text: "${widget.Name}",
                        color: widget.isdark ? Colors.white : Colors.black,
                        size: 25,
                        weight: FontWeight.bold,),
                        ),
                SizedBox(height: 32),
                Card(
                    color: Colors.grey[200],
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                    child: ListTile(
                      leading: Icon(
                        Icons.email_outlined,
                        color: Colors.black,
                        size: 20,
                      ),
                      title:TextHelper(
                        text: "${widget.email}",
                        color: widget.isdark ? Colors.white : Colors.black,
                        size: 18,
                        weight: FontWeight.bold,),
                    )),
                Card(
                    color: Colors.grey[200],
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                    child: ListTile(
                      leading: Icon(
                      
                        Icons.phone,
                        color: Colors.black,
                        size: 20,
                        
                      ),
                      title:TextHelper(
                        text: "${widget.phoneNo}",
                        color: widget.isdark ? Colors.white : Colors.black,
                        size: 18,
                        weight: FontWeight.bold,),
                    )),
                Card(
                    color: Colors.grey[200],
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                    child: ListTile(
                      leading: Icon(
                        Icons.location_on_rounded,
                        color:Colors.black,
                        size: 20,
                      ),
                      title: TextHelper(
                        text: "${widget.location}",
                        color: widget.isdark ? Colors.white : Colors.black,
                        size: 18,
                        weight: FontWeight.bold,),
                    )),
                Card(
                    color: Colors.grey[200],
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                    child: ListTile(
                      leading: Icon(
                        Icons.person,
                        color: Colors.black,
                        size: 20,
                      ),
                      title: TextHelper(
                        text: widget.category?"Hirer":"Worker",
                        color: widget.isdark ? Colors.white : Colors.black,
                        size: 18,
                        weight: FontWeight.bold,),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
