import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import '../Utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Widget/api_calling.dart';
import '../Widget/merchant_list_item.dart';
import '../Model/merchant_model.dart';
import '../Utils/constants.dart';
import '../Widget/login_page.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'merchant_details_page_2.dart';
import '../Widget/merchant_fc_list_item.dart';

class MerchantFCListPage extends StatefulWidget {
  late MerchantModel merchantData;
  late String data;
  late String title;

  MerchantFCListPage(
      {required this.merchantData, required this.data, required this.title});

  @override
  _MerchantFCListPageState createState() => new _MerchantFCListPageState();
}
// TopBar();

class _MerchantFCListPageState extends State<MerchantFCListPage> {
  int _counter = 0;
  int initialSeconds = 3;
  Timer? _everySecond;
  String? _now;
  StateSetter? outerState;

  List<String> imgList = [];
  List<String> itemIdList = [];

  String imgDataMain = '';
  String imgIDMain = '';

  String imgData = '';
  String imgID = '';

  int _current = 0;
  final CarouselController _carouselController = CarouselController();
  late Future<List<MerchantModel>> _tasks;
  List<MerchantModel> lists = [];
  late SharedPreferences prefs;

  bool _isLoading = false;
  bool _isError = false;
  bool _isLogin = false;
  bool _showAds = true;
  String name = '';
  String rewardPoint = '0';

  @override
  void initState() {
    super.initState();
    setState(() {
      _tasks = getdatafromserver();
    });
  }

  getSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting &&
            snapshot.hasData == null) {
          return Scaffold(
            body: SizedBox.expand(
              child: SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Container(
                            height: 400.h,
                            decoration: BoxDecoration(
                              color: Constants.COLORS_PRIMARY_COLOR,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(40),
                                bottomRight: Radius.circular(40),
                              ),
                            ),
                          ),
                          // Padding(
                          //   padding: EdgeInsets.only(top: 55.h),
                          //   child: Text(
                          //     "27th Codes",
                          //     style: TextStyle(color: Colors.white, fontSize: 20),
                          //   ),
                          // ),
                          Image.asset(
                            'assets/images/logo-beez-2.png',
                            width: 0.6.sw,
                            height: 240.h,
                            fit: BoxFit.fitWidth,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 300.h),
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                    margin: EdgeInsets.all(15),
                                    width: 0.9.sw,
                                    height: 60.h,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            flex: 4,
                                            child: Row(
                                              children: [
                                                Container(
                                                    child: GestureDetector(
                                                        child: Image.asset(
                                                      'assets/images/appicon_profile.png',
                                                      width: 90.w,
                                                      height: 90.h,
                                                    )),
                                                    margin: EdgeInsets.only(
                                                        left: 10)),
                                                _isLogin
                                                    ? Flexible(
                                                        child: Container(
                                                            child: Text(
                                                              name,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 8)))
                                                    : Flexible(
                                                        child: Container(
                                                            child: Text(
                                                              name,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 8)))
                                              ],
                                            )),
                                        Expanded(
                                            flex: 2,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Container(
                                                    child: GestureDetector(
                                                        child: Image.asset(
                                                      'assets/images/appicon_27thcoin.png',
                                                      width: 70.w,
                                                      height: 70.h,
                                                    )),
                                                    margin: EdgeInsets.only(
                                                        right: 5)),
                                                Container(
                                                  child: Text(
                                                    rewardPoint,
                                                    style: TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                  margin:
                                                      EdgeInsets.only(right: 8),
                                                  alignment:
                                                      Alignment.centerRight,
                                                ),
                                              ],
                                            ))
                                      ],
                                    )),
                              )
                            ],
                          )
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.only(left: 40.w, top: 20.h),
                          child: Text(
                            widget.title,
                            style: TextStyle(
                                fontSize: 50.sp,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        return Scaffold(
          body: Container(
            color: Constants.COLORS_PRIMARY_COLOR,
            child: SafeArea(
              left: false,
              right: false,
              bottom: false,
              child: SizedBox.expand(
                child: Container(
                  color: Colors.white,
                  child: SingleChildScrollView(
                    physics: ScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Container(
                              height: 220.h,
                              decoration: BoxDecoration(
                                color: Constants.COLORS_PRIMARY_COLOR,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(40),
                                  bottomRight: Radius.circular(40),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20.h, horizontal: 30.w),
                              width: 0.7.sw,
                              height: 200.h,
                              child: Image.asset(
                                'assets/images/logo-beez-2.png',
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                            Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 30.w, vertical: 30.h),
                                  child:
                                      // ElevatedButton(
                                      //   onPressed: () => Navigator.pop(context),
                                      //   child: Icon(Icons.arrow_back,
                                      //       color: Colors.white),
                                      //   style: ElevatedButton.styleFrom(
                                      //     shape: CircleBorder(),
                                      //     primary:
                                      //         Colors.black45, // <-- Button color
                                      //   ),
                                      // ),
                                      GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Image.asset(
                                      'assets/images/appicon_back.png',
                                      height: 60.w,
                                      width: 60.w,
                                    ),
                                  ),
                                )),
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(
                                left: 40.w, top: 40.h, bottom: 20.h),
                            child: widget.merchantData.category.length == 0
                                ? Text(
                                    'Community',
                                    style: TextStyle(
                                      fontSize: 48.sp,
                                      color:
                                          Constants.COLORS_PRIMARY_ORANGE_COLOR,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : Text(
                                    'Community',
                                    style: TextStyle(
                                      fontSize: 48.sp,
                                      color:
                                          Constants.COLORS_PRIMARY_ORANGE_COLOR,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),
                        _isLoading
                            ? CircularProgressIndicator()
                            : _isError
                                ? Dialog(
                                    child: Padding(
                                      padding: EdgeInsets.all(20),
                                      child:
                                          Text('NO_INTERNET_CONNECTION'.tr()),
                                    ),
                                  )
                                : ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: lists.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      MerchantModel merchant = lists[index];
                                      return MerchantFcListItem(data: merchant);
                                    },
                                  ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
      future: _tasks,
    );
  }

  Future<List<MerchantModel>> getdatafromserver() async {
    _isLoading = true;
    prefs = await SharedPreferences.getInstance();
    lists = [];

    name = prefs.getString(Constants.PREF_NAME) ?? '';
    _isLogin = prefs.getBool(Constants.PREF_LOGIN) ?? false;

    Map<String, String> requestHeaders = {};
// Map<String, String> requestHeaders = {};

    var returnData = await ApiCall().get(
        arg: requestHeaders,
        method: Constants.NETWORK_GET_VENDOR_FC_LIST + 'id=' + widget.data,
        header: requestHeaders,
        context: context);

    List<Merchant> merchants = [];
    lists.add(widget.merchantData);
    if (returnData.code == 200) {
      returnData.data.forEach((mer) {
        mer['restorants'].forEach((res) {
          lists.add(MerchantModel.fromJson(res, false, ''));
        });
        merchants.add(Merchant.fromJson(mer, lists));
      });
      _isLoading = false;
      _isError = false;
      // Iterable l = json.decode(hmmm.data['sections']['restorants']);
      // List<MerchantModel> posts =
    } else {
      _isLoading = false;
      _isError = true;
    }

    setState(() {});

    return lists;
  }
}
