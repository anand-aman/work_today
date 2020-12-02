import 'package:flutter/material.dart';
import 'package:work_today/components/worker_card.dart';

class AvailableWorker extends StatelessWidget {
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
                Text("Available Workers",
                    style: TextStyle(
                        fontSize: 50.0,
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
//                    onTap: () {
//                      Navigator.push(
//                        context,
//                        MaterialPageRoute(
//                          builder: (context) => JobDetail(
//                            company: recent,
//                          ),
//                        ),
//                      );
//                    },
                      child: WorkerCard(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
