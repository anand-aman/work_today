import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:work_today/model/request.dart';
import 'package:work_today/services/firebase_user.dart';

final _firestore = FirebaseFirestore.instance;

class RequestCard extends StatelessWidget {
  final RequestWorker requestWorker;

  const RequestCard({Key key, this.requestWorker}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: EdgeInsets.only(right: 18.0, top: 15.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ListTile(
        title: Text("${requestWorker.workerName}", style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w400),),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Job: ${requestWorker.job}"),
            Text("Location: ${requestWorker.location}"),
            Text("Offered Amount: ${requestWorker.amount}"),
          ],
        ),
        trailing: RaisedButton(
          color:  Colors.redAccent,
          child: Text("Cancel", style: TextStyle(color:  Colors.white),),
          onPressed: ()async{
           await _firestore
                .collection('users')
                .doc(FirebaseCurrentUser.user.uid).collection("request").doc(requestWorker.requestID).delete();

           print("Delete called on ${FirebaseCurrentUser.user.uid} and ${requestWorker.workerID} for ${requestWorker.requestID}");
            await _firestore
                .collection('users')
                .doc(requestWorker.workerID).collection("request").doc(requestWorker.requestID).delete();

          },
        ),
      ),
    );
  }
}
