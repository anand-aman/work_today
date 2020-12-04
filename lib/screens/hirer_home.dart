import 'package:work_today/components/my_button.dart';
import 'package:work_today/screens/category_screen.dart';
import 'package:work_today/services/firebase_user.dart';
import 'package:flutter/material.dart';
import 'package:work_today/screens/available_worker.dart';

import 'home_screen.dart';

class HirerHome extends StatelessWidget {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 25.0,
            ),
            Text("Hii ,\nWhat Are You Looking For",
                style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w500,
                    wordSpacing: 2.5,
                    color: Colors.black)),
            Expanded(child: Center(child: MyButton(text: 'Hire', onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryScreen(isHirer: true,),
                  ));
            }))),
          ],
        ),
      ),
    );
  }
}
