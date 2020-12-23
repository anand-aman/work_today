import 'package:work_today/components/my_button.dart';
import 'package:work_today/model/category.dart';
import 'package:work_today/screens/available_worker.dart';
import 'package:work_today/screens/home_screen.dart';
import 'package:work_today/screens/worker_home.dart';
import 'package:work_today/services/check.dart';
import 'package:work_today/services/firebase_user.dart';
import 'package:flutter/material.dart';
import 'package:work_today/components/category_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryScreen extends StatefulWidget {

  final bool isHirer;
  final bool isdark;

  const CategoryScreen({Key key, this.isHirer, this.isdark}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  Category category = Category();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.isdark?Colors.grey[850]:Colors.grey,
      body: SafeArea(
        child: Stack(
          children: [
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (BuildContext context, int index) {
                bool isSelected = false;
                return CategoryCard(
                  isdark: widget.isdark,
                  text: category.categoryList[index],
                  isSelected: category.categoryBool[index],
                  onPress: () {

                    if(widget.isHirer){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AvailableWorker(
                              isdark: widget.isdark,
                              category: category.categoryList[index],),
                          ));
                    }
                    else{
                      setState(() {
                        category.categoryBool[index] = !category.categoryBool[index];
                      });
                    }
                  },
                );
              },
              itemCount: category.categoryList.length,
            ),
            widget.isHirer ? Container() :Positioned(
              left: MediaQuery.of(context).size.width * 0.5 - 50,
              child: MyButton(
                text: 'Continue..',
                width: 100.0,
                onPressed: () async {
                  await FirebaseCurrentUser().addCategory(category);
                  await FirebaseCurrentUser().updateCategory(category).then((value) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Check(
                            isdark: widget.isdark,
                          ),
                        ));
                  });
                },
              ),
              bottom: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
