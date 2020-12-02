import 'package:work_today/model/category.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:work_today/model/app_user.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseCurrentUser {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
//  final GoogleSignIn googleSignIn = GoogleSignIn();

  static User user;
  static AppUser appUser;

  User get currentUser {
    if (user != null) {
      return user;
    }

    final User currentUser = _auth.currentUser;
    user = currentUser;
    return currentUser;
  }

  Future<void> signOut() async {
    return _auth.signOut().then((value) {
      user = null;
    });
  }

  Future<void> updateLocation(String city) async {
    DocumentReference ref =
        _firestore.collection('users').doc(FirebaseCurrentUser().currentUser.uid);

    return ref.update({
//      'uid': user.uid,
//      'email': user.email,
//      'photoURL': user.photoURL,
//      'displayName': user.displayName,
//      'lastSeen': DateTime.now(),
      'city': city,
    });
  }

  Future<void> addCategory(Category category) async {
    List<String> selectedCategories = [];
    for (int i = 0; i < category.categoryList.length; i++) {
      if (category.categoryBool[i]) {
        selectedCategories.add(category.categoryList[i]);
      }
    }
    DocumentReference ref = _firestore.collection('users').doc(user.uid);

    ref.update({
      'categories': selectedCategories,
    });
  }

  Future<void> updateCategory(Category category) async {
    List<String> selectedCategories = [];
    for (int i = 0; i < category.categoryList.length; i++) {
      if (category.categoryBool[i]) {
        selectedCategories.add(category.categoryList[i].toLowerCase());
      }
    }

    DocumentReference ref = _firestore.collection('category').doc('cfdOhIiAzuSEHARrTAPK');
    DocumentSnapshot doc = await ref.get();
    var data = doc.data();
    Map<String, dynamic> categoryMap = data['category'];
    for (String str in selectedCategories) {
      print(str);
      if (categoryMap.containsKey(str)) {
        List<dynamic> list = categoryMap[str];
        if (!list.contains(currentUser.uid)) {
          list.add(currentUser.uid);
          categoryMap[str] = list;
        }
      } else {
        List<String> list = [currentUser.uid];
        categoryMap[str] = list;
      }
    }
    ref.set({
      'category': categoryMap,
    });
  }
}
