import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Model/reward_model.dart';
import '../Widget/merchant_category_grid.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import '../Utils/constants.dart';

class RewardsListItem extends StatelessWidget {
  late RewardModel data;

  RewardsListItem({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 30.w, right: 30.w, top: 20.h, bottom: 20.h),
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
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(4),
              height: 190.w,
              width: 190.w,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  height: 190.w,
                  width: 190.w,
                  fit: BoxFit.cover,
                  imageUrl: data.logo,
                  placeholder: (context, url) => Image.asset(
                    'assets/images/logo-icon-beez2.png',
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    'assets/images/logo-icon-beez2.png',
                  ),
                ),
              ),
            ),
          ),
          Expanded(
              flex: 3,
              child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.name,
                      style: TextStyle(
                          fontSize: 40.sp, color: Constants.COLORS_FONT_TITLE),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    data.deductPoints == '0.00'
                        ? Text(
                            "YOU_RECEIVED".tr() +
                                ' ' +
                                data.points +
                                ' ' +
                                'POINTS'.tr(),
                            style: TextStyle(fontSize: 34.sp),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          )
                        : Text(
                            'YOU_USED'.tr() +
                                ' ' +
                                data.deductPoints +
                                ' ' +
                                'POINTS'.tr(),
                            style: TextStyle(fontSize: 34.sp),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                  ],
                ),
              )),
          Expanded(
            flex: 2,
            child: Container(
              margin: EdgeInsets.only(right: 10.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  data.deductPoints == '0.00'
                      ? Text(
                          ' +' + data.points,
                          style: TextStyle(
                              fontSize: 38.sp,
                              color: Constants.COLORS_FONT_TITLE,
                              fontWeight: FontWeight.bold),
                        )
                      : Text(
                          ' -' + data.deductPoints,
                          style: TextStyle(
                              fontSize: 38.sp,
                              color: Colors.red,
                              fontWeight: FontWeight.bold),
                        ),
                  Text(
                    data.date,
                    style: TextStyle(fontSize: 30.sp, color: Colors.grey),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
