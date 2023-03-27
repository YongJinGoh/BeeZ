import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MerchantMiddleToolbarItem extends StatelessWidget {
  late String data;
  late String image;
  late String insideData;
  late var boxColor;

  MerchantMiddleToolbarItem(
      {required this.data,
      required this.image,
      required this.boxColor,
      required this.insideData});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            data,
            style: TextStyle(
              fontSize: 45.sp,
              color: Colors.grey,
            ),
          ),
        ),
        SizedBox(
          height: 15.h,
        ),
        Container(
          height: 120.h,
          decoration: BoxDecoration(
            border: Border.all(
              color: boxColor,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: boxColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                width: 10.w,
              ),
              Image.asset(
                image,
                width: 100.w,
                height: 100.h,
              ),
              SizedBox(
                width: 20.w,
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      insideData,
                      style: TextStyle(
                        fontSize: 32.sp,
                        color: Colors.blue[900],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )),
            ],
          ),
        )
      ],
    ));
  }
}
