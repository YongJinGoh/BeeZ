import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Utils/constants.dart';
import '../Model/event_data_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';
import 'api_calling.dart';
import 'event_list_item.dart';
import 'event_attend_list_item.dart';
import '../Widget/main_title_bar.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AttendEventPage extends StatefulWidget {
  late EventModel data;
  late String qrString;
  AttendEventPage({required this.data, required this.qrString});

  @override
  _AttendEventPageState createState() => _AttendEventPageState();
}

class _AttendEventPageState extends State<AttendEventPage> {
  String accPoints = '0';
  bool _isLoading = false;
  bool _isLogin = false;
  bool _isEmpty = false;
  bool _eventSelected = true;
  String userId = '';

  late Future<List<EventModel>> _tasks;
  List<EventModel> eventLists = [];
  List<EventModel> attendLists = [];
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    setState(() {
      getSharedPreferences();
      _tasks = getdatafromserver();
    });
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
                child: Container(
                  height: 1.sh,
                  width: 1.sw,
                  color: Colors.white,
                  child: SingleChildScrollView(
                    physics: ScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: 0.95.sh),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          MainTitleBar(
                              title: 'Attending event',
                              action: () => Navigator.pop(context)),
                          SizedBox(
                            height: 30.h,
                          ),
                          QrImage(
                            data: widget.data.eventCode,
                            version: QrVersions.auto,
                            gapless: false,
                            size: 200,
                          ),
                          SizedBox(
                            height: 40.h,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 30.w),
                            width: 1.sw,
                            child: Text(
                              widget.data.eventName,
                              style: TextStyle(
                                  color: Constants.COLORS_PRIMARY_ORANGE_COLOR,
                                  fontSize: 54.sp),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 30.w),
                            width: 1.sw,
                            child: Text(
                              'by. ' + widget.data.restaurantName,
                              style: TextStyle(
                                  // color: Constants.COLORS_PRIMARY_ORANGE_COLOR,
                                  fontSize: 36.sp),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 30.w),
                            width: 1.sw,
                            child: Text(
                              'Event date: ',
                              style: TextStyle(
                                  color: Constants.COLORS_PRIMARY_ORANGE_COLOR,
                                  fontSize: 46.sp),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 30.w),
                            width: 1.sw,
                            child: Text(widget.data.eventStartDate +
                                ' - ' +
                                widget.data.eventEndDate),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 30.w),
                            width: 1.sw,
                            child: Text(
                              'Time: ',
                              style: TextStyle(
                                  color: Constants.COLORS_PRIMARY_ORANGE_COLOR,
                                  fontSize: 46.sp),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 30.w),
                            width: 1.sw,
                            child: Text(widget.data.eventStartTime +
                                ' - ' +
                                widget.data.eventEndTime),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 30.w),
                            width: 1.sw,
                            child: Text(
                              'Status: ',
                              style: TextStyle(
                                  color: Constants.COLORS_PRIMARY_ORANGE_COLOR,
                                  fontSize: 46.sp),
                            ),
                          ),
                          widget.data.active == '1'
                              ? Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 30.w),
                                  width: 1.sw,
                                  child: Text(
                                    'Active',
                                    style: TextStyle(
                                        color: Colors.green, fontSize: 46.sp),
                                  ),
                                )
                              : Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 30.w),
                                  width: 1.sw,
                                  child: Text(
                                    'Inactive',
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 46.sp),
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
    userId = prefs.getString(Constants.PREF_ID) ?? '';
  }

  Future<List<EventModel>> getdatafromserver() async {
    print('status');
    print(widget.data.active);
    if (widget.data.active == '1') {
      print('inside 1');
    } else {
      print('nt inside 1');
    }
    // EasyLoading.show(status: 'loading...');
    // prefs = await SharedPreferences.getInstance();
    // _isLogin = prefs.getBool(Constants.PREF_LOGIN) ?? false;

    // if (_isLogin) {
    // Map<String, String> requestHeaders = {};

    // Map<String, String> arg = {};

    // var responseData = await ApiCall().get(
    //     arg: arg,
    //     method: Constants.NETWORK_GET_EVENT_LIST,
    //     header: requestHeaders,
    //     context: context);

    // attendLists = [];
    // eventLists = [];

    // if (responseData.code == 200) {
    //   responseData.data['eventList'].forEach((res) {
    //     eventLists.add(EventModel.fromJson(res));
    //   });

    //   responseData.data['attendList'].forEach((voucherData) {
    //     attendLists.add(EventModel.fromJson(voucherData));
    //   });
    // }

    // EasyLoading.dismiss();

    return attendLists;
  }
}
