import 'package:work_today/components/Card.dart';
import 'package:work_today/components/my_button.dart';
import 'package:work_today/services/firebase_user.dart';
import 'package:flutter/material.dart';
import 'package:work_today/screens/available_worker.dart';
import 'package:work_today/components/Job.dart';

import 'home_screen.dart';

class HireHome extends StatelessWidget {
  double len = JobList.length / 3;

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
              Text("Hii ,\nWhat Are You Looking For",
                  style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w500,
                      wordSpacing: 2.5,
                      color: Colors.black)),
//              Padding(
//                padding: const EdgeInsets.only(right:18.0),
//                child: Container(
//                  padding: EdgeInsets.symmetric(horizontal: 15.0,),
//                  decoration: BoxDecoration(
//                    color: Colors.white,
//                    borderRadius: BorderRadius.circular(12.0),
//                  ),
//                  child: TextField(
//                    cursorColor: Colors.black,
//                    decoration: InputDecoration(
//                      icon: Icon(
//                        Icons.search,
//                        size: 25.0,
//                        color: Colors.black,
//                      ),
//                      border: InputBorder.none,
//                      hintText: "Search for job title",
//
//                    ),
//                  ),
//                ),
//              ),
              SizedBox(
                height: 45.0,
              ),
//              Row(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: <Widget>[
//                  Padding(
//                    padding: const EdgeInsets.only(left: 14.0),
//                    child: Text(
//                      "Frequent Categories",
//                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
//                    ),
//                  ),
//                  GestureDetector(
//                      onTap: () {
////                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Worker()) );
//                      },
//                      child: Padding(
//                        padding: const EdgeInsets.only(right: 18.0),
//                        child: Text(
//                          "Show All>>",
//                          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
//                        ),
//                      )),
//                ],
//              ),
//              SizedBox(
//                height: 15.0,
//              ),
              ListView.builder(
                itemCount: len.toInt(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemBuilder: (context, index) {
                  var recent = JobList[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => AvailableWorker()));
                    },
                    child: CategoryCard(
                      job: recent,
                    ),
                  );
                },
              ),
              SizedBox(
                height: 200.0,
              ),
              Center(child: MyButton(text: 'Hire', onPressed: () {})),
              SizedBox(
                height: 50.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
