import 'package:flutter/material.dart';
import 'package:work_today/components/Job.dart';
import 'package:work_today/Constants.dart';
import 'package:work_today/components/DetailContent.dart';
import 'package:work_today/components/DetailHeader.dart';
import 'package:work_today/components/DetailFooter.dart';

class DescriptionScreen extends StatelessWidget {
  final Job data;
  const DescriptionScreen({Key key, this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                DetailHeader(data: data),
                DetailContent(data: data),
              ],
            ),
            DetailFooter(),
          ],
        ),
      ),
    );
  }
}
