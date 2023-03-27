import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'merchant_details_toolbar_item.dart';
import 'merchant_middle_toolbar.dart';
import 'merchant_middle_double_toolbar.dart';
import 'merchant_opening_hour_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Widget/merchant_booking_page.dart';
import '../Widget/merchant_rating_page.dart';
import '../Model/merchant_model.dart';
import '../Model/working_hour_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../Utils/constants.dart';
import 'api_calling.dart';
import '../Model/merchant_details_model.dart';
import 'merchant_details_list_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:html_unescape/html_unescape.dart';
import 'working_hour_list_item.dart';

class MerchantDetailsPage2 extends StatefulWidget {
  late MerchantModel data;
  String merchantID;

  MerchantDetailsPage2({required this.merchantID});

  @override
  _MerchantDetails2State createState() => _MerchantDetails2State();
}

class _MerchantDetails2State extends State<MerchantDetailsPage2> {
  bool isFollow = true;
  //Create list
  Map<String, String> socialList = Map();
  Map<String, String> openingList = Map();
  Map<String, String> closingList = Map();
  String coverImage = '';
  String openTime = '';
  String closeTime = '';
  String desc = '';
  String website = '';
  late Future<List<MerchantDetails>> _tasks;
  List<MerchantDetailsModel> itemLists = [];
  List<WorkingHour> openingHourLists = [];
  List<MerchantDetails> merchants = [];
  List<String> galleryList = [];
  bool _isLoading = false;
  bool _isError = false;
  GlobalKey<ConvexAppBarState> _appBarKey = GlobalKey<ConvexAppBarState>();

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
            return Scaffold(
                body: Container(
              color: Constants.COLORS_PRIMARY_COLOR,
              child: SafeArea(
                left: false,
                right: false,
                bottom: false,
                child: SizedBox.expand(
                  child: Container(
                    color: Colors.white,
                    child: SingleChildScrollView(
                        physics: ScrollPhysics(),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  width: 1.sw,
                                  height: 0.25.sh,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(""),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 0.21.sh),
                                  height: 90.h,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white,
                                    ),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30),
                                    ),
                                    color: Colors.white,
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Icon(Icons.arrow_back,
                                      color: Colors.white),
                                  style: ElevatedButton.styleFrom(
                                    shape: CircleBorder(),
                                    primary: Colors.black45, // <-- Button color
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 30.w),
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                              height: 20.h,
                              width: 1.sw,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(widget.data.name,
                                      style: TextStyle(
                                        color: Constants
                                            .COLORS_PRIMARY_ORANGE_COLOR,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w600,
                                      )),
                                  SizedBox(height: 10.h),
                                  Container(
                                    width: 1.sw,
                                    child: Text(
                                      widget.data.address,
                                      overflow: TextOverflow.visible,
                                      maxLines: 2,
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                  Container(
                                    width: 1.sw,
                                    child: Text(
                                      widget.data.description,
                                      overflow: TextOverflow.visible,
                                      maxLines: 2,
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) => MerchantRatingPage(
                                          data: widget.data))),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 30.w,
                                  ),
                                  RatingBar.builder(
                                    ignoreGestures: true,
                                    itemSize: 16,
                                    initialRating: 3,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: false,
                                    itemCount: 5,
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                    },
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Text(
                                    "(100 reviews)",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10.h),
                            // Container(
                            //     width: 1.sw,
                            //     padding:
                            //         EdgeInsets.fromLTRB(30.w, 20.h, 30.w, 20.h),
                            //     decoration: BoxDecoration(
                            //       border: Border.all(
                            //         color: Colors.white,
                            //       ),
                            //       borderRadius:
                            //           BorderRadius.all(Radius.circular(10)),
                            //       color: Colors.white,
                            //     ),
                            //     child: Column(
                            //       children: [
                            //         Container(
                            //           alignment: Alignment.centerLeft,
                            //           child: Text('Opening Time & Closing Time',
                            //               style: TextStyle(
                            //                   color: Colors.grey,
                            //                   fontSize: 45.sp)),
                            //         ),
                            //         SizedBox(height: 40.h),
                            //         Container(
                            //           height: 150.h,
                            //           width: 0.95.sw,
                            //           decoration: BoxDecoration(
                            //             borderRadius: BorderRadius.all(
                            //                 Radius.circular(10)),
                            //             color: Colors.white,
                            //             boxShadow: [
                            //               BoxShadow(
                            //                 color: Colors.grey.withOpacity(0.5),
                            //                 spreadRadius: 2,
                            //                 blurRadius: 5,
                            //                 offset: Offset(0,
                            //                     3), // changes position of shadow
                            //               ),
                            //             ],
                            //           ),
                            //           child: Row(
                            //             children: [
                            //               SizedBox(
                            //                 width: 20.w,
                            //               ),
                            //               Stack(
                            //                 children: [
                            //                   MerchantOpeningHourText(
                            //                     data: 'OPEN',
                            //                     textColor: Colors.white,
                            //                     boxColor: Colors.green[900],
                            //                     fontWeight: FontWeight.w600,
                            //                     marginLeft: 0.sw,
                            //                     borderCircular:
                            //                         Radius.circular(0),
                            //                     onTap: () {},
                            //                   ),
                            //                   MerchantOpeningHourText(
                            //                     data: '10:00 am',
                            //                     textColor: Colors.green[900],
                            //                     boxColor: Colors.green[600],
                            //                     fontWeight: FontWeight.w600,
                            //                     marginLeft: 0.20.sw,
                            //                     borderCircular:
                            //                         Radius.circular(8),
                            //                     onTap: () {},
                            //                   ),
                            //                   MerchantOpeningHourText(
                            //                     data: 'CLOSE',
                            //                     textColor: Colors.white,
                            //                     boxColor: Colors.grey[800],
                            //                     fontWeight: FontWeight.w600,
                            //                     marginLeft: 0.48.sw,
                            //                     borderCircular:
                            //                         Radius.circular(0),
                            //                     onTap: () {},
                            //                   ),
                            //                   MerchantOpeningHourText(
                            //                     data: '10.00 pm',
                            //                     textColor: Colors.grey[800],
                            //                     boxColor: Colors.grey[400],
                            //                     fontWeight: FontWeight.w600,
                            //                     marginLeft: 0.68.sw,
                            //                     borderCircular:
                            //                         Radius.circular(8),
                            //                     onTap: () {},
                            //                   ),
                            //                 ],
                            //               ),
                            //               SizedBox(width: 20.w),
                            //             ],
                            //           ),
                            //         ),
                            //       ],
                            //     )),
                          ],
                        )),
                  ),
                ),
              ),
            ));
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
                    color: Colors.white,
                    child: SingleChildScrollView(
                      physics: ScrollPhysics(),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: coverImage,
                                placeholder: (context, url) => Image.asset(
                                  'assets/images/merchant_background.jpg',
                                  fit: BoxFit.cover,
                                  width: 1.sw,
                                  height: 0.25.sh,
                                ),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                  'assets/images/merchant_background.jpg',
                                  fit: BoxFit.cover,
                                  width: 1.sw,
                                  height: 0.25.sh,
                                ),
                                width: 1.sw,
                                height: 0.25.sh,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 0.21.sh),
                                height: 120.h,
                                // height: 90.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30),
                                  ),
                                  color: Colors.white,
                                ),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                      onTap: () {
                                        followMerchant();
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 16.h, horizontal: 30.w),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color:
                                                Constants.COLORS_PRIMARY_COLOR,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)),
                                        ),
                                        margin: EdgeInsets.only(right: 50.w),
                                        child: isFollow
                                            ? Text(
                                                'Unfollow',
                                                style: TextStyle(
                                                    color: Constants
                                                        .COLORS_PRIMARY_COLOR),
                                              )
                                            : Text(
                                                'Follow',
                                                style: TextStyle(
                                                    color: Constants
                                                        .COLORS_PRIMARY_COLOR),
                                              ),
                                      )),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () => Navigator.pop(context),
                                child:
                                    Icon(Icons.arrow_back, color: Colors.white),
                                style: ElevatedButton.styleFrom(
                                  shape: CircleBorder(),
                                  primary: Colors.black45, // <-- Button color
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            width: 1.sw,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 20.w),
                                  child: Text(widget.data.name,
                                      style: TextStyle(
                                        color: Constants
                                            .COLORS_PRIMARY_ORANGE_COLOR,
                                        fontSize: 48.sp,
                                        fontWeight: FontWeight.w600,
                                      )),
                                ),
                                SizedBox(height: 10.h),
                                // Container(
                                //   margin: EdgeInsets.only(left: 20.w),
                                //   child: Text('OPEN_RIGHT_NOW'.tr(),
                                //       style: TextStyle(
                                //           fontSize: 36.sp,
                                //           color: Colors.lightBlue)),
                                // ),
                                SizedBox(height: 5.h),
                                widget.data.address.length != 0
                                    ? Container(
                                        margin: EdgeInsets.only(
                                            left: 20.w, right: 20.w),
                                        width: 1.sw,
                                        height: 90.h,
                                        child: Text(
                                          widget.data.address,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontSize: 40.sp,
                                              color: Colors.grey[700]),
                                        ),
                                      )
                                    : Container(),
                                desc.length != 0
                                    ? Container(
                                        margin: EdgeInsets.only(
                                            top: 5.h, left: 20.w, right: 20.w),
                                        width: 1.sw,
                                        child: Text(
                                          _parseHtmlString(desc),
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                              fontSize: 40.sp,
                                              color:
                                                  Constants.COLORS_FONT_DESC),
                                        ),
                                      )
                                    : Container(
                                        color: Colors.amber,
                                      ),
                                SizedBox(height: 5.h),
                              ],
                            ),
                          ),
                          // GestureDetector(
                          //   onTap: () => Navigator.of(context).push(
                          //       MaterialPageRoute(
                          //           builder: (_) => MerchantRatingPage(
                          //               data: widget.data))),
                          //   child: Row(
                          //     children: [
                          //       SizedBox(
                          //         width: 20.w,
                          //       ),
                          //       RatingBar.builder(
                          //         ignoreGestures: true,
                          //         itemSize: 16,
                          //         initialRating: 3,
                          //         minRating: 1,
                          //         direction: Axis.horizontal,
                          //         allowHalfRating: false,
                          //         itemCount: 5,
                          //         itemBuilder: (context, _) => Icon(
                          //           Icons.star,
                          //           color: Colors.amber,
                          //         ),
                          //         onRatingUpdate: (rating) {
                          //           print(rating);
                          //         },
                          //       ),
                          //       SizedBox(
                          //         width: 10.w,
                          //       ),
                          //       Text(
                          //         "(100 reviews)",
                          //         maxLines: 1,
                          //         overflow: TextOverflow.ellipsis,
                          //         style: TextStyle(
                          //           fontSize: 30.sp,
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // Container(
                          //     width: 1.sw,
                          //     padding:
                          //         EdgeInsets.fromLTRB(30.w, 5.h, 30.w, 5.h),
                          //     decoration: BoxDecoration(
                          //       border: Border.all(
                          //         color: Colors.white,
                          //       ),
                          //       borderRadius:
                          //           BorderRadius.all(Radius.circular(10)),
                          //       color: Colors.white,
                          //     ),
                          //     child: Column(
                          //       children: [
                          //         Container(
                          //           alignment: Alignment.centerLeft,
                          //           child: Text('OPENING_CLOSING_TIME'.tr(),
                          //               style: TextStyle(
                          //                   color: Colors.grey,
                          //                   fontSize: 40.sp)),
                          //         ),
                          //         SizedBox(height: 10.h),
                          //         Container(
                          //           height: 120.h,
                          //           width: 0.95.sw,
                          //           decoration: BoxDecoration(
                          //             borderRadius: BorderRadius.all(
                          //                 Radius.circular(10)),
                          //             color: Colors.white,
                          //             boxShadow: [
                          //               BoxShadow(
                          //                 color: Colors.grey.withOpacity(0.5),
                          //                 spreadRadius: 2,
                          //                 blurRadius: 5,
                          //                 offset: Offset(0,
                          //                     3), // changes position of shadow
                          //               ),
                          //             ],
                          //           ),
                          //           child: Row(
                          //             children: [
                          //               SizedBox(
                          //                 width: 10.w,
                          //               ),
                          //               Stack(
                          //                 children: [
                          //                   MerchantOpeningHourText(
                          //                     data: 'OPEN'.tr(),
                          //                     textColor: Colors.white,
                          //                     boxColor: Colors.green[900],
                          //                     fontWeight: FontWeight.w600,
                          //                     marginLeft: 0.03.sw,
                          //                     borderCircular:
                          //                         Radius.circular(0),
                          //                     onTap: () {
                          //                       setUpWorkingHourDialog(
                          //                           openingHourLists, true);
                          //                     },
                          //                   ),
                          //                   MerchantOpeningHourText(
                          //                     data: openTime,
                          //                     textColor: Colors.green[900],
                          //                     boxColor: Colors.green[600],
                          //                     fontWeight: FontWeight.w600,
                          //                     marginLeft: 0.23.sw,
                          //                     borderCircular:
                          //                         Radius.circular(8),
                          //                     onTap: () {
                          //                       setUpWorkingHourDialog(
                          //                           openingHourLists, true);
                          //                     },
                          //                   ),
                          //                   MerchantOpeningHourText(
                          //                     data: 'CLOSE'.tr(),
                          //                     textColor: Colors.white,
                          //                     boxColor: Colors.grey[800],
                          //                     fontWeight: FontWeight.w600,
                          //                     marginLeft: 0.49.sw,
                          //                     borderCircular:
                          //                         Radius.circular(0),
                          //                     onTap: () {
                          //                       setUpWorkingHourDialog(
                          //                           openingHourLists, false);
                          //                     },
                          //                   ),
                          //                   MerchantOpeningHourText(
                          //                     data: closeTime,
                          //                     textColor: Colors.grey[800],
                          //                     boxColor: Colors.grey[400],
                          //                     fontWeight: FontWeight.w600,
                          //                     marginLeft: 0.68.sw,
                          //                     borderCircular:
                          //                         Radius.circular(8),
                          //                     onTap: () {
                          //                       setUpWorkingHourDialog(
                          //                           openingHourLists, false);
                          //                     },
                          //                   ),
                          //                 ],
                          //               ),
                          //               SizedBox(width: 10.w),
                          //             ],
                          //           ),
                          //         ),
                          //       ],
                          //     )),
                          _isLoading
                              ? CircularProgressIndicator()
                              : _isError
                                  ? Dialog(
                                      child: Padding(
                                        padding: EdgeInsets.all(20),
                                        child: Text('No item at the moment'),
                                      ),
                                    )
                                  : ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: merchants.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        MerchantDetails merchant =
                                            merchants[index];
                                        print(merchant.title);
                                        return MerchantDetailsListItem(
                                          data: merchant,
                                          number: widget.data.phone,
                                          url: website,
                                        );
                                      },
                                    ),
                          galleryList.length > 0
                              ? Container(
                                  width: 1.sw,
                                  margin:
                                      EdgeInsets.only(left: 30.w, top: 10.h),
                                  child: Text(
                                    'Gallery',
                                    style: TextStyle(
                                      color:
                                          Constants.COLORS_PRIMARY_ORANGE_COLOR,
                                      fontSize: 48.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                )
                              : Container(),
                          galleryList.length > 0
                              ? Container(
                                  width: 1.sw,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 20.w, vertical: 20.h),
                                  child: GridView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      gridDelegate:
                                          const SliverGridDelegateWithMaxCrossAxisExtent(
                                              maxCrossAxisExtent: 100,
                                              crossAxisSpacing: 20,
                                              mainAxisSpacing: 20),
                                      itemCount: galleryList.length,
                                      itemBuilder: (BuildContext ctx, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(builder: (_) {
                                              return detailScreen(
                                                  galleryList[index]);
                                            }));
                                          },
                                          child: CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            imageUrl: galleryList[index],
                                            placeholder: (context, url) =>
                                                Image.asset(
                                              'assets/images/appicon_hd.png',
                                              fit: BoxFit.cover,
                                              width: 0.3.sw,
                                              height: 0.3.sw,
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Image.asset(
                                              'assets/images/appicon_hd.png',
                                              fit: BoxFit.cover,
                                              width: 0.3.sw,
                                              height: 0.3.sw,
                                            ),
                                            width: 0.3.sw,
                                            height: 0.3.sw,
                                          ),
                                        );
                                      }))
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            bottomNavigationBar: StyleProvider(
                style: Style(),
                child: ConvexAppBar(
                  key: _appBarKey,
                  curveSize: 10,
                  top: -20,
                  style: TabStyle.react,
                  backgroundColor: Colors.white,
                  color: Colors.grey,
                  activeColor: Colors.grey,
                  items: [
                    TabItem(
                        icon: Image.asset('assets/images/appicon_callshop.png'),
                        title: 'CALL'.tr(),
                        activeIcon:
                            Image.asset('assets/images/appicon_callshop.png')),
                    TabItem(
                        icon: Image.asset('assets/images/appicon_likes.png'),
                        title: 'SOCIAL'.tr(),
                        activeIcon:
                            Image.asset('assets/images/appicon_likes.png')),
                    TabItem(
                        icon:
                            Image.asset('assets/images/appicon_direction.png'),
                        title: 'DIRECTION'.tr(),
                        activeIcon:
                            Image.asset('assets/images/appicon_direction.png')),
                    TabItem(
                        icon: Image.asset('assets/images/appicon_booking.png'),
                        title: 'BOOKING'.tr(),
                        activeIcon:
                            Image.asset('assets/images/appicon_booking.png')),
                  ],
                  onTap: (int i) =>
                      _onTap(i, widget.data, context, socialList, coverImage),
                  // onTap: (data: widget.data.phone),
                  //optional, default as 0
                )),
          );
        },
        future: _tasks);
  }

  Future<List<MerchantDetails>> getdatafromserver() async {
    itemLists = [];

    widget.data = MerchantModel();

    if (!_isLoading) {
      _isLoading = true;
      Map<String, String> requestHeaders = {};

      var responseData = await ApiCall().get(
          arg: requestHeaders,
          method: Constants.NETWORK_GET_VENDOR_ITEMS(widget.merchantID),
          header: requestHeaders,
          context: context);

      merchants = [];
      if (responseData.code == 200) {
        dynamic dataFood = responseData.data['foodcourt'];
        dynamic dataRes = dataFood['restorant'];

        String name = dataRes['name'];
        String lat = dataRes['lat'];
        String lng = dataRes['lng'];
        String description = dataRes['description'];
        String address = dataRes['address'];
        String phone = dataRes['phone'];

        widget.data = MerchantModel(
          name: name,
          lat: lat,
          lng: lng,
          description: description,
          address: address,
          phone: phone,
        );

        coverImage = dataRes['cover'];
        openTime = trim(true, dataRes['working_hour']);
        closeTime = trim(false, dataRes['working_hour']);
        desc = dataRes['description'];

        if (dataRes['facebook'].toString().isNotEmpty &&
            dataRes['facebook'] != null) {
          socialList['facebook'] = dataRes['facebook'];
        }
        if (dataRes['instagram'] != '' && dataRes['instagram'] != null) {
          socialList['instagram'] = dataRes['instagram'];
        }
        if (dataRes['website'] != '' && dataRes['website'] != null) {
          socialList['website'] = dataRes['website'];
          website = dataRes['website'];
        }
        //Disable when social media is back up
        // socialList['facebook'] = 'https://www.facebook.com/paultanautonews';
        // socialList['instagram'] = 'https://www.instagram.com/paultancars/';
        dataRes['categories'].forEach((mer) {
          itemLists = [];
          mer['items'].forEach((res) {
            itemLists.add(MerchantDetailsModel.fromJson(res));
          });
          merchants.add(MerchantDetails.fromJson(mer, itemLists));
        });

        dataRes['time_list'].forEach((work) {
          openingHourLists.add(WorkingHour.fromJson(work));
        });

        dataRes['gallerys'].forEach((galItem) {
          galleryList.add(galItem);
        });

        isFollow = responseData.data['isFollow'];

        _isLoading = false;
        _isError = false;
        // Iterable l = json.decode(hmmm.data['sections']['restorants']);
        // List<MerchantModel> posts =
      } else {
        _isLoading = false;
        _isError = true;
        coverImage = widget.data.picture;
      }

      setState(() {
        itemLists = itemLists;
      });

      _isLoading = false;
    }
    return merchants;
  }

  void followMerchant() async {
    if (!_isLoading) {
      _isLoading = true;
      Map<String, String> requestHeaders = {};

      Map<String, String> arg = {
        'restorant_id': widget.data.id,
      };

      var responseData = await ApiCall().post(
          arg: arg,
          method: Constants.NETWORK_POST_FOLLOW,
          header: requestHeaders,
          context: context);

      if (responseData.code == 200) {
        setState(() {
          if (isFollow) {
            isFollow = false;
          } else {
            isFollow = true;
          }
        });
      }

      _isLoading = false;
    }
  }

  void _launchUrl(Uri url) async {
    if (!await launchUrl(url)) throw 'Could not launch $url';
  }

  setUpWorkingHourDialog(List<WorkingHour> openingHourLists, bool isOpen) {
    String selected = '';
    if (isOpen) {
      selected = 'Opening hour';
    } else {
      selected = 'Closing hour';
    }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              selected,
              style: TextStyle(fontSize: 50.sp),
            ),
            content: isOpen
                ? Container(
                    width: double.maxFinite,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: openingHourLists.length,
                      itemBuilder: (BuildContext context, int index) {
                        return WorkingHourListItem(
                          data: openingHourLists[index],
                          isOpen: isOpen,
                        );
                      },
                    ))
                : Container(
                    width: double.maxFinite,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: openingHourLists.length,
                      itemBuilder: (BuildContext context, int index) {
                        return WorkingHourListItem(
                          data: openingHourLists[index],
                          isOpen: isOpen,
                        );
                      },
                    ),
                  ),
          );
        });
  }

  String _parseHtmlString(String htmlString) {
    var unescape = HtmlUnescape();
    String unescapeString = unescape.convert(htmlString);
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return unescapeString.replaceAll(exp, '');
  }

  String trim(bool isBefore, String given) {
    String afterTrim = given;

    var parts = given.split('-');

    if (isBefore) {
      afterTrim = parts[0];
    } else {
      afterTrim = parts[1];
    }
    return afterTrim;
  }
}

