import '../Model/merchant_details_model.dart';
import 'merchant_details_per_item_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Utils/constants.dart';

class MerchantDetailsListItem extends StatelessWidget {
  late MerchantDetails data;
  late String number;
  late String url;

  MerchantDetailsListItem(
      {required this.data, required this.number, required this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              top: 25.h,
              left: 30.w,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                data.title,
                style: TextStyle(
                    color: Constants.COLORS_PRIMARY_ORANGE_COLOR,
                    fontSize: 42.sp,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: data.lists.length,
            itemBuilder: (BuildContext context, int index) {
              MerchantDetailsModel merchant = data.lists[index];
              return MerchantDetailsPerItemList(
                data: merchant,
                merchantId: data.id,
                number: number,
                url: url,
              );
            },
          ),
        ],
      ),
    );
  }
}
