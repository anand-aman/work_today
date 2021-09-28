import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:work_today/components/worker_card.dart';
import 'package:work_today/model/app_user.dart';
import 'package:work_today/model/category.dart';
import 'package:work_today/services/firebase_user.dart';

final _firestore = FirebaseFirestore.instance;

class AvailableWorker extends StatelessWidget {
  final String category;
  final bool isdark;
  AvailableWorker({Key key, this.category, this.isdark}) : super(key: key);

  List<String> availableUserID = [];

  Future<void> getUserList() async {
    DocumentReference ref = _firestore.collection('category').doc('cfdOhIiAzuSEHARrTAPK');
    DocumentSnapshot doc = await ref.get();
    var data = doc.data();
    Map<String, dynamic> categoryMap = data['category'];
    availableUserID = categoryMap[category.toLowerCase()] as List<String>;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: this.isdark?Colors.grey[850]:Color(0xFFF6F6F6),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 25.0,
              ),
              Text("Available $category",
                  style: TextStyle(
                    fontFamily: 'Indie',
                      fontSize: 50.0,
                      fontWeight: FontWeight.w500,
                      wordSpacing: 2.5,
                      color: Colors.black)),
              SizedBox(
                height: 45.0,
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(stream: _firestore.collection("users").snapshots(),builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.lightBlueAccent,
                      ),
                    );
                  }

                  final jobs = snapshot.data.docs.reversed;
                  List<Widget> workerWidgetList = [];
                  for (var job in jobs) {
                    var data = job.data();
                    String docID = job.id;

                    // if(!availableUserID.contains(docID))
                    //   continue;
                    List<dynamic> categories = data['categories'];
                    if(categories==null)
                      continue;
                    if(!categories.contains(category))
                      continue;

                    String username = data['name'];
                    print(username);
                    String city = data['city'];
                    workerWidgetList.add(WorkerCard(workerName: username, location: city, job: category, workerId: job.id, isdark: this.isdark,));


                  }


                  return Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    child: ListView(
                      children: workerWidgetList,
                    ),
                  );
                },),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
