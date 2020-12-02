import 'package:flutter/material.dart';

class WorkerCard extends StatefulWidget {
  @override
  _WorkerCardState createState() => _WorkerCardState();
}

class _WorkerCardState extends State<WorkerCard> {
  Color color=Colors.lightGreen;
  String text="Hire";
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
        title: Text("Ramesh", style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w400)),
        subtitle: Text(
          "Driver • 5yrs",
        ),
        trailing: RaisedButton(
          color: color,
          child: Text("$text",style: TextStyle(color: Colors.white),),
          onPressed: (){
           setState(() {
             color=Colors.blueGrey;
             text="Requested";
           });
          },
        ),
      ),
    );
  }
}
