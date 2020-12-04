import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:work_today/model/app_user.dart';
import 'package:work_today/services/firebase_user.dart';

class WorkerCard extends StatefulWidget {
  final String workerName;
  final String location;
  final String workerId;
  final String job;

  const WorkerCard({Key key, this.workerName, this.location, this.workerId, this.job}) : super(key: key);
  @override
  _WorkerCardState createState() => _WorkerCardState();
}

class _WorkerCardState extends State<WorkerCard> {

  final _firestore = FirebaseFirestore.instance;
  bool isLoading = false;
  bool isRequested = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      margin: EdgeInsets.only(right: 18.0, top: 15.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ListTile(
//        leading: Container(
//          width: 50.0,
//          height: 50.0,
//          decoration: BoxDecoration(
//            borderRadius: BorderRadius.circular(12.0),
//            image: DecorationImage(
//              image: AssetImage(job.image),
//              fit: BoxFit.cover,
//            ),
//          ),
//        ),
        title: Text("${widget.workerName}", style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w400)),
        subtitle: Text(
          "${widget.location}",
        ),
        trailing: RaisedButton(
          color:  Colors.lightGreen,
          child: isLoading ? CircularProgressIndicator(value: 10.0,) :Text(isRequested ? "Requested" :"Hire", style: TextStyle(color:  Colors.white),),
          onPressed: isRequested ? null : ()async{
            setState(() {
              isLoading=true;
            });
            AppUser hirer = FirebaseCurrentUser.appUser;
            AppUser worker = new AppUser();
            await worker.getUserData(widget.workerId);

            if(worker==null || hirer==null){
              print("Worker: $worker \n Hirer: $hirer");
              return;
            }
            _firestore
                .collection('users')
                .doc(worker.uid).collection("request").add({
              "hirername": hirer.name,
              "hirerid": hirer.uid,
              "job": widget.job,
              "location": hirer.location,
              "offer": 500,
            });

            _firestore
                .collection('users')
                .doc(hirer.uid).collection("request").add({
              "workername": worker.name,
              "workerid": worker.uid,
              "job": widget.job,
              "location": worker.location,
              "offer": 500,
            });

           setState(() {
             isLoading=false;
             isRequested=true;
           });
          },
        ),
      ),
    );
  }
}
