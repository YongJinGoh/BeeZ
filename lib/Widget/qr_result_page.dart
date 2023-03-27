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

class QrResultPage extends StatefulWidget {
  final QrResult data;

  const QrResultPage({required this.data}) : super();

  @override
  _QrResultPageState createState() => _QrResultPageState();
}

enum PaymentType { cashPayment, cc }

class _QrResultPageState extends State<QrResultPage> {
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
                              title: 'PAYMENT'.tr(),
                              action: () => Navigator.pop(ctx)),
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
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 46.sp),
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            '100_CASH_PAYMENT'.tr(),
                            style:
                                TextStyle(color: Colors.blue, fontSize: 40.sp),
                          ),
                          subtitle: Text(
                            '+' +
                                fixNumber(returnData.voucher_amount) +
                                ' cc points',
                            style: TextStyle(
                                color: Colors.orangeAccent, fontSize: 40.sp),
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
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 40.sp),
                                ),
                                subtitle: Text(
                                  '- ' + returnData.percent + ' CC points',
                                  style: TextStyle(
                                      color: Colors.orangeAccent,
                                      fontSize: 40.sp),
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
              ),
            ),
          ),
        )));
      },
      future: futureVariable,
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
