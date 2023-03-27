import '../Model/merchant_details_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Widget/merchant_booking_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'package:html_unescape/html_unescape.dart';
import '../Utils/constants.dart';

class MerchantDetailsPerItemList extends StatelessWidget {
  late MerchantDetailsModel data;
  late String merchantId;
  late String number;
  late String url;

  MerchantDetailsPerItemList(
      {required this.data,
      required this.merchantId,
      required this.number,
      required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showQRCode(context, data);
        // _openWhatsapp(number);
      },
      child: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.all(10),
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(2),
              height: 200.w,
              width: 200.w,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: data.picture,
                  placeholder: (context, url) => Image.asset(
                    'assets/images/appicon.png',
                    height: 200.w,
                    width: 200.w,
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    'assets/images/appicon.png',
                    height: 200.w,
                    width: 200.w,
                  ),
                  height: 200.w,
                  width: 200.w,
                ),
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(
                    data.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Constants.COLORS_FONT_TITLE, fontSize: 40.sp),
                  ),
                  Text(
                    data.desc,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 34.sp,
                    ),
                  ),
                ])),
            SizedBox(
              width: 10.w,
            ),
          ],
        ),
      ),
    );
  }

  showQRCode(BuildContext context, MerchantDetailsModel data) {
    showDialog(
        context: context,
        // barrierDismissible: false,
        builder: (BuildContext context) {
          return GestureDetector(
            onTap: (() {
              Navigator.of(context).pop(true);
            }),
            child: Container(
              // width: 0.8.sw,
              // height: 0.8.sh,
              color: Colors.black.withOpacity(0.2),
              child: GestureDetector(
                onTap: () {},
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                    ),
                    width: 0.8.sw,
                    height: 0.6.sh,
                    child: Column(children: [
                      SizedBox(height: 20.h),
                      Container(
                        height: 0.20.sh,
                        width: 0.20.sh,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: data.picture,
                            placeholder: (context, url) => Image.asset(
                              'assets/images/appicon.png',
                              height: 0.20.sh,
                              width: 0.20.sh,
                            ),
                            errorWidget: (context, url, error) => Image.asset(
                              'assets/images/appicon.png',
                              height: 0.20.sh,
                              width: 0.20.sh,
                            ),
                            height: 0.20.sh,
                            width: 0.20.sh,
                          ),
                        ),
                      ),
                      Text(
                        data.name,
                        style: TextStyle(
                            fontSize: 44.sp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10.h),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 50.w),
                        height: 0.3.sh,
                        child: SingleChildScrollView(
                            physics: ScrollPhysics(),
                            child: Text(
                              _parseHtmlString(data.desc),
                              textAlign: TextAlign.justify,
                              style: TextStyle(fontSize: 40.sp),
                            )),
                      ),
                      SizedBox(height: 5.h),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                                margin: EdgeInsets.only(left: 50.w),
                                child: Text(
                                  'RM ' + data.price,
                                  style: TextStyle(
                                      fontSize: 44.sp,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                          url.length == 0 || url == null
                              ? Container()
                              : GestureDetector(
                                  onTap: () {
                                    launchURl(url);
                                  },
                                  child: Container(
                                    width: 60.h,
                                    height: 60.h,
                                    child: Image.asset(
                                        'assets/images/icon_browser.png'),
                                  ),
                                ),
                          SizedBox(
                            width: 10.w,
                          ),
                          GestureDetector(
                            onTap: () {
                              _openWhatsapp(number);
                            },
                            child: Container(
                              width: 60.h,
                              height: 60.h,
                              child: Image.asset(
                                  'assets/images/icon_whatsapp.png'),
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                        ],
                      )
                    ]),
                  ),
                ),
              ),
            ),
          );
        });
  }

  void launchURl(String uri) async {
    print(uri);
    String uri2 = uri;
    if (!uri.contains('http')) {
      uri2 = 'http://' + uri;
    }

    Uri url = Uri.parse(uri2);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      String uri3 = uri;
      Uri url = Uri.parse(uri3);
      if (!uri.contains('http')) {
        uri3 = 'https://' + uri;
      }
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      }
    }
  }

  String _parseHtmlString(String htmlString) {
    var unescape = HtmlUnescape();
    String unescapeString = unescape.convert(htmlString);
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return unescapeString.replaceAll(exp, '');
  }

  void _openWhatsapp(String number) async {
    // String url = "https://wa.me/" + number;
    // String url = "https://api.whatsapp.com/send?phone=" + number;

    if (Platform.isAndroid) {
      // add the [https]
      String url = "https://wa.me/" + number;
      await launch(url);
    } else {
      String url = "https://api.whatsapp.com/send?phone=" + number;
      await launch(url);
    }
  }
}