void _callNumber(String number) async {
  String url = "tel://" + number;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not call $number';
  }
}

void _openWhatsapp(String number) async {
  if (Platform.isAndroid) {
    String url = "https://wa.me/" + number;
    await launch(url);
  } else {
    String url = "https://api.whatsapp.com/send?phone=" + number;
    await launch(url);
  }
}

void _openMap(double lat, double lng) async {
  String uri = 'waze://?ll=${lat.toString()},${lng.toString()}';
  // var uri = Uri.parse("google.navigation:q=$lat,$lng&mode=d");

  if (await canLaunch(uri.toString())) {
    await launch(uri.toString());
  } else {
    String uri = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
    } else {
      throw 'Could not launch 1 ${uri.toString()}';
    }
    throw 'Could not launch 2 ${uri.toString()}';
  }
}

void handleError(BuildContext dialogContext, BuildContext context) {
  Navigator.of(dialogContext).pop();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content:
        Text('Unable to load Waze. Please make sure you have installed Waze.'),
  ));
}

void handleGoogleError(BuildContext dialogContext, BuildContext context) {
  Navigator.of(dialogContext).pop();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
        'Unable to load Google map. Please make sure you have installed Google Map.'),
  ));
}

void selectWazeOrGoogle(double lat, double lng, BuildContext context) async {
  String wazeLink = 'waze://?ll=${lat.toString()},${lng.toString()}';
  String googleLink =
      'https://www.google.com/maps/search/?api=1&query=$lat,$lng';

  void _launchWaze(Uri url, BuildContext dialogContext) async {
    try {
      if (!await launchUrl(url)) {
        handleError(dialogContext, context);
      }
    } catch (ex) {
      handleError(dialogContext, context);
    }
  }

  void _launchGoogle(Uri url, BuildContext dialogContext) async {
    try {
      if (!await launchUrl(url)) {
        handleGoogleError(dialogContext, context);
      }
    } catch (ex) {
      handleGoogleError(dialogContext, context);
    }
  }

  showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return SimpleDialog(
          title: Text('DIRECTION').tr(),
          children: [
            GestureDetector(
              onTap: () {
                _launchWaze(Uri.parse(wazeLink), dialogContext);
              },
              child: Container(
                  margin: EdgeInsets.only(left: 90.w),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/icon_waze.png',
                        width: 80.w,
                        height: 80.w,
                      ),
                      SizedBox(
                        width: 40.w,
                      ),
                      Text(
                        'Waze',
                        style: TextStyle(fontSize: 50.sp),
                      ),
                    ],
                  )),
            ),
            SizedBox(
              height: 20.h,
            ),
            GestureDetector(
              onTap: () {
                _launchGoogle(Uri.parse(googleLink), dialogContext);
              },
              child: Container(
                  margin: EdgeInsets.only(left: 90.w),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/icon_google.png',
                        width: 80.w,
                        height: 80.w,
                      ),
                      SizedBox(
                        width: 40.w,
                      ),
                      Text(
                        'Google Map',
                        style: TextStyle(fontSize: 50.sp),
                      ),
                    ],
                  )),
            ),
            // isInsta ? GestureDetector(onTap: (){print(instagram);}, child: Text('Instagram'),) : Container(),
            // isFb ? GestureDetector(onTap: (){print(facebook);}, child: Text('Facebook'),) : Container()
          ],
        );
      });
}

