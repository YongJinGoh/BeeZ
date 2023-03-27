import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Model/booking_display_model.dart';
import '../Widget/merchant_category_grid.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import '../Utils/constants.dart';

class BookingListItem extends StatelessWidget {
  late BookingDisplayData data;

  BookingListItem({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      margin: EdgeInsets.only(left: 30.w, right: 30.w, top: 20.h, bottom: 20.h),
      padding:
          EdgeInsets.only(left: 30.w, right: 30.w, top: 20.h, bottom: 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data.restaurantName,
            style: TextStyle(
                fontSize: 54.sp, color: Constants.COLORS_PRIMARY_ORANGE_COLOR),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            data.date + " " + data.time + " - " + data.slot + ' pax',
            style: TextStyle(
                fontSize: 46.sp, color: Constants.COLORS_PRIMARY_COLOR),
          ),
          SizedBox(
            height: 10.h,
          ),
          RichText(
            text: TextSpan(
              text: "Remark : ",
              style: TextStyle(color: Constants.COLORS_PRIMARY_ORANGE_COLOR),
              children: <TextSpan>[
                TextSpan(
                    text: data.remark, style: TextStyle(color: Colors.black54)),
              ],
            ),
          ),
          // Text("Remark :" + data.remark),
        ],
      ),
    );
  }
}
