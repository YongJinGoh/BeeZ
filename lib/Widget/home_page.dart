import 'dart:async';

import 'package:biz_sense/Model/booking_display_model.dart';
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
import '../Widget/merchant_sorting_bar.dart';
import '../Widget/merchant_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}
// TopBar();

class _HomePageState extends State<HomePage> {
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

  // Widget buildStuff(){
  //   return FutureBuilder<List<ObjectClass>>(
  //     future: fetchJson(), // api call method here, to fetch json/data
  //     builder: (context, snapshot) {
  //       if (snapshot.hasError) {
  //         return Container(); // widget to be shown on any error
  //       }
  //
  //       return snapshot.hasData
  //           ? _bodyBuild(data: snapshot.data)
  //           : Text("Loading"); // widget to be shown while data is being loaded from api call method
  //     },
  //   );
  // }

  getSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
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
                        Align(
                          alignment: Alignment.topRight,
                          child: Image.asset(
                            'assets/images/logo-beez-2.png',
                            width: 0.6.sw,
                            height: 240.h,
                            fit: BoxFit.fitWidth,
                          ),
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
                                        offset: Offset(
                                            0, 3), // changes position of shadow
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
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.only(left: 80.w),
                        child: Text(
                          'WHATS_NEW'.tr(),
                          style: TextStyle(
                              fontSize: 60.sp,
                              color: Constants.COLORS_PRIMARY_ORANGE_COLOR,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      width: 0.9.sw,
                      height: 320.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(14)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: CarouselSlider(
                        options: CarouselOptions(
                          height: 280.h,
                          autoPlay: true,
                        ),
                        items: [
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    'assets/images/car_stock_1.jpg',
                                  ),
                                  fit: BoxFit.cover),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(14)),
                            ),
                            margin: EdgeInsets.symmetric(horizontal: 20.w),
                            width: 280.w,
                            height: 280.h,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    'assets/images/car_stock_2.jpg',
                                  ),
                                  fit: BoxFit.cover),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(14)),
                            ),
                            margin: EdgeInsets.symmetric(horizontal: 20.w),
                            width: 360.w,
                            height: 360.h,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    'assets/images/car_stock_4.jpg',
                                  ),
                                  fit: BoxFit.cover),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(14)),
                            ),
                            margin: EdgeInsets.symmetric(horizontal: 20.w),
                            width: 360.w,
                            height: 360.h,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    'assets/images/car_stock_5.jpg',
                                  ),
                                  fit: BoxFit.cover),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(14)),
                            ),
                            margin: EdgeInsets.symmetric(horizontal: 20.w),
                            width: 360.w,
                            height: 360.h,
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.only(left: 40.w, top: 20.h),
                        child: Text(
                          "Popular Community",
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
          );
        }
        return SizedBox.expand(
          child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Container(
              child: Stack(children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          height: 360.h,
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
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 160.h),
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                  margin: EdgeInsets.all(15),
                                  width: 0.90.sw,
                                  height: 120.h,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
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
                                                    width: 80.w,
                                                    height: 80.h,
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
                                                            style: TextStyle(
                                                                fontSize:
                                                                    46.sp),
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
                                                            style: TextStyle(
                                                                fontSize:
                                                                    46.sp),
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
                                                      fontSize: 46.sp,
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
                        margin: EdgeInsets.only(left: 40.w, top: 30.h),
                        child: Text(
                          'WHATS_NEW'.tr(),
                          style: TextStyle(
                            fontSize: 48.sp,
                            color: Constants.COLORS_PRIMARY_ORANGE_COLOR,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      width: 0.95.sw,
                      height: 490.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(14)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            // offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          CarouselSlider(
                            carouselController: _carouselController,
                            options: CarouselOptions(
                                height: 408.h,
                                autoPlay: true,
                                autoPlayInterval: Duration(seconds: 10),
                                viewportFraction: 1,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _current = index;
                                  });
                                }
                                // enlargeCenterPage: true,
                                ),
                            items: imgList
                                .map((item) => GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    MerchantDetailsPage2(
                                                      merchantID: itemIdList[
                                                          imgList
                                                              .indexOf(item)],
                                                    )));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(14)),
                                        ),
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: CachedNetworkImage(
                                                imageUrl: item,
                                                fit: BoxFit.cover,
                                                width: 1.sw)),
                                      ),
                                    ))
                                .toList(),
                          ),
                          SizedBox(
                            height: 14.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: imgList.asMap().entries.map((entry) {
                              return GestureDetector(
                                onTap: () => _carouselController
                                    .animateToPage(entry.key),
                                child: Container(
                                  width: 12.w,
                                  height: 12.w,
                                  margin: EdgeInsets.symmetric(
                                      vertical: 0.h, horizontal: 4.w),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: (Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? Colors.white
                                              : Colors.grey)
                                          .withOpacity(_current == entry.key
                                              ? 0.9
                                              : 0.4)),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    MerchantSortingBar(
                      onTap: () => viewAll(),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    // Align(
                    //   alignment: Alignment.centerLeft,
                    //   child: Container(
                    //     margin: EdgeInsets.only(
                    //         left: 40.w, top: 40.h, bottom: 20.h),
                    //     child: Text(
                    //       'POPULAR_MERCHANT'.tr(),
                    //       style: TextStyle(
                    //         fontSize: 48.sp,
                    //         color: Constants.COLORS_PRIMARY_ORANGE_COLOR,
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    _isLoading
                        ? CircularProgressIndicator()
                        : _isError
                            ? Dialog(
                                child: Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Text('NO_INTERNET_CONNECTION'.tr()),
                                ),
                              )
                            : ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: lists.length,
                                itemBuilder: (BuildContext context, int index) {
                                  MerchantModel merchant = lists[index];
                                  return MerchantListItem(data: merchant);
                                },
                              )
                  ],
                ),
                //ifelse??
              ]),
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
        method: Constants.NETWORK_GET_VENDOR_LIST,
        header: requestHeaders,
        context: context);

    List<Merchant> merchants = [];

    if (returnData.code == 200) {
      returnData.data['sections'].forEach((mer) {
        mer['restorants'].forEach((res) {
          if (mer['title'] == "Food Courts") {
            String categoryName = '';
            try {
              mer['restorants'].forEach((cat) {
                categoryName = cat['name'];
              });
            } on Exception catch (e) {
              categoryName = '';
            }
            lists.add(MerchantModel.fromJson(res, true, categoryName));
          }
        });
        merchants.add(Merchant.fromJson(mer, lists));
      });
      rewardPoint = returnData.data['point_balance'].toString();
      _isLoading = false;
      _isError = false;
      // Iterable l = json.decode(hmmm.data['sections']['restorants']);
      // List<MerchantModel> posts =
    } else {
      _isLoading = false;
      _isError = true;
    }
    imgDataMain = returnData.data['ads_info']['img_main'].toString();
    imgIDMain = returnData.data['ads_info']['id_main'].toString();

    imgData = returnData.data['ads_info']['img'].toString();
    imgID = returnData.data['ads_info']['id'].toString();

    returnData.data['banner'].forEach((bannerItems) {
      imgList.add(bannerItems['img']);
      itemIdList.add(bannerItems['id'].toString());
    });

    bool displayAds = prefs.getBool(Constants.PREF_DISPLAY_ADS) ?? false;
    int? lastDay = prefs.getInt('lastDay');
    int today = DateTime.now().day;
    // if (lastDay == null || lastDay != today) {
    //   //Show the dialog
    //   showAdsDialog(imgData, imgID, context);
    //   prefs.setInt('lastDay', today);

    // } else {
    //   showAdsDialog(imgData, imgID, context);
    //   print('NOT inside today');
    // }

    if (imgData.isNotEmpty) {
      if (!displayAds) {
        showAdsDialog(imgDataMain, imgIDMain, context);
        prefs.setBool(Constants.PREF_DISPLAY_ADS, true);
      }
    }

    setState(() {});

    return lists;
  }

  viewAll() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => MerchantPage()));
  }

  showQRCode(String link, String id) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () {
              return Future.value(false);
            },
            child: SafeArea(
              child: Container(
                width: 1.sw,
                height: 1.sh,
                color: Colors.black.withOpacity(0.2),
                child: Center(
                  child: Column(children: [
                    SizedBox(
                      height: 0.3.sh,
                    ),
                    Container(
                        height: 0.7.sw,
                        width: 0.7.sw,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop(true);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => MerchantDetailsPage2(
                                      merchantID: id,
                                    )));
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl: link,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )),
                    SizedBox(
                      height: 40.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop(true);
                      },
                      child: Align(
                          alignment: Alignment.center,
                          child: Stack(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 15.w, horizontal: 15.w),
                                child: Icon(Icons.close,
                                    color: Constants.COLORS_PRIMARY_COLOR,
                                    size: 70.w),
                              ),
                              Icon(Icons.circle_outlined,
                                  color: Constants.COLORS_PRIMARY_COLOR,
                                  size: 100.w)
                            ],
                          )),
                    ),
                  ]),
                ),
              ),
            ),
          );
        });
  }

  showAdsDialog(String link, String id, BuildContext context) {
    Timer _timer;
    int _start = 4;

    void startTimer(StateSetter dialogState) {
      const oneSec = const Duration(seconds: 1, milliseconds: 200);
      _timer = new Timer.periodic(
        oneSec,
        (Timer timer) {
          if (_start == 0) {
            timer.cancel();
          } else {
            dialogState(() {
              _start--;
            });
          }
        },
      );
    }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          bool startedTimer = false;
          Future.delayed(
            Duration(seconds: 5),
            () {
              Navigator.of(context).pop(true);
              showQRCode(imgData, imgID);
            },
          );

          return StatefulBuilder(
              builder: (BuildContext context, StateSetter dialogState) {
            startTimer(dialogState);

            return SafeArea(
              child: Container(
                width: 1.sw,
                height: 1.sh,
                color: Colors.black.withOpacity(0.6),
                child: Stack(children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop(true);
                      showQRCode(imgData, imgID);
                    },
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 20.h),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          margin: EdgeInsets.only(bottom: 200.h),
                          child: Text(
                            'Skip in $_start',
                            style:
                                TextStyle(color: Colors.white, fontSize: 50.sp),
                          )),
                      // Icon(Icons.close, color: Colors.white, size: 30)
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0.2.sh),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Image.asset(
                        'assets/images/logo_27thcodes.png',
                        width: 150.w,
                        height: 200.h,
                        fit: BoxFit.cover,
                      ),
                      // assets/images/logo_27thcodes.png
                      // Icon(Icons.close, color: Colors.white, size: 30)
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                        height: 0.7.sh,
                        width: 0.8.sw,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop(true);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => MerchantDetailsPage2(
                                      merchantID: id,
                                    )));
                          },
                          child: Center(
                            child: CachedNetworkImage(
                              imageUrl: link,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )),
                  ),
                  // child: Text('X',style: TextStyle(color: Colors.white,fontSize: 70.sp),),),
                ]),
              ),
            );
          });
        });
  }
}
