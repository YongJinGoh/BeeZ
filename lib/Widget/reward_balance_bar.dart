import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../Utils/constants.dart';

class RewardsBalanceBar extends StatelessWidget {
  late String accPoints;

  RewardsBalanceBar({required this.accPoints});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15, left: 15),
      child: Container(
        height: 120.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 30.w),
              child: Text(
                'CURRENT_BALANCE'.tr(),
                style: TextStyle(fontSize: 46.sp),
                overflow: TextOverflow.visible,
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    child: GestureDetector(
                        child: Image.asset(
                      'assets/images/appicon_27thcoin.png',
                      width: 70.w,
                      height: 70.w,
                    )),
                    margin: EdgeInsets.only(right: 10.w),
                  ),
                  Container(
                    child: Text(
                      accPoints,
                      style: TextStyle(fontSize: 46.sp),
                    ),
                    margin: EdgeInsets.only(right: 20.w),
                    alignment: Alignment.centerRight,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
