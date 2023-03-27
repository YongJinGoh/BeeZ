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

class ViewEventPage extends StatefulWidget {
  late EventModel data;

  ViewEventPage({required this.data});

  @override
  _ViewEventPageState createState() => _ViewEventPageState();
}

class _ViewEventPageState extends State<ViewEventPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController icController = TextEditingController();

  String accPoints = '0';
  bool _isLoading = false;
  bool _isLogin = false;
  bool _isEmpty = false;
  bool _eventSelected = true;
  String userName = '';
  String userPhone = '';
  String userEmail = '';
  String userIc = '';
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
                              title: 'Event',
                              action: () => Navigator.pop(context)),
                          SizedBox(
                            height: 10.h,
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
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10.h, horizontal: 30.w),
                            width: 1.sw,
                            child: Text(
                              widget.data.eventDesc,
                              style: TextStyle(
                                  // color: Constants.COLORS_PRIMARY_ORANGE_COLOR,
                                  fontSize: 44.sp),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 30.w),
                            width: 1.sw,
                            child: Text(
                              'Registration date: ',
                              style: TextStyle(
                                  color: Constants.COLORS_PRIMARY_ORANGE_COLOR,
                                  fontSize: 46.sp),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 30.w),
                            width: 1.sw,
                            child: Text(widget.data.registerStartDate +
                                ' - ' +
                                widget.data.registerEndDate),
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
                          SizedBox(
                            height: 20.h,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: TextFormField(
                              style: TextStyle(fontSize: 50.sp),
                              controller: nameController,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                labelText: 'NAME'.tr(),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: TextFormField(
                              style: TextStyle(fontSize: 50.sp),
                              keyboardType: TextInputType.number,
                              controller: phoneController,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                labelText: 'PHONE'.tr(),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: TextFormField(
                              style: TextStyle(fontSize: 50.sp),
                              controller: emailController,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                labelText: 'EMAIL'.tr(),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: TextFormField(
                              style: TextStyle(fontSize: 50.sp),
                              keyboardType: TextInputType.number,
                              controller: icController,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                labelText: 'IC'.tr(),
                              ),
                            ),
                          ),
                          Expanded(child: Container()),
                          Container(
                            width: 0.8.sw,
                            child: ElevatedButton(
                              onPressed: () {
                                String fullName = nameController.value.text;
                                String phone = phoneController.value.text;
                                // String email = emailController.value.text;
                                // String icStr = icController.value.text;
                                attendEvent();
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Constants.COLORS_PRIMARY_COLOR,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                elevation: 15.0,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  'Attend Event',
                                  style: TextStyle(fontSize: 50.sp),
                                ),
                              ),
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

  String setUpQR() {
    String link = '{"event_id":' + widget.data.id + ',"user_id"' + userId + '}';

    return link;
  }

  getSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();

    userName = prefs.getString(Constants.PREF_NAME) ?? '';
    userPhone = prefs.getString(Constants.PREF_PHONE) ?? '';
    userId = prefs.getString(Constants.PREF_ID) ?? '';

    nameController = TextEditingController(text: userName);
    phoneController = TextEditingController(text: userPhone);
  }

  attendEvent() async {
    EasyLoading.show(status: 'loading...');

    Map<String, String> requestHeaders = {};

    String fullName = nameController.value.text;
    String phone = phoneController.value.text;
    // String email = emailController.value.text;
    // String icStr = icController.value.text;

    String eventID = widget.data.id;

    Map<String, String> bodyArg = {
      'name': fullName,
      'phone': phone,
      // 'email': email,
      // 'ic': icStr,
      'event_id': eventID
    };

    var returnData = await ApiCall().post(
        arg: bodyArg,
        method: Constants.NETWORK_POST_JOIN_EVENT,
        header: requestHeaders,
        context: context);

    if (returnData.code == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(returnData.message),
      ));

      Navigator.pop(context, true);
    } else {
      _isLoading = false;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(returnData.message),
      ));
    }

    EasyLoading.dismiss();
  }

  Future<List<EventModel>> getdatafromserver() async {
    EasyLoading.show(status: 'loading...');
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

    EasyLoading.dismiss();

    return attendLists;
  }
}
