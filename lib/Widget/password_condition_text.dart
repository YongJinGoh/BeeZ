import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class PasswordConditionText extends StatelessWidget {
  late String title;
  late String imageAsset;

  PasswordConditionText({required this.title,required this.imageAsset});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 40.w,
          ),
          Image.asset(
            imageAsset,
            width: 30.w,
            height: 30.w,
          ),
          SizedBox(
            width: 40.w,
          ),
          Flexible(
              child: Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.visible,
            style: TextStyle(color: Colors.grey,fontSize: 34.sp),
          )),
        ],
      ),
    );
  }
}
