import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Model/reward_model.dart';
import '../Widget/merchant_category_grid.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import '../Utils/constants.dart';
import 'package:qr_flutter/qr_flutter.dart';

class VoucherListItem extends StatelessWidget {
  late VoucherModel data;

  VoucherListItem({required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        if (data.voucherStatus != 'used') {
          showQRCode(data.voucherCode, context, data.tnc);
        }
      }),
      child: Container(
        margin:
            EdgeInsets.only(left: 30.w, right: 30.w, top: 20.h, bottom: 20.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(4),
                height: 190.w,
                width: 190.w,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    height: 190.w,
                    width: 190.w,
                    fit: BoxFit.cover,
                    imageUrl: '',
                    placeholder: (context, url) => Image.asset(
                      'assets/images/logo-icon-beez2.png',
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      'assets/images/logo-icon-beez2.png',
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 3,
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.merchantName,
                        style: TextStyle(
                          fontSize: 40.sp,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      data.voucherStatus == 'used'
                          ? Text(
                              data.voucherTitle,
                              style: TextStyle(
                                  fontSize: 40.sp,
                                  color: Colors.red,
                                  decoration: TextDecoration.lineThrough),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )
                          : Text(
                              data.voucherTitle,
                              style: TextStyle(
                                  fontSize: 40.sp,
                                  color: Constants.COLORS_FONT_TITLE),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                    ],
                  ),
                )),
            Expanded(
              flex: 2,
              child: Container(
                margin: EdgeInsets.only(right: 10.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Expiry date',
                      style: TextStyle(
                        fontSize: 40.sp,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      data.expiryDate,
                      style: TextStyle(fontSize: 30.sp, color: Colors.grey),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  showQRCode(String link, BuildContext context, String tnc) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
                child: Text('Voucher QR', style: TextStyle(fontSize: 40.sp)
                    // style: TextStyle(color: Colors.white),
                    )),
            content: Container(
                height: 0.6.sh,
                width: 0.8.sw,
                child: Column(
                  children: [
                    QrImage(
                      // foregroundColor: Colors.white,
                      data: link,
                      size: 0.5.sw,
                      version: QrVersions.auto,
                      gapless: false,
                    ),
                    Text(
                      'Terms & Condition',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 50.w),
                      height: 0.15.sh,
                      child: SingleChildScrollView(
                          physics: ScrollPhysics(),
                          child: Text(
                            tnc,
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: 40.sp),
                          )),
                    ),
                  ],
                )),
          );
        });
  }
}
