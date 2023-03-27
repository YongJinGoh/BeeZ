import 'package:intl/intl.dart';
import '../Utils/constants.dart';
import '../Widget/api_calling.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Model/merchant_model.dart';
import '../Widget/main_title_bar.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import '../Model/merchant_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';
import '../Model/booking_data_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class MerchantBookingPage extends StatefulWidget {
  late String merchantId;
  late String itemId;
  late String name;
  late String desc;
  late String price;
  late String photo;

  MerchantBookingPage(
      {required this.merchantId,
      required this.itemId,
      required this.name,
      required this.desc,
      required this.price,
      required this.photo});

  @override
  _MerchantBookingPageState createState() => _MerchantBookingPageState();
}

enum BookingTime { today, nextDay }

class _MerchantBookingPageState extends State<MerchantBookingPage> {
  late Future<List<String>> _tasks;
  List<String> itemLists = [];

  String selectedSlot = '';
  // List<String> listBookingTime = [
  //   "10:00",
  //   "11:00",
  //   "12:00",
  //   "13:00",
  //   "14:00",
  //   "15:00",
  //   "16:00",
  //   "17:00",
  //   "18:00",
  //   "19:00",
  //   "20:00",
  //   "21:00",
  //   "22:00"
  // ];
  List<String> listBookingTime = [];
  List<BookingData> listBookingData = [];

  int _itemCount = 1;

  String formattedDate = "";
  String formattedTime = "";

  BookingTime? _days = BookingTime.today;
  TextEditingController _controller = TextEditingController();
  TextEditingController _remarkController = TextEditingController();

  List<MerchantModel> lists = [];
  bool _isLoading = false;
  bool _isError = false;
  bool _isPriceEmpty = false;

  bool _isBookingAvailable = false;
  bool _isMondayAvailable = false;
  bool _isTuesdayAvailable = false;
  bool _isWednesdayAvailable = false;
  bool _isThursdayAvailable = false;
  bool _isFridayAvailable = false;
  bool _isSaturdayAvailable = false;
  bool _isSundayAvailable = false;

  @override
  void initState() {
    super.initState();

    setState(() {
      getCurrentDate();
      getCurrentTime();
      _tasks = getdatafromserver();
    });

    if (widget.photo.isNotEmpty) {
      _isPriceEmpty = true;
    }
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
            return Container();
          }
          return Scaffold(
            body: Container(
                color: Constants.COLORS_PRIMARY_COLOR,
                child: SafeArea(
                  left: false,
                  right: false,
                  bottom: false,
                  child: SingleChildScrollView(
                    physics: ScrollPhysics(),
                    child: Container(
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  width: 1.sw,
                                  height: 150.h,
                                  color: Constants.COLORS_PRIMARY_COLOR,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    MainTitleBar(
                                        title: 'Booking',
                                        action: () => Navigator.pop(context)),
                                    CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl: widget.photo,
                                      placeholder: (context, url) =>
                                          Image.asset(
                                        'assets/images/merchant_background.jpg',
                                        fit: BoxFit.cover,
                                        height: 420.h,
                                        width: 1.sw,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                        'assets/images/merchant_background.jpg',
                                        fit: BoxFit.cover,
                                        height: 420.h,
                                        width: 1.sw,
                                      ),
                                      height: 420.h,
                                      width: 1.sw,
                                    ),
                                    // Container(
                                    //     color: Colors.black,
                                    //     height: 500.h,
                                    //     width: 1.sw,
                                    //     child: Image.asset(
                                    //       'assets/images/shop_car_repair.jpg',
                                    //       fit: BoxFit.cover,
                                    //     )),
                                  ],
                                ),
                              ],
                            ),

