import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Utils/constants.dart';
import '../Model/booking_display_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';
import 'api_calling.dart';
import 'booking_list_item.dart';
import '../Widget/main_title_bar.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../Widget/reward_balance_bar.dart';

class WalletPage extends StatefulWidget {
  late BookingDisplayData data;

  // WalletPage({required this.data});

  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  String accPoints = '0';
  bool _isLoading = false;
  bool _isLogin = false;
  bool _isEmpty = false;
  bool _rewardSelected = true;

  late Future<List<BookingDisplayData>> _tasks;
  List<BookingDisplayData> lists = [];
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    setState(() {
      _tasks = getdatafromserver();
    });
    // setState(() {
    //   getdatafromserver();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting &&
              snapshot.hasData == null) {
            return SizedBox.expand(
              child: SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Container(),
              ),
            );
          }
          return SizedBox.expand(
            child: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          height: 440.h,
                          color: Constants.COLORS_PRIMARY_COLOR,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 60.h),
                          child: Text(
                            'Wallet',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 66.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 180.h),
                            RewardsBalanceBar(
                              accPoints: accPoints,
                            ),
                          ],
                        ),
                        Container(
                          height: 130.h,
                          width: 1.sw,
                          margin: EdgeInsets.only(top: 370.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                          ),
                        ),
                      ],
                    ),
                    Text('Coming soon'),
                  ],
                ),
              ),
            ),
          );
        },
        future: _tasks);
  }

  getSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<List<BookingDisplayData>> getdatafromserver() async {
    // _isLoading = true;
    // EasyLoading.show(status: 'loading...');
    // prefs = await SharedPreferences.getInstance();
    // _isLogin = prefs.getBool(Constants.PREF_LOGIN) ?? false;

    // if (_isLogin) {
    //   Map<String, String> requestHeaders = {};

    //   Map<String, String> arg = {};

    //   var responseData = await ApiCall().get(
    //       arg: arg,
    //       method: Constants.NETWORK_GET_BOOKING_LIST,
    //       header: requestHeaders,
    //       context: context);

    //   lists = [];
    //   List<BookingDisplayData> rewards = [];
    //   print(responseData);
    //   if (responseData.code == 200) {
    //     _isLoading = false;

    //     responseData.data['bookingList'].forEach((res) {
    //       lists.add(BookingDisplayData.fromJson(res));
    //     });

    //     // responseData.data['voucher_list'].forEach((voucherData) {
    //     //   print(voucherData);
    //     //   voucherList.add(VoucherModel.fromJson(voucherData));
    //     // });

    //     // accPoints = responseData.data['current'].toString();
    //     // if (lists.length == 0 && voucherList.length == 0) {
    //     //   _isEmpty = true;
    //     // } else {
    //     //   _isEmpty = false;
    //     // }
    //   } else {}

    //   setState(() {
    //     lists = lists;
    //   });
    // } else {
    //   setState(() {
    //     lists = lists;
    //     _isLoading = false;
    //   });
    // }
    // EasyLoading.dismiss();
    return lists;
  }
}
