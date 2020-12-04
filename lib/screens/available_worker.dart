import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:work_today/components/worker_card.dart';
import 'package:work_today/model/app_user.dart';
import 'package:work_today/model/category.dart';
import 'package:work_today/services/firebase_user.dart';

class AvailableWorker extends StatelessWidget {
  final String category;
  AvailableWorker({Key key, this.category}) : super(key: key);

  final _firestore = FirebaseFirestore.instance;
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
      backgroundColor: Color(0xFFF6F6F6),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: 18.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 25.0,
                ),
                Text("Available $category",
                    style: TextStyle(
                        fontSize: 50.0,
                        fontWeight: FontWeight.w500,
                        wordSpacing: 2.5,
                        color: Colors.black)),
                SizedBox(
                  height: 45.0,
                ),
                StreamBuilder<QuerySnapshot>(stream: _firestore.collection("users").snapshots(),builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.lightBlueAccent,
                      ),
                    );
                  }

                  final sampleTimers = snapshot.data.docs.reversed;
                  List<Widget> workerWidgetList = [];
                  for (var sampleTimer in sampleTimers) {
                    var data = sampleTimer.data();
                    String docID = sampleTimer.id;

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
                    workerWidgetList.add(WorkerCard(workerName: username, location: city, job: category, workerId: sampleTimer.id,));


                  }


                  return Container(
                    alignment: Alignment.center,
                    height: 250.0,
                    width: double.infinity,
                    child: ListView(
                      children: workerWidgetList,
                    ),
                  );
                },),
//                 ListView.builder(
//                   itemCount: 10,
//                   scrollDirection: Axis.vertical,
//                   shrinkWrap: true,
//                   physics: ScrollPhysics(),
//                   itemBuilder: (context, index) {
// //                  var recent = categories[index];
//                     return InkWell(
// //                    onTap: () {
// //                      Navigator.push(
// //                        context,
// //                        MaterialPageRoute(
// //                          builder: (context) => JobDetail(
// //                            company: recent,
// //                          ),
// //                        ),
// //                      );
// //                    },
//                       child: WorkerCard(),
//                     );
//                   },
//                 ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
