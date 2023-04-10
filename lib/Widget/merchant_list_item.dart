import '../Model/merchant_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Widget/merchant_category_grid.dart';
import '../Widget/merchant_details_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Model/merchant_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:html_unescape/html_unescape.dart';
import '../Utils/constants.dart';
import '../Widget/merchant_fc_list_page.dart';

class MerchantListItem extends StatefulWidget {
  bool showAll = false;
  late MerchantModel data;

  MerchantListItem({required this.data});

  @override
  _MerchantListItemState createState() => _MerchantListItemState();
}

class _MerchantListItemState extends State<MerchantListItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
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
        child: Padding(
          padding: EdgeInsets.all(4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  // print(widget.data.isFoodCourt);
                  if (widget.data.isFoodCourt) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => MerchantFCListPage(
                          merchantData: widget.data,
                          title: widget.data.name,
                          data: widget.data.id,
                        ),
                      ),
                    );
                  } else {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => MerchantDetailsPage(
                          data: widget.data,
                        ),
                      ),
                    );
                  }
                },
                child: Column(
                  children: [
                    widget.data.isFoodCourt
                        ? Container(
                            padding: EdgeInsets.only(left: 0.w, top: 10.h),
                            child: Text(
                              'Community',
                              style: TextStyle(
                                  color: Constants.COLORS_PRIMARY_ORANGE_COLOR,
                                  fontSize: 30.sp),
                            ),
                          )
                        : Container(),
                    Container(
                      padding: EdgeInsets.all(2),
                      height: 230.w,
                      width: 230.w,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          height: 230.w,
                          width: 230.w,
                          fit: BoxFit.cover,
                          imageUrl: widget.data.picture,
                          placeholder: (context, url) => Image.asset(
                            'assets/images/appicon.png',
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            'assets/images/appicon.png',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                width: 20.w,
              ),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            child: GestureDetector(
                                onTap: () => Navigator.of(context)
                                    .push(MaterialPageRoute(
                                        builder: (_) => MerchantDetailsPage(
                                              data: widget.data,
                                            ))),
                                child: Text(
                                  widget.data.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Constants.COLORS_FONT_TITLE,
                                      fontSize: 40.sp,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                        ),
                        // widget.data.acceptPoint == 'true'
                        //     ? Expanded(
                        //         flex: 1,
                        //         child: Image.asset(
                        //           'assets/images/accept_point.png',
                        //           width: 150.w,
                        //           height: 75.h,
                        //         ),
                        //       )
                        //     : Container(),
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (widget.data.isFoodCourt) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => MerchantFCListPage(
                                merchantData: widget.data,
                                title: widget.data.name,
                                data: widget.data.id,
                              ),
                            ),
                          );
                        } else {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => MerchantDetailsPage(
                                data: widget.data,
                              ),
                            ),
                          );
                        }
                        // if (widget.showAll) {
                        //   setState(() {
                        //     widget.showAll = false;
                        //   });
                        // } else {
                        //   setState(() {
                        //     widget.showAll = true;
                        //   });
                        // }
                      },
                      child: widget.showAll
                          ? Text(
                              _parseHtmlString(widget.data.description),
                              maxLines: 1000,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 34.sp, color: Colors.black),
                            )
                          : Text(
                              _parseHtmlString(widget.data.description),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 34.sp, color: Colors.black),
                            ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                  ])),
              SizedBox(
                width: 10.w,
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => MerchantDetailsPage(
                          data: widget.data,
                        ))),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
                  child: Image.asset(
                    'assets/images/appicon_click_next.png',
                    height: 100.h,
                    width: 35.w,
                  ),
                ),
              ),
              // CachedNetworkImage(imageUrl: data.picture,placeholder: (context,url) =>  Image.asset('assets/images/appicon_click_next.png',height: 70.h,width: 30.w,),width: 30.w,height: 70.h,),
              SizedBox(
                width: 10.w,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _parseHtmlString(String htmlString) {
    var unescape = HtmlUnescape();
    String unescapeString = unescape.convert(htmlString);
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return unescapeString.replaceAll(exp, '');
  }
}