void setupAlertDialoadContainer(
    Map<String, String> widgetList, BuildContext context) async {
  String instagram = widgetList['instagram'] ?? '';
  String facebook = widgetList['facebook'] ?? '';
  String website = widgetList['website'] ?? '';
  bool isInsta = false;
  bool isFb = false;
  bool isWebsite = false;

  if (instagram != '') {
    isInsta = true;
  }
  if (facebook != '') {
    isFb = true;
  }
  if (website != '') {
    isWebsite = true;
  }

  void _launchUrl(Uri url) async {
    if (!await launchUrl(url)) throw 'Could not launch $url';
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

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Social Media'),
          children: [
            isInsta
                ? GestureDetector(
                    onTap: () {
                      _launchUrl(Uri.parse(instagram));
                    },
                    child: Container(
                        margin: EdgeInsets.only(left: 90.w),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/icon_instagram.png',
                              width: 80.w,
                              height: 80.w,
                            ),
                            SizedBox(
                              width: 40.w,
                            ),
                            Text(
                              'Instagram',
                              style: TextStyle(fontSize: 50.sp),
                            ),
                          ],
                        )),
                  )
                : Container(),
            SizedBox(
              height: 20.h,
            ),
            isFb
                ? GestureDetector(
                    onTap: () {
                      _launchUrl(Uri.parse(facebook));
                    },
                    child: Container(
                        margin: EdgeInsets.only(left: 90.w),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/square_facebook.png',
                              width: 80.w,
                              height: 80.w,
                            ),
                            SizedBox(
                              width: 40.w,
                            ),
                            Text(
                              'Facebook',
                              style: TextStyle(fontSize: 50.sp),
                            ),
                          ],
                        )),
                  )
                : Container(),
            SizedBox(
              height: 20.h,
            ),
            isWebsite
                ? GestureDetector(
                    onTap: () {
                      launchURl(website);
                    },
                    child: Container(
                        margin: EdgeInsets.only(left: 90.w),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/icon_browser.png',
                              width: 80.w,
                              height: 80.w,
                            ),
                            SizedBox(
                              width: 40.w,
                            ),
                            Text(
                              'Website',
                              style: TextStyle(fontSize: 50.sp),
                            ),
                          ],
                        )),
                  )
                : Container(),
            // isInsta ? GestureDetector(onTap: (){print(instagram);}, child: Text('Instagram'),) : Container(),
            // isFb ? GestureDetector(onTap: (){print(facebook);}, child: Text('Facebook'),) : Container()
          ],
        );
      });
}

Future<void> _onTap(int index, MerchantModel data, BuildContext context,
    Map<String, String> socialList, String coverImage) async {
  if (index == 0) {
    _callNumber(data.phone);
  }
  if (index == 1) {
    setupAlertDialoadContainer(socialList, context);
  }
  if (index == 2) {
    selectWazeOrGoogle(double.parse(data.lat), double.parse(data.lng), context);
    // _openMap(double.parse(data.lat), double.parse(data.lng));
  }
  if (index == 3) {
    // _openWhatsapp(data.phone);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MerchantBookingPage(
          merchantId: data.id,
          itemId: '0',
          name: data.name,
          desc: data.description,
          photo: coverImage,
          price: '',
        ),
      ),
    );
  }
}

class Style extends StyleHook {
  @override
  double get activeIconSize => 60.h;

  @override
  double get activeIconMargin => 0;

  @override
  double get iconSize => 50.h;

  @override
  TextStyle textStyle(Color color, String? textStyle) {
    return TextStyle(fontSize: 38.sp, color: color);
  }
}

class detailScreen extends StatelessWidget {
  detailScreen(this.yourData);
  final String yourData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: Image.network(
              yourData,
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
