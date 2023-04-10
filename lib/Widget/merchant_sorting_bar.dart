import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../Utils/constants.dart';

class MerchantSortingBar extends StatelessWidget {
  final void Function() onTap;

  MerchantSortingBar({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Padding(
            padding: EdgeInsets.only(left: 30.w, top: 5.h, bottom: 5.h),
            child: Text('POPULAR_MERCHANT'.tr(),
                style: TextStyle(
                  fontSize: 48.sp,
                  color: Constants.COLORS_PRIMARY_ORANGE_COLOR,
                  fontWeight: FontWeight.bold,
                )),
          ),
        ),
        GestureDetector(
          onTap: () {
            onTap();
          },
          child: Row(children: [
            Text('VIEW_ALL'.tr(),
                style: TextStyle(
                  fontSize: 48.sp,
                  color: Constants.COLORS_PRIMARY_ORANGE_COLOR,
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(width: 10.w),
            Padding(
              padding: EdgeInsets.only(right: 30.w, top: 5.h, bottom: 5.h),
              child: Image.asset(
                'assets/images/appicon_filters.png',
                width: 50.w,
                height: 50.w,
              ),
            ),
          ]),
        )
      ],
    ));
  }
}
