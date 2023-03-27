import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'merchant_details_toolbar_item.dart';
import 'merchant_middle_toolbar.dart';
import 'merchant_middle_double_toolbar.dart';
import 'merchant_opening_hour_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Widget/merchant_booking_page.dart';
import '../Model/merchant_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../Widget/main_title_bar.dart';
import 'merchant_leave_review_page.dart';

class MerchantRatingPage extends StatefulWidget {
  late MerchantModel data;

  MerchantRatingPage({required this.data});

  @override
  _MerchantRatingState createState() => _MerchantRatingState();
}

class _MerchantRatingState extends State<MerchantRatingPage> {
  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SizedBox.expand(
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                children: [
                  MainTitleBar(
                      title: 'Rating', action: () => Navigator.pop(context)),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    width: 1.sw,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.data.name,
                            style: TextStyle(
                              color: Colors.blue[900],
                              fontSize: 50.sp,
                              fontWeight: FontWeight.bold,
                            )),
                        SizedBox(height: 25.h),
                        Container(
                          width: 1.sw,
                          child: Text(
                            widget.data.address,
                            overflow: TextOverflow.visible,
                            maxLines: 2,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 40.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) =>
                              MerchantLeaveReviewPage(data: widget.data)));
                    },
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.black38,
                    ),
                    child: Container(
                      child: Text(
                        'Write a review',
                        style: TextStyle(
                          fontSize: 40.sp,
                        ),
                      ),
                    ),
                  ),
                  Text('EMPTY LIST'),
                ],
              )),
        ),
      ),
    ));
  }
}
