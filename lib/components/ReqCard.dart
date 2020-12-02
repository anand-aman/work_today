import 'package:flutter/material.dart';
import 'package:work_today/components/Job.dart';
import 'package:work_today/screens/DescriptionScreen.dart';

class CategoryCard extends StatelessWidget {
  final Job job;
  CategoryCard({this.job});
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
        title: Text("DRIVER", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400)),
        subtitle: Text(
          "Driver • 20k-30k",
        ),
        trailing: Icon(
          Icons.more_vert,
          color: Colors.black,
        ),
      ),
    );
  }
}
