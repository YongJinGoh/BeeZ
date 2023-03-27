import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'merchant_details_toolbar_item.dart';
import 'merchant_middle_toolbar.dart';
import 'merchant_middle_double_toolbar.dart';
import 'merchant_opening_hour_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Widget/merchant_booking_page.dart';
import '../Model/merchant_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../Widget/main_title_bar.dart';
import '../Utils/constants.dart';

class MerchantLeaveReviewPage extends StatefulWidget {
  late MerchantModel data;

  MerchantLeaveReviewPage({required this.data});

  @override
  _MerchantLeaveReviewState createState() => _MerchantLeaveReviewState();
}

class _MerchantLeaveReviewState extends State<MerchantLeaveReviewPage> {
  late SharedPreferences prefs;
  String name = '';
  double finalRating = 0;

  TextEditingController _remarkController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  getSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    name = prefs.getString(Constants.PREF_NAME) ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getName(),
        builder: (context, snapshot) {
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
                            title: 'Leave Review',
                            action: () => Navigator.pop(context)),
                        SizedBox(
                          height: 10.h,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          width: 1.sw,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10.h),
                              Align(
                                alignment: Alignment.center,
                                child: Text(widget.data.name,
                                    style: TextStyle(
                                      color: Colors.blue[900],
                                      fontSize: 50.sp,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                              SizedBox(height: 10.h),
                              Container(
                                margin: EdgeInsets.only(left: 10.w),
                                child: Text(name,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 46.sp,
                                    )),
                              ),
                              SizedBox(height: 10.h),
                              RatingBar.builder(
                                // ignoreGestures: true,
                                itemSize: 30,
                                initialRating: 0,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: false,
                                itemCount: 5,
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  finalRating = rating;
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Container(
                          margin: EdgeInsets.all(4),
                          child: TextField(
                            controller: _remarkController,
                            minLines: 6,
                            keyboardType: TextInputType.multiline,
                            maxLines: 10,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey.shade300, width: 1),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey.shade300, width: 1),
                              ),
                              hintStyle: TextStyle(fontSize: 46.sp),
                              hintText: 'Share your feedback here....',
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            getRatingDetails();
                          },
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: Colors.blue[200],
                          ),
                          child: Container(
                            child: Text(
                              'Leave review',
                              style: TextStyle(fontSize: 46.sp),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          ));
        });
  }

  getRatingDetails() {
    print(finalRating);
    print(_remarkController.value.text);
  }

  getName() async {
    prefs = await SharedPreferences.getInstance();
    name = prefs.getString(Constants.PREF_NAME) ?? '';
  }
}
