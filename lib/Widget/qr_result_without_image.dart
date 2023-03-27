import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Widget/merchant_category_grid.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

class QrResultWithoutImage extends StatelessWidget {
  late String text;

  QrResultWithoutImage({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      width: 1.sw,
      color: Colors.blue[50],
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'RECEIPT_FOR'.tr(),
              style: TextStyle(fontSize: 46.sp),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              text,
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 40.sp,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
