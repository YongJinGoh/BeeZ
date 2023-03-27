import '../Model/merchant_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Widget/merchant_category_grid.dart';
import '../Widget/merchant_details_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Model/event_data_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:html_unescape/html_unescape.dart';
import '../Utils/constants.dart';
import '../Widget/attend_event_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventAttendListItem extends StatefulWidget {
  bool showAll = false;
  late EventModel data;
  late SharedPreferences prefs;
  String qrString = '';
  EventAttendListItem({required this.data});

  @override
  _EventAttendListItemState createState() => _EventAttendListItemState();
}

class _EventAttendListItemState extends State<EventAttendListItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        generateQRString();

        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) =>
                AttendEventPage(data: widget.data, qrString: widget.qrString)));
      },
      child: AbsorbPointer(
        child: Container(
          width: 1.sw,
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
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
                                onTap: () {},
                                child: Text(
                                  widget.data.eventName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Constants.COLORS_FONT_TITLE,
                                      fontSize: 40.sp,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      _parseHtmlString(widget.data.eventDesc),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 34.sp, color: Colors.black),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                  ])),
              SizedBox(
                width: 10.w,
              ),
              Container(
                child: Image.asset(
                  'assets/images/appicon_click_next.png',
                  height: 100.h,
                  width: 35.w,
                ),
              ),
              SizedBox(
                width: 30.w,
              ),
            ],
          ),
        ),
      ),
    );
  }

  generateQRString() async {
    widget.prefs = await SharedPreferences.getInstance();
    String userId = widget.prefs.getString(Constants.PREF_ID) ?? '';

    widget.qrString =
        '{"event_id":' + widget.data.id + ',"user_id"' + userId + '}';
  }

  String _parseHtmlString(String htmlString) {
    var unescape = HtmlUnescape();
    String unescapeString = unescape.convert(htmlString);
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return unescapeString.replaceAll(exp, '');
  }
}
