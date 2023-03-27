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

class DefaultPage extends StatefulWidget {
  late BookingDisplayData data;

  DefaultPage({required this.data});

  @override
  _DefaultPageState createState() => _DefaultPageState();
}

class _DefaultPageState extends State<DefaultPage> {
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
          return Scaffold(
            body: Container(
              color: Constants.COLORS_PRIMARY_COLOR,
              child: SafeArea(
                left: false,
                right: false,
                bottom: false,
                child: SizedBox.expand(
                  child: Container(
                    height: 1.sw,
                    color: Colors.white,
                    child: SingleChildScrollView(
                      physics: ScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          MainTitleBar(
                              title: 'COMMUNITY'.tr(),
                              action: () => Navigator.pop(context)),
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                            child: Center(
                              child: Text('data'),
                            ),
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
