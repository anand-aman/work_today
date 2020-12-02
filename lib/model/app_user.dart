import 'package:work_today/model/category.dart';
import 'package:work_today/model/category.dart';
import 'package:work_today/services/firebase_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;

class AppUser {
  String name;
  String phoneNo;
  String email;
  String uid;
  String city;
  bool isHirer;
  Category category;

  Future<void> initialize() async {
    DocumentReference ref = _firestore.collection('users').doc(FirebaseCurrentUser.user.uid);
    DocumentSnapshot doc = await ref.get();
    var data = doc.data();
    print(data);

    name = data['name'];
    phoneNo = data['phoneNo'];
    email = data['email'];
    uid = FirebaseCurrentUser.user.uid;
    city = data['city'];
    isHirer = data['isHirer'];
  }
}
