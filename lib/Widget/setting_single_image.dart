import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Widget/change_password_page.dart';

class SettingSingleImage extends StatelessWidget {
  late String data;
  late String image;
  var nextPage;
  late double widthSize;

  SettingSingleImage(
      {required this.data,
      required this.image,
      required this.nextPage,
      required this.widthSize});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => nextPage)),
      child: Container(
        width: widthSize,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        // margin: EdgeInsets.all(6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 12.w),
            Container(
              padding: EdgeInsets.all(10),
              child: Image.asset(
                image,
                width: 90.w,
                height: 90.w,
              ),
            ),
            SizedBox(width: 12.w),
            Flexible(
              child: Text(
                data,
                style: TextStyle(
                  fontSize: 44.sp,
                  color: Colors.grey,
                ),
                softWrap: true,
                maxLines: 2,
                overflow: TextOverflow.visible,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
