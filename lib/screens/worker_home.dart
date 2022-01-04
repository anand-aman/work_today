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
  void navigateToAccountPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ownProfile(
          isdark: widget.isdark,
        ),
      ),
    );
  }

  void toggleDarkMode() {
    setState(() {
      widget.isdark = !widget.isdark;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget notificationButton = Padding(
      padding: const EdgeInsets.only(left: 10, top: 12, bottom: 12, right: 12),
      child: IconButton(
        icon: Icon(
          Icons.notifications,
          size: 25,
          color: this.widget.isdark ? Colors.white : Color(0xff7f1cff),
        ),
        onPressed: () {},
      ),
    );

    Widget accountButton = Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: GestureDetector(
        child: Icon(
          Icons.account_circle_outlined,
          color: widget.isdark ? Colors.white : Colors.black,
          size: 20,
        ),
        onTap: navigateToAccountPage,
      ),
    );

    Widget toggleDarkModeButton = Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: GestureDetector(
        child: Icon(
          widget.isdark ? Icons.light_mode : Icons.dark_mode,
          color: widget.isdark ? Colors.white : Colors.black,
          size: 20,
        ),
        onTap: toggleDarkMode,
      ),
    );

    Widget header = Container(
      padding: const EdgeInsets.only(top: 25),
      child: Text(
        "Hello ${FirebaseCurrentUser.appUser.name},",
        style: GoogleFonts.nunito(
          textStyle: Theme.of(context).textTheme.headline4,
          fontSize: 24,
          color: this.widget.isdark ? Colors.white : Colors.black,
          fontWeight: FontWeight.w700,
        ),
      ),
    );

    Widget subHeader = Container(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        "Here are yours request",
        style: GoogleFonts.nunito(
          textStyle: Theme.of(context).textTheme.headline4,
          fontSize: 18,
          color: this.widget.isdark ? Colors.white : Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
    );

    Widget requestStream = Expanded(
      child: RequestStream(
        isdark: widget.isdark,
      ),
    );

    return Scaffold(
      backgroundColor:
          this.widget.isdark ? Colors.grey[850] : Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor:
            this.widget.isdark ? Colors.grey[850] : Color(0xFFF6F6F6),
        elevation: 0.0,
        leading: notificationButton,
        actions: <Widget>[
          accountButton,
          toggleDarkModeButton,
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(left: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            header,
            subHeader,
            requestStream,
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
