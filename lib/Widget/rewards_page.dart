import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Utils/constants.dart';
import '../Widget/api_calling.dart';
import '../Model/reward_model.dart';
import '../Widget/reward_balance_bar.dart';
import '../Widget/rewards_list_item.dart';
import '../Widget/voucher_list_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';

class RewardsPage extends StatefulWidget {
  @override
  _RewardsPageState createState() => _RewardsPageState();
}

class _RewardsPageState extends State<RewardsPage> {
  String accPoints = '0';
  bool _isLoading = false;
  bool _isLogin = false;
  bool _isEmpty = false;

  bool _rewardSelected = true;
  bool _voucherSelected = false;
  bool _couponSelected = false;

  late Future<List<RewardModel>> _tasks;
  List<RewardModel> lists = [];
  List<VoucherModel> voucherList = [];
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
                              height: 360.h,
                              color: Constants.COLORS_PRIMARY_COLOR,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 40.h),
                              child: Text(
                                "Rewards",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(height: 20.h),
                                  RewardsBalanceBar(
                                    accPoints: accPoints,
                                  ),
                                ]),
                            Container(
                              height: 40.h,
                              width: 1.sw,
                              margin: EdgeInsets.only(top: 100.h),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
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
                              'REWARDS'.tr(),
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
                              ]),
                          Container(
                            height: 130.h,
                            width: 1.sw,
                            margin: EdgeInsets.only(top: 370.h),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40)),
                            ),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: (() {
                                      setState(() {
                                        _rewardSelected = true;
                                        _voucherSelected = false;
                                        _couponSelected = false;
                                      });
                                    }),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Reward',
                                          style: TextStyle(
                                              fontSize: 44.sp,
                                              color: Constants
                                                  .COLORS_PRIMARY_COLOR),
                                        ),
                                        SizedBox(
                                          height: 8.h,
                                        ),
                                        _rewardSelected
                                            ? Container(
                                                color: Constants
                                                    .COLORS_PRIMARY_COLOR,
                                                width: 0.3.sw,
                                                height: 6.h,
                                              )
                                            : Container(
                                                color: Colors.white,
                                                width: 0.3.sw,
                                                height: 6.h,
                                              ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: (() {
                                      setState(() {
                                        _rewardSelected = false;
                                        _voucherSelected = true;
                                        _couponSelected = false;
                                      });
                                    }),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Voucher',
                                          style: TextStyle(
                                              fontSize: 44.sp,
                                              color: Constants
                                                  .COLORS_PRIMARY_COLOR),
                                        ),
                                        SizedBox(
                                          height: 8.h,
                                        ),
                                        _voucherSelected
                                            ? Container(
                                                color: Constants
                                                    .COLORS_PRIMARY_COLOR,
                                                width: 0.3.sw,
                                                height: 6.h,
                                              )
                                            : Container(
                                                color: Colors.white,
                                                width: 0.3.sw,
                                                height: 6.h,
                                              ),
                                      ],
                                    ),
                                  ),
                                  // GestureDetector(
                                  //   onTap: (() {
                                  //     setState(() {
                                  //       _rewardSelected = false;
                                  //       _voucherSelected = false;
                                  //       _couponSelected = true;
                                  //     });
                                  //   }),
                                  //   child: Column(
                                  //     mainAxisAlignment:
                                  //         MainAxisAlignment.center,
                                  //     children: [
                                  //       Text(
                                  //         'Coupon',
                                  //         style: TextStyle(
                                  //             fontSize: 44.sp,
                                  //             color: Constants
                                  //                 .COLORS_PRIMARY_COLOR),
                                  //       ),
                                  //       SizedBox(
                                  //         height: 8.h,
                                  //       ),
                                  //       _couponSelected
                                  //           ? Container(
                                  //               color: Constants
                                  //                   .COLORS_PRIMARY_COLOR,
                                  //               width: 0.3.sw,
                                  //               height: 6.h,
                                  //             )
                                  //           : Container(
                                  //               color: Colors.white,
                                  //               width: 0.3.sw,
                                  //               height: 6.h,
                                  //             ),
                                  //     ],
                                  //   ),
                                  // ),
                                ]),
                          ),
                          _isLoading
                              ? Container(
                                  margin: EdgeInsets.only(top: 440.h),
                                  child: CircularProgressIndicator(),
                                )
                              : _isEmpty
                                  ? Container(
                                      margin: EdgeInsets.only(top: 0.5.sh),
                                      child: Text(
                                        'NO_REWARD_MOMENT'.tr(),
                                        style: TextStyle(fontSize: 44.sp),
                                      ),
                                    )
                                  : _rewardSelected
                                      ? Container(
                                          margin: EdgeInsets.only(
                                              top: 460.h, bottom: 40.h),
                                          child: ListView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: lists.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              RewardModel model = lists[index];
                                              return RewardsListItem(
                                                data: model,
                                              );
                                            },
                                          ),
                                        )
                                      : _voucherSelected
                                          ? Container(
                                              margin: EdgeInsets.only(
                                                  top: 460.h, bottom: 40.h),
                                              child: ListView.builder(
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: voucherList.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  VoucherModel model =
                                                      voucherList[index];
                                                  return VoucherListItem(
                                                    data: model,
                                                  );
                                                },
                                              ),
                                            )
                                          : Container(
                                              margin: EdgeInsets.only(
                                                  top: 460.h, bottom: 40.h),
                                              child: ListView.builder(
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: voucherList.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  VoucherModel model =
                                                      voucherList[index];
                                                  return VoucherListItem(
                                                    data: model,
                                                  );
                                                },
                                              ),
                                            )
                        ],
                      ),
                    ],
                  )),
            ),
          );
        },
        future: _tasks);
  }

  getSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<List<RewardModel>> getdatafromserver() async {
    _isLoading = true;

    prefs = await SharedPreferences.getInstance();
    _isLogin = prefs.getBool(Constants.PREF_LOGIN) ?? false;

    if (_isLogin) {
      Map<String, String> requestHeaders = {};

      Map<String, String> arg = {};

      var responseData = await ApiCall().get(
          arg: arg,
          method: Constants.NETWORK_GET_REWARD,
          header: requestHeaders,
          context: context);

      lists = [];
      List<RewardModel> rewards = [];
      if (responseData.code == 200) {
        _isLoading = false;
        responseData.data['reward_list'].forEach((res) {
          lists.add(RewardModel.fromJson(res));
        });

        responseData.data['voucher_list'].forEach((voucherData) {
          print(voucherData);
          voucherList.add(VoucherModel.fromJson(voucherData));
        });

        accPoints = responseData.data['current'].toString();
        if (lists.length == 0 && voucherList.length == 0) {
          _isEmpty = true;
        } else {
          _isEmpty = false;
        }
      } else {}

      setState(() {
        lists = lists;
      });
    } else {
      setState(() {
        lists = lists;
        _isLoading = false;
      });
    }
    return lists;
  }
}
