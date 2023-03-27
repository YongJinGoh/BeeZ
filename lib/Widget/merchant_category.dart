import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Widget/merchant_category_grid.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

class MerchantCategory extends StatelessWidget {
  String selected;
  final void Function() onTap;

  MerchantCategory({
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(40)),
      ),
      child: Container(
        margin: EdgeInsets.all(10),
        child: IntrinsicHeight(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  MerchantCategoryGrid(
                    data: "F&B",
                    image: 'assets/images/appicon_f&b.png',
                    maxLine: 1,
                    fSize: 12,
                    onTap: () => search('fnb'),
                  ),
                  VerticalDivider(
                    width: 4,
                    thickness: 1,
                  ),
                  MerchantCategoryGrid(
                    data: "Auto",
                    image: 'assets/images/appicon_auto.png',
                    maxLine: 1,
                    fSize: 12,
                    onTap: () => search('auto'),
                  ),
                  VerticalDivider(
                    width: 4,
                    thickness: 1,
                  ),
                  MerchantCategoryGrid(
                    data: "Wellness",
                    image: 'assets/images/appicon_wellness.png',
                    maxLine: 1,
                    fSize: 12,
                    onTap: () => search('wellness'),
                  ),
                  VerticalDivider(
                    width: 4,
                    thickness: 1,
                  ),
                  MerchantCategoryGrid(
                    data: "Leisure",
                    image: 'assets/images/appicon_leisure.png',
                    maxLine: 1,
                    fSize: 12,
                    onTap: () => search('leisure'),
                  ),
                  VerticalDivider(
                    width: 4,
                    thickness: 1,
                  ),
                  MerchantCategoryGrid(
                    data: "Fashion",
                    image: 'assets/images/appicon_fashion.png',
                    maxLine: 1,
                    fSize: 12,
                    onTap: () => search('fashion'),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  MerchantCategoryGrid(
                    data: "IT",
                    image: 'assets/images/appicon_IT-2.png',
                    maxLine: 1,
                    fSize: 12,
                    onTap: () => search('it'),
                  ),
                  VerticalDivider(
                    width: 4,
                    thickness: 1,
                  ),
                  MerchantCategoryGrid(
                    data: "Grocery",
                    image: 'assets/images/appicon_grocery.png',
                    maxLine: 1,
                    fSize: 12,
                    onTap: () => search('grocery'),
                  ),
                  VerticalDivider(
                    width: 4,
                    thickness: 1,
                  ),
                  MerchantCategoryGrid(
                    data: "Stalls",
                    image: 'assets/images/appicon_stall.png',
                    maxLine: 1,
                    fSize: 12,
                    onTap: () => search('stalls'),
                  ),
                  VerticalDivider(
                    width: 4,
                    thickness: 1,
                  ),
                  MerchantCategoryGrid(
                    data: "Service",
                    image: 'assets/images/appicon_services.png',
                    maxLine: 1,
                    fSize: 12,
                    onTap: () => search('service'),
                  ),
                  VerticalDivider(
                    width: 4,
                    thickness: 1,
                  ),
                  MerchantCategoryGrid(
                    data: "Others",
                    image: 'assets/images/appicon_others.png',
                    maxLine: 1,
                    fSize: 12,
                    onTap: () => search('other'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  search(String sel) async {
    selected = sel;
    onTap();
  }
}
