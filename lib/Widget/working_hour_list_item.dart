import '../Model/working_hour_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkingHourListItem extends StatelessWidget {
  late WorkingHour data;
  bool isOpen;

  WorkingHourListItem({required this.data, required this.isOpen});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 15.h),
        child: isOpen
            ? data.acceptPoints == 'true'
                ? Row(children: [
                    Text(data.day + '  -  ' + data.open,
                        style: TextStyle(fontSize: 40.sp)),
                    Image.asset(
                      'assets/images/accept_point.png',
                      width: 150.w,
                      height: 75.h,
                    ),
                  ])
                : Row(children: [
                    Text(data.day + '  -  ' + data.open,
                        style: TextStyle(fontSize: 40.sp)),
                  ])
            : data.acceptPoints == 'true'
                ? Row(children: [
                    Text(data.day + '  -  ' + data.closing,
                        style: TextStyle(fontSize: 40.sp)),
                    Image.asset(
                      'assets/images/accept_point.png',
                      width: 150.w,
                      height: 75.h,
                    ),
                  ])
                : Row(children: [
                    Text(data.day + '  -  ' + data.closing,
                        style: TextStyle(fontSize: 40.sp))
                  ]));
  }
}
