import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:work_today/components/request_card.dart';
import 'package:work_today/model/request.dart';
import 'package:work_today/screens/ownProfile.dart';
import 'package:work_today/services/firebase_user.dart';

import 'home_screen.dart';

final _firestore = FirebaseFirestore.instance;

class WorkerHome extends StatefulWidget {
  bool isdark;
  WorkerHome({this.isdark});

  @override
  _WorkerHomeState createState() => _WorkerHomeState();
}

class _WorkerHomeState extends State<WorkerHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          this.widget.isdark ? Colors.grey[850] : Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor:
            this.widget.isdark ? Colors.grey[850] : Color(0xFFF6F6F6),
        elevation: 0.0,
        leading: Padding(
          padding: const EdgeInsets.only(
            left: 10.0,
            top: 12.0,
            bottom: 12.0,
            right: 12.0,
          ),
          child: IconButton(
            icon: Icon(
              Icons.notifications,
              size: 25,
              color: this.widget.isdark ? Colors.white : Color(0xff7f1cff),
            ),
            onPressed: () {},
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              child: Icon(
                Icons.account_circle_outlined,
                color: widget.isdark ? Colors.white : Colors.black,
                size: 20,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ownProfile(
                              isdark: widget.isdark,
                            )));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              child: Icon(
                widget.isdark ? Icons.light_mode : Icons.dark_mode,
                color: widget.isdark ? Colors.white : Colors.black,
                size: 20,
              ),
              onTap: () {
                setState(() {
                  widget.isdark = !widget.isdark;
                });
              },
            ),
          ),
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
              "Hello ${FirebaseCurrentUser.appUser.name} ,",
              style: GoogleFonts.nunito(
                textStyle: Theme.of(context).textTheme.headline4,
                fontSize: 24,
                color: this.widget.isdark ? Colors.white : Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              "Here are yours request",
              style: GoogleFonts.nunito(
                textStyle: Theme.of(context).textTheme.headline4,
                fontSize: 18,
                color: this.widget.isdark ? Colors.white : Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Expanded(
                child: RequestStream(
              isdark: widget.isdark,
            )),
          ],
        ),
      ),
    );
  }
}

class RequestStream extends StatefulWidget {
  final bool isdark;
  RequestStream({this.isdark});
  @override
  _RequestStreamState createState() => _RequestStreamState();
}

class _RequestStreamState extends State<RequestStream> {
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

          RequestHirer hirerRequest = RequestHirer(
            hirerName: data['hirername'],
            hirerID: data['hirerid'],
            requestID: data['requestid'],
            location: data['location'],
            job: data['job'],
            isAccepted: data['isAccepted'],
            amount: data['offer'],
            email: data['email'],
            phoneNo: data['phoneNo'],
          );

          requestCardList.add(WorkerRequestCard(
            isdark: widget.isdark,
            hirerRequest: hirerRequest,
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
