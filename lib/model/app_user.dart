import 'package:work_today/constants.dart';
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
  String location;
  bool isHirer;
  SignInMethod signInMethod;
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
    location = data['city'];
    isHirer = data['isHirer'];
    signInMethod = SignInMethod.values[data['signInMethod']];
  }

  Future<void> getUserData(String docID) async {
    DocumentReference ref = _firestore.collection('users').doc(docID);
    DocumentSnapshot doc = await ref.get();
    var data = doc.data();
    print(data);

    name = data['name'];
    phoneNo = data['phoneNo'];
    email = data['email'];
    uid = data['uid'];
    location = data['city'];
    isHirer = data['isHirer'];
    signInMethod = SignInMethod.values[data['signInMethod']];
  }


}