                            Container(
                              margin: EdgeInsets.only(
                                  left: 20.w, top: 10.h, bottom: 10.h),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  widget.name,
                                  style: TextStyle(
                                      color:
                                          Constants.COLORS_PRIMARY_ORANGE_COLOR,
                                      fontSize: 46.sp),
                                ),
                              ),
                            ),
                            // Expanded(
                            //   flex: 20,
                            //   child: Text(
                            //   widget.desc,
                            //   style: TextStyle(color: Colors.grey, fontSize: 40.sp),
                            // ),),
                            // _isPriceEmpty?Text(widget.price):SizedBox(width: 0,height: 0,),
                            Container(
                              width: 1.sw,
                              margin: EdgeInsets.only(
                                  left: 20.w, top: 10.h, bottom: 10.h),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  widget.desc,
                                  maxLines: 20,
                                  overflow: TextOverflow.visible,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 40.sp),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left: 20.w, top: 10.h, bottom: 10.h),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Pax',
                                        style: TextStyle(
                                            color: Constants
                                                .COLORS_PRIMARY_ORANGE_COLOR,
                                            fontSize: 46.sp),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Constants.COLORS_PRIMARY_COLOR,
                                  ),
                                  child: Row(
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            if (_itemCount != 1) {
                                              if (checkpax('deduct')) {
                                                setState(() => _itemCount--);
                                              }
                                            }
                                          },
                                          child: Icon(
                                            Icons.remove,
                                            color: Colors.white,
                                            size: 26,
                                          )),
                                      Container(
                                        margin:
                                            EdgeInsets.symmetric(horizontal: 5),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 18.w, vertical: 5.h),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(3),
                                            color: Colors.white),
                                        child: Text(
                                          _itemCount.toString(),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 44.sp),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          if (checkpax('add')) {
                                            setState(() => _itemCount++);
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(
                                                  "Pax exceed allocated quantity."),
                                            ));
                                          }
                                        },
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 26,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 14.w,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 40.w,
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  left: 20.w, top: 10.h, bottom: 10.h),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Booking time',
                                  style: TextStyle(
                                      color:
                                          Constants.COLORS_PRIMARY_ORANGE_COLOR,
                                      fontSize: 46.sp),
                                ),
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Radio(
                                    value: BookingTime.today,
                                    groupValue: _days,
                                    onChanged: (BookingTime? value) {
                                      getCurrentDate();
                                      setState(() {
                                        _days = value;
                                      });
                                    },
                                  ),
                                  Text('Book for today'),
                                  Expanded(child: Container()),
                                  _days == BookingTime.today
                                      ? Container()
                                      // Container(
                                      // child: TextButton(
                                      //     onPressed: () {
                                      //       DatePicker.showTime12hPicker(context,
                                      //           showTitleActions: true, onChanged: (date) {
                                      //             setState(() {
                                      //               formattedTime =
                                      //                   DateFormat('kk:mm').format(date);
                                      //             });
                                      //             print('change $date');
                                      //           }, onConfirm: (date) {
                                      //             setState(() {
                                      //               formattedTime =
                                      //                   DateFormat('kk:mm').format(date);
                                      //             });
                                      //             print('confirm $date');
                                      //           },
                                      //           currentTime: DateTime.now(),
                                      //           locale: LocaleType.en);
                                      //     },
                                      //     child: Container(
                                      //       padding: EdgeInsets.symmetric(
                                      //           vertical: 30.h, horizontal: 80.w),
                                      //       decoration: BoxDecoration(
                                      //         border: Border.all(
                                      //           color: Colors.blue.shade200,
                                      //         ),
                                      //         borderRadius:
                                      //         BorderRadius.all(Radius.circular(10)),
                                      //         color: Colors.blue.shade200,
                                      //       ),
                                      //       child: Text(
                                      //         formattedTime,
                                      //         style: TextStyle(color: Colors.white),
                                      //       ),
                                      //     )))
                                      : Container(),
                                  SizedBox(
                                    width: 20.w,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Radio(
                                    value: BookingTime.nextDay,
                                    groupValue: _days,
                                    onChanged: (BookingTime? value) {
                                      setState(() {
                                        _days = value;
                                      });
                                    },
                                  ),
                                  Text('Book for other day')
                                ],
                              ),
                            ),
                            _days == BookingTime.nextDay
                                ? Container(
                                    margin: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.white,
                                      ),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
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
                                    padding: EdgeInsets.only(
                                        left: 15.w, right: 15.w),
                                    width: 1.sw,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Image.asset(
                                          "assets/images/appicon_booking.png",
                                          fit: BoxFit.cover,
                                          height: 60.h,
                                          width: 60.h,
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Expanded(
                                          child: TextButton(
                                            onPressed: () {
                                              DatePicker.showDatePicker(context,
                                                  showTitleActions: true,
                                                  minTime: DateTime(2022, 3, 5),
                                                  maxTime: DateTime(2040, 6, 7),
                                                  onChanged: (date) {
                                                setState(() {
                                                  formattedDate =
                                                      DateFormat('yyyy-MM-dd')
                                                          .format(date);
                                                });
                                              }, onConfirm: (date) {
                                                setState(() {
                                                  formattedDate =
                                                      DateFormat('yyyy-MM-dd')
                                                          .format(date);
                                                  checkpax('date');
                                                });
                                              },
                                                  currentTime: DateTime.now(),
                                                  locale: LocaleType.en);
                                            },
                                            child: Container(
                                              height: 100.h,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 60.w),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                color: Constants
                                                    .COLORS_PRIMARY_COLOR,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  formattedDate,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),

                                        // Expanded(
                                        //     child: TextButton(
                                        //         onPressed: () {
                                        //           DatePicker.showTime12hPicker(context,
                                        //               showTitleActions: true,
                                        //               onChanged: (date) {
                                        //             setState(() {
                                        //               formattedTime =
                                        //                   DateFormat('kk:mm').format(date);
                                        //             });
                                        //             print('change $date');
                                        //           }, onConfirm: (date) {
                                        //             setState(() {
                                        //               formattedTime =
                                        //                   DateFormat('kk:mm').format(date);
                                        //             });
                                        //             print('confirm $date');
                                        //           },
                                        //               currentTime: DateTime.now(),
                                        //               locale: LocaleType.en);
                                        //         },
                                        //         child: Container(
                                        //           padding: EdgeInsets.symmetric(
                                        //               vertical: 30.h, horizontal: 80.w),
                                        //           decoration: BoxDecoration(
                                        //             border: Border.all(
                                        //               color: Colors.blue.shade200,
                                        //             ),
                                        //             borderRadius:
                                        //                 BorderRadius.all(Radius.circular(10)),
                                        //             color: Colors.blue.shade200,
                                        //           ),
                                        //           child: Text(
                                        //             formattedTime,
                                        //             style: TextStyle(color: Colors.white),
                                        //           ),
                                        //         )))
                                      ],
                                    ),
                                  )
                                : Container(),
                            Container(
                              margin: EdgeInsets.only(
                                  left: 20.w, top: 10.h, bottom: 10.h),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Timeslot',
                                  style: TextStyle(
                                      color:
                                          Constants.COLORS_PRIMARY_ORANGE_COLOR,
                                      fontSize: 46.sp),
                                ),
                              ),
                            ),
                            _isBookingAvailable
                                ? ListView(
                                    primary: false,
                                    shrinkWrap: true,
                                    children: [
                                      Wrap(
                                        alignment: WrapAlignment.center,
                                        // runSpacing: 6,
                                        spacing: 8,
                                        children: List.generate(
                                            listBookingTime.length,
                                            (index) => ActionChip(
                                                  backgroundColor: selectedSlot ==
                                                          listBookingTime[index]
                                                      ? Constants
                                                          .COLORS_PRIMARY_ORANGE_COLOR
                                                      : Constants
                                                          .COLORS_PRIMARY_COLOR,
                                                  label: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 12.w,
                                                            vertical: 10.h),
                                                    child: Text(
                                                      listBookingTime[index],
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      selectedSlot =
                                                          listBookingTime[
                                                              index];
                                                      checkpax('slot');
                                                    });
                                                  },
                                                )),
                                      ),
                                    ],
                                  )
                                : Container(
                                    margin:
                                        EdgeInsets.symmetric(vertical: 10.h),
                                    child: Text(
                                      "Restaurant close on selected date.",
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 50.sp),
                                    ),
                                  ),
                            Container(
                              margin: EdgeInsets.only(
                                  left: 20.w, top: 10.h, bottom: 10.h),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Remark',
                                  style: TextStyle(
                                      color:
                                          Constants.COLORS_PRIMARY_ORANGE_COLOR,
                                      fontSize: 46.sp),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(4),
                              child: TextField(
                                controller: _remarkController,
                                minLines: 6,
                                keyboardType: TextInputType.multiline,
                                maxLines: 8,
                                decoration: new InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade300, width: 1),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade300, width: 1),
                                  ),
                                  hintText: 'Remark',
                                ),
                              ),
                            ),

                            TextButton(
                                onPressed: () {
                                  if (selectedSlot.length == 0 ||
                                      selectedSlot.isEmpty) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text("Please select timeslot."),
                                    ));
                                  } else {
                                    submitBooking();
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    // border: Border.all(
                                    //   color: Colors.blue.shade200,
                                    // ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: Constants.COLORS_PRIMARY_COLOR,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 30.h, horizontal: 80.w),
                                  child: Text(
                                    'Confirm booking',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 46.sp),
                                  ),
                                )),
                          ],
                        )),
                  ),
                )),
          );
        },
        future: _tasks);
  }

  bool checkDayAvailable(String strDate) {
    bool isAvailable = false;

    DateTime date = new DateFormat("yyyy-MM-dd").parse(strDate);

    String day = DateFormat('EEEE').format(date);
    if (day == 'Monday') {
      isAvailable = _isMondayAvailable;
    }
    if (day == 'Tuesday') {
      isAvailable = _isTuesdayAvailable;
    }
    if (day == 'Wednesday') {
      isAvailable = _isWednesdayAvailable;
    }
    if (day == 'Thursday') {
      isAvailable = _isThursdayAvailable;
    }
    if (day == 'Friday') {
      isAvailable = _isFridayAvailable;
    }
    if (day == 'Saturday') {
      isAvailable = _isSaturdayAvailable;
    }
    if (day == 'Sunday') {
      isAvailable = _isSundayAvailable;
    }

    return isAvailable;
  }

  Future<List<String>> getdatafromserver() async {
    EasyLoading.show(status: 'loading...');

    itemLists = [];
    listBookingTime = [];

    String date = '';

    if (_days == BookingTime.today) {
      date = getCurrentDate();
    } else {
      date = formattedDate;
    }

    if (!_isLoading) {
      _isLoading = true;

      Map<String, String> requestHeaders = {};

      var responseData = await ApiCall().get(
          arg: requestHeaders,
          method: Constants.NETWORK_GET_BOOKING_DATA(widget.merchantId, date),
          header: requestHeaders,
          context: context);

      // listBookingData.add(BookingData(time: '0', slot: '0'));
      if (responseData.code == 200) {
        responseData.data['setting'].forEach((item) {
          if (item['slot'] != '0') {
            listBookingTime.add(item['time']);
            listBookingData.add(BookingData.fromJson(item));
          }
        });
        // listBookingTime.add(responseData)
        if (responseData.data['shopDetails']['monday'] == 0) {
          _isMondayAvailable = false;
        } else {
          _isMondayAvailable = true;
        }
        if (responseData.data['shopDetails']['tuesday'] == 0) {
          _isTuesdayAvailable = false;
        } else {
          _isTuesdayAvailable = true;
        }
        if (responseData.data['shopDetails']['wednesday'] == 0) {
          _isWednesdayAvailable = false;
        } else {
          _isWednesdayAvailable = true;
        }
        if (responseData.data['shopDetails']['thursday'] == 0) {
          _isThursdayAvailable = false;
        } else {
          _isThursdayAvailable = true;
        }
        if (responseData.data['shopDetails']['friday'] == 0) {
          _isFridayAvailable = false;
        } else {
          _isFridayAvailable = true;
        }
        if (responseData.data['shopDetails']['saturday'] == 0) {
          _isSaturdayAvailable = false;
        } else {
          _isSaturdayAvailable = true;
        }
        if (responseData.data['shopDetails']['sunday'] == 0) {
          _isSundayAvailable = false;
        } else {
          _isSundayAvailable = true;
        }
      }
      _isBookingAvailable = checkDayAvailable(date);
      setState(() {});
    }

    _isLoading = false;
    EasyLoading.dismiss();
    return itemLists;
  }

  bool checkpax(String from) {
    bool available = false;
    // if (from == 'add' || from == 'deduct') {
    if (from == 'add') {
      int nextCount = _itemCount + 1;
      listBookingData.forEach((item) {
        if (item.time.contains(selectedSlot)) {
          if (nextCount <= int.parse(item.slot)) {
            available = true;
          }
        }
      });
    } else if (from == 'deduct') {
      available = true;
    }

    if (from == 'submt') {
      if (selectedSlot == '' || selectedSlot.isEmpty) {
        available = false;
      }
    }

    if (from == 'date') {
      getdatafromserver();
    }
    // }

    // listBookingData.indexOf(BookingData.);

    return available;
  }

  bool checkDate() {
    bool available = true;
    if (selectedSlot == '' || selectedSlot.isEmpty) {
      available = false;
    }

    return available;
  }

  submitBooking() async {
    if (!checkDate()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please select timeslot.'),
      ));
    } else if (checkpax('submit')) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Pax exceed allocated quantity. Please reduce pax.'),
      ));
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool _isLogin = prefs.getBool(Constants.PREF_LOGIN) ?? false;

      if (!_isLogin) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => LoginPage()));
      } else {
        String token = prefs.getString(Constants.PREF_TOKEN) ?? '';

        Map<String, String> requestHeaders = {};

        Map<String, String> arg = {
          // 'action': widget.id,
          // 'action': widget.id,
          // 'order_id': widget.id,
        };

        arg['date'] = formattedDate;
        arg['time'] = selectedSlot;
        arg['slot'] = _itemCount.toString();
        arg['restorant_id'] = widget.merchantId;
        arg['remark'] = _remarkController.value.text;

        var responseData = await ApiCall().post(
            arg: arg,
            method: Constants.NETWORK_STORE_BOOKING,
            header: requestHeaders,
            context: context);

        if (responseData.code == 200) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(responseData.message),
          ));
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(responseData.message),
          ));
        }
      }
    }
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  getCurrentDate() {
    DateTime selectedDate = DateTime.now();
    formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
    formattedTime = DateFormat('kk:mm').format(selectedDate);
    return formattedDate;
  }

  getCurrentTime() {
    DateTime selectedDate = DateTime.now();
    formattedTime = DateFormat('kk:mm').format(selectedDate);
    return formattedTime;
  }
}
