import 'package:work_today/services/firebase_user.dart';
import 'package:flutter/material.dart';
import 'package:work_today/components/ReqCard.dart';
import 'package:work_today/screens/DescriptionScreen.dart';

import 'home_screen.dart';

class WorkerHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: Color(0xFFF6F6F6),
        elevation: 0.0,
        leading: Padding(
          padding: const EdgeInsets.only(
            left: 18.0,
            top: 12.0,
            bottom: 12.0,
            right: 12.0,
          ),
          child: IconButton(
            icon: Icon(
              Icons.notifications,
              size: 25.0,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ),
        actions: <Widget>[
//          Icon(Icons.supervised_user_circle, size: 25.0, color: Colors.black),
          SizedBox(
            width: 18.0,
          ),
          FlatButton(
              onPressed: () {
                FirebaseCurrentUser().signOut();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                      settings: RouteSettings(name: 'Home Screen'),
                    ));
              },
              child: Text('Logout')),
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(left: 18.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 25.0,
              ),
              Text("Hii ,\nHere Are Your Requests",
                  style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w500,
                      wordSpacing: 2.5,
                      color: Colors.black)),
              SizedBox(
                height: 45.0,
              ),
              ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemBuilder: (context, index) {
//                  var recent = categories[index];
                  return InkWell(
                    onTap: () {
//                      Navigator.push(
//                          context, MaterialPageRoute(builder: (context) => DescriptionScreen()));
                    },
                    child: CategoryCard(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
