import 'package:flutter/material.dart';
import 'package:work_today/components/category_card.dart';
import 'package:work_today/components/my_button.dart';
import 'package:work_today/model/category.dart';
import 'package:work_today/screens/available_worker.dart';
import 'package:work_today/services/check.dart';
import 'package:work_today/services/firebase_user.dart';

class CategoryScreen extends StatefulWidget {
  final bool isHirer;
  final bool isdark;

  const CategoryScreen({Key key, this.isHirer, this.isdark}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  Category category = Category();

  void navigateToAvailableWorkerPage(int index) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AvailableWorker(
            isdark: widget.isdark,
            category: category.categoryList[index],
          ),
        ),
    );
  }

  @override
  Widget build(BuildContext context) {

    Widget header = Text(
      "Category",
      style: TextStyle(
          color: widget.isdark ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
          letterSpacing: 1
      ),
    );


    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme:
            IconThemeData(color: widget.isdark ? Colors.white : Colors.black),
        title: header,
        backgroundColor: widget.isdark ? Colors.black87 : Colors.white,
      ),
      body: Container(
        color: widget.isdark ? Colors.black87 : Colors.white,
        child: Stack(
          children: [
            GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (BuildContext context, int index) {
                bool isSelected = false;
                return CategoryCard(
                  isdark: widget.isdark,
                  text: category.categoryList[index],
                  isSelected: category.categoryBool[index],
                  onPress: () {
                    if (widget.isHirer) {
                      navigateToAvailableWorkerPage(index);
                    }
                    else {
                      setState(() {
                        category.categoryBool[index] =
                            !category.categoryBool[index];
                      });
                    }
                  },
                );
              },
              itemCount: category.categoryList.length,
            ),
            widget.isHirer
                ? Container()
                : Positioned(
                    left: MediaQuery.of(context).size.width * 0.5 + 50,
                    child: MyButton(
                      buttonColor: Colors.black,
                      text: 'Continue..',
                      width: 140.0,
                      onPressed: () async {
                        await FirebaseCurrentUser().addCategory(category);
                        await FirebaseCurrentUser()
                            .updateCategory(category)
                            .then((value) {
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
