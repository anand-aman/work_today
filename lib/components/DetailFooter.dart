import 'package:flutter/material.dart';
import 'package:work_today/components/Job.dart';
import 'package:work_today/Constants.dart';

class DetailFooter extends StatelessWidget {
  const DetailFooter({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: EdgeInsets.all(kSpacingUnit * 2),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [kFooterShadow],
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: kSpacingUnit * 6,
                decoration: BoxDecoration(
                  color: Colors.lightGreen,
                  borderRadius: BorderRadius.circular(kSpacingUnit * 3),
                ),
                child: Center(
                  child: Text(
                    'Accept',
                    style: kTitleTextStyle.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: kSpacingUnit * 2),
            Expanded(
              child: Container(
                height: kSpacingUnit * 6,
                decoration: BoxDecoration(
                  color: kAccentColor,
                  borderRadius: BorderRadius.circular(kSpacingUnit * 3),
                ),
                child: Center(
                  child: Text(
                    'Reject',
                    style: kTitleTextStyle.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
