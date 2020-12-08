import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:work_today/components/my_button.dart';
import 'package:work_today/components/request_card.dart';
import 'package:work_today/screens/category_screen.dart';
import 'package:work_today/services/firebase_user.dart';
import 'package:flutter/material.dart';
import 'package:work_today/model/request.dart';
import 'package:work_today/screens/available_worker.dart';

import 'home_screen.dart';

final _firestore = FirebaseFirestore.instance;

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
            Text(
                "Hii \${FirebaseCurrentUser.appUser.name},\nWhat Are You Looking For",
                style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w500,
                    wordSpacing: 2.5,
                    color: Colors.black)),
            Expanded(child: RequestStream()),
            Container(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: MyButton(
                    text: 'Hire',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryScreen(
                              isHirer: true,
                            ),
                          ));
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RequestStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection("users")
          .doc(FirebaseCurrentUser.user.uid)
          .collection("request")
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }

        final requests = snapshot.data.docs.reversed;
        List<Widget> requestCardList = [];
        for (var request in requests) {
          var data = request.data();

          // if(!availableUserID.contains(docID))
          //   continue;

          RequestWorker requestWorker = RequestWorker(
            workerName: data['workername'],
            workerID: data['workerid'],
            requestID: data['requestid'],
            location: data['location'],
            job: data['job'],
            isAccepted: data['isAccepted'],
            amount: data['offer'],
          );

          requestCardList.add(HirerRequestCard(
            requestWorker: requestWorker,
          ));
        }

        return Container(
          alignment: Alignment.center,
          width: double.infinity,
          child: ListView(
            children: requestCardList,
          ),
        );
      },
    );
  }
}
