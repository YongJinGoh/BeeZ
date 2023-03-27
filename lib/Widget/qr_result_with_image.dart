import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Widget/merchant_category_grid.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QrResultWithImage extends StatelessWidget {
  late String description;
  late String data;
  late String image;

  QrResultWithImage(
      {required this.description, required this.data, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        width: 1.sw,
        child: Row(
          children: [
            SizedBox(
              width: 25.w,
            ),
            Image.asset(
              image,
              fit: BoxFit.cover,
              height: 90.w,
              width: 90.w,
            ),
            SizedBox(
              width: 25.w,
            ),
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      description,
                      style: TextStyle(fontSize: 46.sp),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      data,
                      style: TextStyle(color: Colors.blue, fontSize: 40.sp),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
