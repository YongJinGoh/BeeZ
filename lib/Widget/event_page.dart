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

class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  String accPoints = '0';
  bool _isLoading = false;
  bool _isLogin = false;
  bool _isEmpty = false;
  bool _eventSelected = true;
  bool _ticketSelected = false;
  bool _attendSelected = false;

  late Future<List<EventModel>> _tasks;
  List<EventModel> eventLists = [];
  List<EventModel> attendLists = [];
  List<EventModel> joinLists = [];
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    setState(() {
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
                              title: 'EVENT'.tr(),
                              action: () => Navigator.pop(context)),
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                            key: UniqueKey(),
                            height: 130.h,
                            width: 1.sw,
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
                                        _eventSelected = true;
                                        _ticketSelected = false;
                                        _attendSelected = false;
                                      });
                                    }),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Event',
                                          style: TextStyle(
                                              fontSize: 44.sp,
                                              color: Constants
                                                  .COLORS_PRIMARY_COLOR),
                                        ),
                                        SizedBox(
                                          height: 8.h,
                                        ),
                                        _eventSelected
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
                                        _eventSelected = false;
                                        _ticketSelected = true;
                                        _attendSelected = false;
                                      });
                                    }),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Ticket',
                                          style: TextStyle(
                                              fontSize: 44.sp,
                                              color: Constants
                                                  .COLORS_PRIMARY_COLOR),
                                        ),
                                        SizedBox(
                                          height: 8.h,
                                        ),
                                        _ticketSelected
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
                                        _eventSelected = false;
                                        _ticketSelected = false;
                                        _attendSelected = true;
                                      });
                                    }),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Attended',
                                          style: TextStyle(
                                              fontSize: 44.sp,
                                              color: Constants
                                                  .COLORS_PRIMARY_COLOR),
                                        ),
                                        SizedBox(
                                          height: 8.h,
                                        ),
                                        _attendSelected
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
                                ]),
                          ),
                          _eventSelected
                              ? eventLists.length == 0
                                  ? Text('No event at the moment')
                                  : ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: eventLists.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        EventModel communityMerchant =
                                            eventLists[index];
                                        return EventListItem(
                                          data: communityMerchant,
                                          onTap: () => updatePage(),
                                        );
                                      },
                                    )
                              : Container(),
                          _ticketSelected
                              ? joinLists.length == 0
                                  ? Text('No ticket at the moment')
                                  : ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: joinLists.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        EventModel communityMerchant =
                                            joinLists[index];
                                        return EventAttendListItem(
                                          data: communityMerchant,
                                        );
                                      },
                                    )
                              : Container(),
                          _attendSelected
                              ? attendLists.length == 0
                                  ? Text('No attending event at the moment')
                                  : ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: attendLists.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        EventModel communityMerchant =
                                            attendLists[index];
                                        return EventAttendListItem(
                                          data: communityMerchant,
                                        );
                                      },
                                    )
                              : Container()

                          // _eventSelected
                          //     ? eventLists.length == 0
                          //         ? Text('No event at the moment')
                          //         : ListView.builder(
                          //             physics: NeverScrollableScrollPhysics(),
                          //             shrinkWrap: true,
                          //             itemCount: eventLists.length,
                          //             itemBuilder:
                          //                 (BuildContext context, int index) {
                          //               EventModel communityMerchant =
                          //                   eventLists[index];
                          //               return EventListItem(
                          //                 data: communityMerchant,
                          //                 onTap: () => updatePage(),
                          //               );
                          //             },
                          //           )
                          //     : attendLists.length == 0
                          //         ? Text('No attending event at the moment')
                          //         : ListView.builder(
                          //             physics: NeverScrollableScrollPhysics(),
                          //             shrinkWrap: true,
                          //             itemCount: attendLists.length,
                          //             itemBuilder:
                          //                 (BuildContext context, int index) {
                          //               EventModel communityMerchant =
                          //                   attendLists[index];
                          //               return EventAttendListItem(
                          //                   data: communityMerchant);
                          //             },
                          //           ),
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

  updatePage() async {
    EasyLoading.show(status: 'loading...');
    // prefs = await SharedPreferences.getInstance();
    // _isLogin = prefs.getBool(Constants.PREF_LOGIN) ?? false;

    // if (_isLogin) {
    Map<String, String> requestHeaders = {};

    Map<String, String> arg = {};

    var responseData = await ApiCall().get(
        arg: arg,
        method: Constants.NETWORK_GET_EVENT_LIST,
        header: requestHeaders,
        context: context);

    attendLists = [];
    eventLists = [];

    if (responseData.code == 200) {
      responseData.data['eventList'].forEach((res) {
        eventLists.add(EventModel.fromJson(res));
      });
      responseData.data['joinList'].forEach((voucherData) {
        joinLists.add(EventModel.fromJson(voucherData));
      });
      responseData.data['attendList'].forEach((voucherData) {
        attendLists.add(EventModel.fromJson(voucherData));
      });
    }

    setState(() {});
    EasyLoading.dismiss();

    return attendLists;
  }

  getSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<List<EventModel>> getdatafromserver() async {
    EasyLoading.show(status: 'loading...');
    // prefs = await SharedPreferences.getInstance();
    // _isLogin = prefs.getBool(Constants.PREF_LOGIN) ?? false;

    // if (_isLogin) {
    Map<String, String> requestHeaders = {};

    Map<String, String> arg = {};

    var responseData = await ApiCall().get(
        arg: arg,
        method: Constants.NETWORK_GET_EVENT_LIST,
        header: requestHeaders,
        context: context);

    attendLists = [];
    eventLists = [];

    if (responseData.code == 200) {
      responseData.data['eventList'].forEach((res) {
        eventLists.add(EventModel.fromJson(res));
      });
      responseData.data['joinList'].forEach((voucherData) {
        joinLists.add(EventModel.fromJson(voucherData));
      });
      responseData.data['attendList'].forEach((voucherData) {
        attendLists.add(EventModel.fromJson(voucherData));
      });
    }

    EasyLoading.dismiss();

    return attendLists;
  }
}
