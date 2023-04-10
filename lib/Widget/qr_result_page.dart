import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Model/merchant_model.dart';
import '../Widget/main_title_bar.dart';
import '../Model/qr_scan_result_model.dart';
import '../Model/get_qr_details_model.dart';
import 'qr_result_without_image.dart';
import 'qr_result_with_image.dart';
import '../Widget/api_calling.dart';
import '../Utils/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class QrResultPage extends StatefulWidget {
  final QrResult data;

  const QrResultPage({required this.data}) : super();

  @override
  _QrResultPageState createState() => _QrResultPageState();
}

enum PaymentType { cashPayment, cc }

class _QrResultPageState extends State<QrResultPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController icController = TextEditingController();

  String accPoints = '0';
  bool _isLogin = false;
  bool _isEmpty = false;
  bool _eventSelected = true;
  String userName = '';
  String userPhone = '';
  String userEmail = '';
  String userIc = '';
  String userId = '';

  String eventName = '';
  String restaurantName = '';
  String eventDesc = '';
  String registerStartDate = '';
  String registerEndDate = '';
  String eventStartDate = '';
  String eventEndDate = '';
  String eventStartTime = '';
  String eventEndTime = '';

  late SharedPreferences prefs;

  bool _isPayment = false;
  late GetQrDetailsModel returnData;
  PaymentType? _paymentType = PaymentType.cashPayment;
  String _redeemPoint = 'false';
  bool _isLoading = false;
  bool _isError = false;
  late Future<dynamic> futureVariable;

  @override
  void initState() {
    super.initState();

    returnData = new GetQrDetailsModel();
    futureVariable = getDataFromServer();
    // setState(() {
    // });
  }

  @override
  Widget build(BuildContext ctx) {
    return FutureBuilder<dynamic>(
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting &&
            snapshot.hasData == null) {
          return Scaffold(
            body: SafeArea(
              child: SizedBox.expand(
                child: Container(
                  height: 1.sw,
                  color: Colors.white,
                  child: SingleChildScrollView(
                    physics: ScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: 1.sw,
                              height: 70.h,
                              color: Constants.COLORS_PRIMARY_COLOR,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                MainTitleBar(
                                    title: 'Payment',
                                    action: () => Navigator.pop(context)),
                              ],
                            ),
                          ],
                        ),
                        QrResultWithoutImage(text: ''),
                        QrResultWithImage(
                          description: 'Amount',
                          data: '',
                          image: "assets/images/appicon_27thcoin_blue.png",
                        ),
                        QrResultWithImage(
                          description: 'Date',
                          data: '',
                          image: "assets/images/appicon_booking.png",
                        ),
                        QrResultWithImage(
                          description: 'Invoice number',
                          data: '',
                          image: "assets/images/appicon_stall.png",
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(14)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 20.w, top: 10.h),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Payment Selection',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Navigator.pop(ctx, true);
                          },
                          child: Text('Submit Payment'),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
        return WillPopScope(
            child: Scaffold(
                body: SafeArea(
                    child: SizedBox.expand(
              child: Container(
                height: 1.sw,
                color: Colors.white,
                child: SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: _isPayment ? paymentUI(ctx) : eventUI(ctx),
                ),
              ),
            ))),
            onWillPop: (() async {
              return true;
            }));
      },
      future: futureVariable,
    );
  }

  Widget eventUI(BuildContext ctx) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 0.95.sh),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          MainTitleBar(title: 'Event', action: () => Navigator.pop(context)),
          SizedBox(
            height: 10.h,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            width: 1.sw,
            child: Text(
              eventName,
              style: TextStyle(
                  color: Constants.COLORS_PRIMARY_ORANGE_COLOR,
                  fontSize: 54.sp),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            width: 1.sw,
            child: Text(
              'by. ' + restaurantName,
              style: TextStyle(color: Colors.black, fontSize: 36.sp),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 30.w),
            width: 1.sw,
            child: Text(
              eventDesc,
              style: TextStyle(
                  color: Constants.COLORS_PRIMARY_COLOR, fontSize: 44.sp),
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
            child: Text(
              registerStartDate + ' - ' + registerEndDate,
              style: TextStyle(
                fontSize: 40.sp,
                color: Colors.black,
              ),
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
            child: Text(eventStartDate + ' - ' + eventEndDate,
                style: TextStyle(
                  fontSize: 40.sp,
                  color: Colors.black,
                )),
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
            child: Text(eventStartTime + ' - ' + eventEndTime,
                style: TextStyle(
                  fontSize: 40.sp,
                  color: Colors.black,
                )),
          ),
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: TextFormField(
              style: TextStyle(fontSize: 50.sp, color: Colors.black),
              controller: nameController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                labelText: 'NAME'.tr(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: TextFormField(
              style: TextStyle(fontSize: 50.sp, color: Colors.black),
              keyboardType: TextInputType.number,
              controller: phoneController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                labelText: 'PHONE'.tr(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: TextFormField(
              style: TextStyle(fontSize: 50.sp, color: Colors.black),
              controller: emailController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                labelText: 'EMAIL'.tr(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: TextFormField(
              style: TextStyle(fontSize: 50.sp, color: Colors.black),
              keyboardType: TextInputType.number,
              controller: icController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
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
                String email = emailController.value.text;
                String icStr = icController.value.text;
                if (fullName.length != 0 &&
                    phone.length != 0 &&
                    email.length != 0) {
                  attendEvent();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content:
                        Text('Please make sure all field have been fill up.'),
                  ));
                }
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
                  'Join Event',
                  style: TextStyle(fontSize: 50.sp),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget paymentUI(BuildContext ctx) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              width: 1.sw,
              height: 70.h,
              color: Constants.COLORS_PRIMARY_COLOR,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MainTitleBar(
                    title: 'PAYMENT'.tr(), action: () => Navigator.pop(ctx)),
              ],
            ),
          ],
        ),
        QrResultWithoutImage(text: returnData.from),
        SizedBox(
          height: 20.h,
        ),
        QrResultWithImage(
          description: 'AMOUNT'.tr(),
          data: returnData.voucher_amount,
          image: "assets/images/appicon_27thcoin_blue.png",
        ),
        SizedBox(
          height: 20.h,
        ),
        QrResultWithImage(
          description: 'DATE'.tr(),
          data: returnData.created_date,
          image: "assets/images/appicon_booking.png",
        ),
        SizedBox(
          height: 20.h,
        ),
        QrResultWithImage(
          description: 'INVOICE_NUMBER'.tr(),
          data: returnData.invoice_number,
          image: "assets/images/appicon_stall.png",
        ),
        SizedBox(
          height: 20.h,
        ),
        Container(
          margin: EdgeInsets.all(10),
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
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 40.w, top: 30.h),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'PAYMENT_SELECTION'.tr(),
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 46.sp),
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  '100_CASH_PAYMENT'.tr(),
                  style: TextStyle(color: Colors.blue, fontSize: 40.sp),
                ),
                subtitle: Text(
                  '+' + fixNumber(returnData.voucher_amount) + ' cc points',
                  style: TextStyle(color: Colors.orangeAccent, fontSize: 40.sp),
                ),
                leading: Radio(
                  value: PaymentType.cashPayment,
                  groupValue: _paymentType,
                  onChanged: (PaymentType? value) {
                    setState(() {
                      _paymentType = value;
                    });
                  },
                ),
              ),
              _redeemPoint == 'true'
                  ? ListTile(
                      title: Text(
                        'PAY_WITH'.tr(),
                        style: TextStyle(color: Colors.blue, fontSize: 40.sp),
                      ),
                      subtitle: Text(
                        '- ' + returnData.percent + ' CC points',
                        style: TextStyle(
                            color: Colors.orangeAccent, fontSize: 40.sp),
                      ),
                      leading: Radio(
                        value: PaymentType.cc,
                        groupValue: _paymentType,
                        onChanged: (PaymentType? value) {
                          setState(() {
                            _paymentType = value;
                          });
                        },
                      ),
                    )
                  : Container()
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              // showLoaderDialog(ctx,true);
              if (_paymentType == PaymentType.cashPayment) {
                submitPayment('add_point');
              } else {
                submitPayment('deduct_point');
              }
            });
          },
          child: Text(
            'SUBMIT_PAYMENT'.tr(),
            style: TextStyle(fontSize: 46.sp),
          ),
        ),
      ],
    );
  }

  showLoaderDialog(BuildContext context, bool show) {
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

  attendEvent() async {
    EasyLoading.show(status: 'loading...');

    Map<String, String> requestHeaders = {};

    String fullName = nameController.value.text;
    String phone = phoneController.value.text;
    String email = emailController.value.text;
    String icStr = icController.value.text;

    String eventID = widget.data.orderId;

    Map<String, String> bodyArg = {
      'name': fullName,
      'phone': phone,
      'email': email,
      'ic': icStr,
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

      Future.delayed(Duration(milliseconds: 1000), () {
        Navigator.pop(context, true);
      });
    } else {
      _isLoading = false;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(returnData.message),
      ));
    }

    EasyLoading.dismiss();
  }

  submitPayment(String paymentType) async {
    _isLoading = true;

    Map<String, String> requestHeaders = {};

    Map<String, String> arg = {
      'action': paymentType,
      'order_id': widget.data.orderId
    };

    var responseData = await ApiCall().post(
        arg: arg,
        method: Constants.NETWORK_STORE_POINT,
        header: requestHeaders,
        context: context);

    _isLoading = false;

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(responseData.message),
    ));

    if (responseData.code == 200) {
      Future.delayed(Duration(milliseconds: 1000), () {
        Navigator.pop(context);
      });
    }
  }

  Future getDataFromServer() async {
    //check qr from where

    if (widget.data.qrFrom == "1") {
      _isPayment = false;

      Map<String, String> requestHeaders = {
        // 'eventID': widget.data.orderId,
      };

      var responseData = await ApiCall().get(
          arg: requestHeaders,
          method: Constants.NETWORK_GET_EVENT_DETAILS + widget.data.orderId,
          header: requestHeaders,
          context: context);

      if (responseData.code == 200) {
        eventName = responseData.data['eventDetails']['event_name'];
        eventDesc = responseData.data['eventDetails']['event_desc'];
        restaurantName = responseData.data['eventDetails']['restorant_name'];
        registerStartDate =
            responseData.data['eventDetails']['register_start_date'];
        registerEndDate =
            responseData.data['eventDetails']['register_end_date'];
        eventStartDate = responseData.data['eventDetails']['event_start_date'];
        eventEndDate = responseData.data['eventDetails']['event_end_date'];
        eventStartTime = responseData.data['eventDetails']['event_start_time'];
        eventEndTime = responseData.data['eventDetails']['event_end_time'];
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(responseData.message),
        ));

        Future.delayed(Duration(milliseconds: 1000), () {
          Navigator.pop(context, false);
        });
      }

      setState(() {});

      return returnData;
    } else {
      _isPayment = true;
      Map<String, String> requestHeaders = {};

      var responseData = await ApiCall().get(
          arg: requestHeaders,
          method: Constants.NETWORK_GET_QR_ORDER_DETAILS + widget.data.orderId,
          header: requestHeaders,
          context: context);

      List<Merchant> merchants = [];

      if (responseData.code == 200) {
        GetQrDetailsModel model =
            GetQrDetailsModel.fromJson(responseData.data['order']);
        returnData = model;
        _redeemPoint = model.use_point;
        _isLoading = false;
        return returnData;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(responseData.message),
        ));

        Future.delayed(Duration(milliseconds: 1000), () {
          Navigator.pop(context, false);
        });
      }
    }

    Map<String, String> requestHeaders = {};

    var responseData = await ApiCall().get(
        arg: requestHeaders,
        method: Constants.NETWORK_GET_QR_ORDER_DETAILS + widget.data.orderId,
        header: requestHeaders,
        context: context);

    List<Merchant> merchants = [];

    if (responseData.code == 200) {
      GetQrDetailsModel model =
          GetQrDetailsModel.fromJson(responseData.data['order']);
      returnData = model;
      _redeemPoint = model.use_point;
      _isLoading = false;
      return returnData;
    }
  }

  fixNumber(String number) {
    String getInitials(String bank_account_name) => bank_account_name.isNotEmpty
        ? bank_account_name.trim().split(' ').map((l) => l[0]).take(2).join()
        : '';
    if (getInitials(number) == 'R') {
      number = number.substring(1);
    }
    if (getInitials(number) == 'M') {
      number = number.substring(1);
    }

    return number;
  }
}
