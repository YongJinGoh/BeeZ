import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Utils/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainTitleBar extends StatelessWidget {
  late String title;
  late var action;

  MainTitleBar({required this.title, required this.action});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.h,
      color: Constants.COLORS_PRIMARY_COLOR,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 30.w,
          ),
          GestureDetector(
            onTap: action,
            child: Image.asset(
              'assets/images/appicon_back.png',
              height: 60.w,
              width: 60.w,
            ),
          ),
          Container(
            height: 100.h,
            width: 0.78.sw,
            alignment: Alignment.center,
            child: Text(
              title,
              style: TextStyle(fontSize: 64.sp, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
