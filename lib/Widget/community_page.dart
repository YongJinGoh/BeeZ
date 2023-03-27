import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Utils/constants.dart';
import '../Model/merchant_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';
import 'api_calling.dart';
import 'community_list_item.dart';
import '../Widget/main_title_bar.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class CommunityPage extends StatefulWidget {
  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  String accPoints = '0';
  bool _isLoading = false;
  bool _isLogin = false;
  bool _isEmpty = false;
  bool _rewardSelected = true;

  late Future<List<MerchantModel>> _tasks;
  List<MerchantModel> lists = [];
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
                          ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: lists.length,
                            itemBuilder: (BuildContext context, int index) {
                              MerchantModel communityMerchant = lists[index];
                              return CommunityListItem(data: communityMerchant);
                            },
                          )
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

  Future<List<MerchantModel>> getdatafromserver() async {
    EasyLoading.show(status: 'loading...');
    // prefs = await SharedPreferences.getInstance();
    // _isLogin = prefs.getBool(Constants.PREF_LOGIN) ?? false;

    // if (_isLogin) {
    Map<String, String> requestHeaders = {};

    Map<String, String> arg = {};

    var responseData = await ApiCall().get(
        arg: arg,
        method: Constants.NETWORK_GET_FOLLOW_LIST,
        header: requestHeaders,
        context: context);

    lists = [];
    print(responseData);
    if (responseData.code == 200) {
      responseData.data['followList'].forEach((res) {
        lists.add(MerchantModel.fromJson(res, false, ''));
      });
    }
    EasyLoading.dismiss();
    return lists;
  }
}
