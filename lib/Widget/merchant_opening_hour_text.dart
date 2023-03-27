import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MerchantOpeningHourText extends StatelessWidget {
  late String data;
  late String image;
  late var textColor;
  late var boxColor;
  late var fontWeight;
  late var marginLeft;
  late var borderCircular;
  final void Function() onTap;

  MerchantOpeningHourText({
    required this.data,
    required this.textColor,
    required this.boxColor,
    required this.fontWeight,
    required this.marginLeft,
    required this.borderCircular,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onTap();
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: boxColor,
          ),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              bottomLeft: Radius.circular(8),
              topRight: borderCircular,
              bottomRight: borderCircular),
          color: boxColor,
        ),
        alignment: Alignment.center,
        width: 0.22.sw,
        height: 90.h,
        margin: EdgeInsets.only(left: marginLeft),
        child: Text(
          data,
          style: TextStyle(
              color: textColor, fontWeight: fontWeight, fontSize: 40.sp),
        ),
      ),
    );
  }
}
