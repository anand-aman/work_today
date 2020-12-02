import 'package:flutter/material.dart';
import 'package:work_today/components/Job.dart';
import 'package:work_today/Constants.dart';

class DetailContent extends StatelessWidget {
  const DetailContent({
    Key key,
    @required this.data,
  }) : super(key: key);

  final Job data;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: kSpacingUnit * 4,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(kSpacingUnit * 5),
            topRight: Radius.circular(kSpacingUnit * 5),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: kSpacingUnit * 5),
              Center(
                child: Column(
                  children: [
                    SizedBox(height: kSpacingUnit * 2),
                    Text(
                      "Driver",
//                      data.hiringName,
                      style: kTitleTextStyle,
                    ),
                    SizedBox(height: kSpacingUnit),
                    Text(
                      "Bengaluru",
//                      data.location,
                      style: kCaptionTextStyle,
                    ),
                    Text(
                      "20k",
//                      data.salary,
                      style: kTitleTextStyle,
                    ),
                  ],
                ),
              ),
              SizedBox(height: kSpacingUnit * 5),
              Text(
                'Responsibilities',
                style: kSubTitleTextStyle,
              ),
              SizedBox(height: kSpacingUnit * 2),
//              if (data.responsibilities != null && data.responsibilities.length > 0)
//                ...data.responsibilities
//                    .map((responsibility) => DetailItem(data: responsibility))
//                    .toList(),
              SizedBox(height: kSpacingUnit * 15),
            ],
          ),
        ),
      ),
    );
  }
}
