import 'package:work_today/components/my_button.dart';
import 'package:work_today/screens/hirer_home.dart';
import 'package:work_today/services/check.dart';
import 'package:work_today/services/firebase_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:work_today/components/location_data.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import 'category_screen.dart';

class LocationScreen extends StatefulWidget {
  final bool isHirer;
  final bool isdark;

  const LocationScreen({Key key, this.isHirer, this.isdark}) : super(key: key);
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  LocationData ld = LocationData();
  final _cityName = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _cityName.dispose();
  }

  void getCurrentCity() async {
    String cityName = await ld.getCurrentlocation();
    setState(() {
      _cityName.text = cityName;
    });
  }

  void navigateToHirerHomepage() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Check(
            isdark: widget.isdark,
          ),
        ),
    );
  }

  void navigateToWorkerHomepage() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => CategoryScreen(
            isHirer: false,
            isdark:widget.isdark,
          ),
        ),
    );
  }

  void updateUserLocation() async {
    FirebaseCurrentUser().updateLocation(_cityName.text).then((value){
      if (widget.isHirer)
        navigateToHirerHomepage();
      else
        navigateToWorkerHomepage();
    });
  }

  @override
  Widget build(BuildContext context) {

    Widget locationForm =  Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 75, bottom: 25),
      child: TextField(
        controller: _cityName,
        decoration: InputDecoration(hintText: 'Enter The Location'),
      ),
    );

    Widget currentLocationButton = FlatButton(
      padding: EdgeInsets.all(8.0),
      color: Color(0xFFB57DFF),
      child: Column(
        children: <Widget>[
          Icon(
            Icons.location_searching,
            size: 25.0,
            color: Colors.white,
          ),
          Text(
            "Current Location",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
      onPressed: getCurrentCity,
    );

    Widget locationGif = Expanded(
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'images/Location.gif',
              ),
            )
        ),
      ),
    );

    Widget continueButton = Container(
      padding: const EdgeInsets.only(bottom: 40),
      child: MyButton(
        text: 'Continue..',
        width: 100.0,
        onPressed: updateUserLocation,
      ),
    );

    return Scaffold(
      backgroundColor: widget.isdark?Colors.grey[850]:Color(0xffFFFFFF),
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            locationForm,
            currentLocationButton,
            locationGif,
            continueButton,
          ],
        ),
      ),
    );
  }
}
