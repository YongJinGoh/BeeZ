import 'package:biz_sense/Widget/event_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Widget/setting_single_image.dart';
import '../Widget/setting_single_image_vertical.dart';
import '../Widget/change_password_page.dart';
import '../Widget/profile_details_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Utils/constants.dart';
import '../Widget/api_calling.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import '../Widget/merchant_booking_list_page.dart';
import '../Widget/community_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var languageOption = ['English', 'Melayu', '中文'];
  bool _loading = false;
  bool isLogoutClicked = false;
  late BuildContext dialogContext;
  late SharedPreferences prefs;
  String name = '';
  String email = '';
  String phoneNumber = '';
  String referralLink = '';

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  getSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    name = prefs.getString(Constants.PREF_NAME) ?? '';
    email = prefs.getString(Constants.PREF_EMAIL) ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getName(),
        builder: (context, snapshot) {
          return SizedBox.expand(
              child: Container(
            color: Colors.white,
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      height: 790.h,
                      color: Constants.COLORS_PRIMARY_COLOR,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 50.h),
                        GestureDetector(
                          onTap: () {
                            // getProfilePicture();
                          },
                          child: Container(
                            width: 320.h,
                            height: 320.h,
                            child: CircleAvatar(
                              radius: 10,
                              backgroundColor: Colors.white,
                              backgroundImage: AssetImage(
                                  'assets/images/appicon_profile_highres.png'),
                            ),
                          ),
                        ),
                        Container(
                          child: Text(name,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 50.sp)),
                          margin: EdgeInsets.only(top: 10.h),
                        ),
                        SizedBox(height: 30.h),
                        GestureDetector(
                          onTap: () {
                            showQRCode(referralLink);
                          },
                          child: Column(children: [
                            Container(
                              child: Text('REFERRAL_CODE_CLICK_TO_VIEW'.tr(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 38.sp)),
                              margin: EdgeInsets.only(top: 5.h),
                            ),
                            Container(
                              child: Text(' ' + email + ' ',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.white,
                                      fontSize: 30.sp)),
                            )
                          ]),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Container(
                          width: 0.9.sw,
                          height: 115.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () =>
                                    // Navigator.of(context).push(MaterialPageRoute(
                                    //     builder: (_) => ProfileDetailsPage(
                                    //           name: name,
                                    //           phone: phoneNumber,
                                    //           email: email,
                                    //         ))),
                                    Navigator.of(context)
                                        .push(
                                          new MaterialPageRoute(
                                              builder: (_) =>
                                                  new ProfileDetailsPage(
                                                    name: name,
                                                    phone: phoneNumber,
                                                    email: email,
                                                  )),
                                        )
                                        .then(
                                            (val) => val ? updateName() : null),
                                child: Container(
                                  width: 0.40.sw,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  // margin: EdgeInsets.all(6),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(width: 12.w),
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        child: Image.asset(
                                          'assets/images/appicon_profile.png',
                                          width: 90.w,
                                          height: 90.w,
                                        ),
                                      ),
                                      SizedBox(width: 20.w),
                                      Flexible(
                                        child: Text(
                                          'PROFILE'.tr(),
                                          style: TextStyle(
                                            fontSize: 44.sp,
                                            color: Colors.grey,
                                          ),
                                          softWrap: true,
                                          maxLines: 2,
                                          overflow: TextOverflow.visible,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // SettingSingleImage(
                              //   data: "Profile",
                              //   image: 'assets/images/appicon_profile.png',
                              //   nextPage: ProfileDetailsPage(
                              //     name: name,
                              //     phone: phoneNumber,
                              //     email: email,
                              //   ),
                              //   widthSize: 0.40.sw,
                              // ),
                              SizedBox(
                                width: 0.1.sw,
                              ),
                              SettingSingleImage(
                                data: 'CHANGE_PASSWORD'.tr(),
                                image:
                                    'assets/images/appicon_changePassword.png',
                                nextPage: ChangePasswordPage(),
                                widthSize: 0.40.sw,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 710.h),
                      width: 1.sw,
                      height: 100.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40)),
                      ),
                      child: Container(
                        margin: EdgeInsets.only(left: 0.05.sw, top: 30.h),
                        // width: 0.9.sw,
                        child: Text(
                          'My account',
                          style: TextStyle(
                              color: Constants.COLORS_PRIMARY_COLOR,
                              fontSize: 50.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SettingSingleImageVertical(
                      data: 'COMMUNITY'.tr(),
                      image: 'assets/images/community.png',
                      nextPage: ProfileDetailsPage(
                        name: name,
                        phone: phoneNumber,
                        email: email,
                      ),
                      onTap: () => refresh('community'),
                    ),
                    SettingSingleImageVertical(
                      data: 'MY_BOOKING'.tr(),
                      image: 'assets/images/booking.png',
                      nextPage: ProfileDetailsPage(
                        name: name,
                        phone: phoneNumber,
                        email: email,
                      ),
                      onTap: () => refresh('booking'),
                    ),
                    SettingSingleImageVertical(
                      data: 'EVENT'.tr(),
                      image: 'assets/images/event_icon.png',
                      nextPage: ProfileDetailsPage(
                        name: name,
                        phone: phoneNumber,
                        email: email,
                      ),
                      onTap: () => refresh('event'),
                    ),
                    // Container(width: 0.3.sw),
                    // Container(width: 0.3.sw),
                  ],
                ),
                SizedBox(
                  height: 50.h,
                ),
                Container(
                  margin: EdgeInsets.only(left: 0.05.sw),
                  width: 1.sw,
                  child: Text(
                    'General',
                    style: TextStyle(
                        color: Constants.COLORS_PRIMARY_COLOR,
                        fontSize: 50.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SettingSingleImageVertical(
                      data: 'ABOUT_US'.tr(),
                      image: 'assets/images/icon_setting_about_us.png',
                      nextPage: ProfileDetailsPage(
                        name: name,
                        phone: phoneNumber,
                        email: email,
                      ),
                      onTap: () => refresh('about us'),
                    ),
                    SettingSingleImageVertical(
                      data: 'TERM_OF_USE'.tr(),
                      image: 'assets/images/icon_setting_tnc.png',
                      nextPage: ProfileDetailsPage(
                        name: name,
                        phone: phoneNumber,
                        email: email,
                      ),
                      onTap: () => refresh('termsofuse'),
                    ),
                    SettingSingleImageVertical(
                      data: 'PRIVACY_POLICY'.tr(),
                      image: 'assets/images/icon_setting_policy.png',
                      nextPage: ProfileDetailsPage(
                        name: name,
                        phone: phoneNumber,
                        email: email,
                      ),
                      onTap: () => refresh('privacypolicy'),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40.h,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SettingSingleImageVertical(
                      data: 'CONTACT_US'.tr(),
                      image: 'assets/images/icon_setting_contact_us.png',
                      nextPage: LoginPage(),
                      onTap: () => refresh('contactus'),
                    ),
                    SettingSingleImageVertical(
                      data: 'LANGUAGE'.tr(),
                      image: 'assets/images/icon_change_language.png',
                      nextPage: LoginPage(),
                      onTap: () => refresh('change'),
                    ),
                    SettingSingleImageVertical(
                      data: 'LOG_OUT'.tr(),
                      image: 'assets/images/icon_setting_log_out.png',
                      // nextPage: ProfileDetailsPage(),
                      onTap: () async {
                        await showDialog(
                          context: context,
                          builder: (context) {
                            dialogContext = context;
                            return AlertDialog(
                              title: Text('CONFIRMATION'.tr(),
                                  style: TextStyle(fontSize: 40.sp)),
                              content: Text('LOGOUT_CONFIRMATION'.tr(),
                                  style: TextStyle(fontSize: 40.sp)),
                              actions: <Widget>[
                                new TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(dialogContext);
                                  },
                                  child: Text('NO'.tr(),
                                      style: TextStyle(fontSize: 40.sp)),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    prefs =
                                        await SharedPreferences.getInstance();
                                    prefs.setBool(Constants.PREF_LOGIN, false);
                                    prefs.setString(Constants.PREF_TOKEN, '');
                                    prefs.setString(Constants.PREF_ID, '');
                                    prefs.setString(Constants.PREF_NAME, '');
                                    prefs.setString(Constants.PREF_EMAIL, '');
                                    prefs.setString(Constants.PREF_PHONE, '');

                                    Navigator.of(context).pop(dialogContext);
                                    // logOut();
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                LoginPage()));
                                    setState(() {
                                      // Navigaxtor.of(context).pop(dialogContext);
                                    });
                                  },
                                  child: Text(
                                    'YES'.tr(),
                                    style: TextStyle(fontSize: 40.sp),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ));
        });
  }

  // getProfilePicture() async {
  //
  //   final ImagePicker _picker = ImagePicker();
  //   // Pick an image
  //   final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  //   // // Capture a photo
  //   // final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
  //   // // Pick a video
  //   // final XFile? image = await _picker.pickVideo(source: ImageSource.gallery);
  //   // // Capture a video
  //   // final XFile? video = await _picker.pickVideo(source: ImageSource.camera);
  //   // // Pick multiple images
  //   // final List<XFile>? images = await _picker.pickMultiImage();
  //   String path = image!.path;
  //   print(path);
  // }

  updateName() async {
    prefs = await SharedPreferences.getInstance();
    name = prefs.getString(Constants.PREF_NAME) ?? '';
    String token = prefs.getString(Constants.PREF_TOKEN) ?? '';
    email = prefs.getString(Constants.PREF_EMAIL) ?? '';
    phoneNumber = prefs.getString(Constants.PREF_PHONE) ?? '';
    referralLink = Constants.NETWORK_URL + 'register?ref=$email';
    setState(() {});
  }

  getName() async {
    prefs = await SharedPreferences.getInstance();
    name = prefs.getString(Constants.PREF_NAME) ?? '';
    String token = prefs.getString(Constants.PREF_TOKEN) ?? '';
    email = prefs.getString(Constants.PREF_EMAIL) ?? '';
    phoneNumber = prefs.getString(Constants.PREF_PHONE) ?? '';
    referralLink = Constants.NETWORK_URL + 'register?ref=$email';
  }

  logOut() async {
    _loading = true;

    Map<String, String> requestHeaders = {
      'deviceid':
          'cBxBBYu4Qvuklp4ySaPQcx:APA91bFiVRvYNQ3Zpuwmh1I_8d62DRkKWHVwABtZsfs5s92FKRNramHL8rueCUvm4de5J_cO3-fFGZGuAWd72-_EZaqI9HsI7UDWeZL--yZ9uutwGeKQHbPJkvtlfqiS6upVJFIxjKJJ',
      'Accept': 'application/json'
    };

    Map<String, String> requestBody = {};

    var responseData = await ApiCall().post(
        arg: requestBody,
        method: Constants.NETWORK_LOGOUT,
        header: requestHeaders,
        context: context);
    if (responseData.code == 200) {
      prefs = await SharedPreferences.getInstance();
      prefs.setBool(Constants.PREF_LOGIN, false);
      prefs.setString(Constants.PREF_TOKEN, '');
      prefs.setString(Constants.PREF_ID, '');
      prefs.setString(Constants.PREF_NAME, '');
      prefs.setString(Constants.PREF_EMAIL, '');
      prefs.setString(Constants.PREF_PHONE, '');

      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
    } else {
      // prefs = await SharedPreferences.getInstance();
      // prefs.setBool(Constants.PREF_LOGIN, true);

      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
    }
  }

  refresh(String selected) {
    if (selected == 'about us') {
      _launchUrl(Constants.NETWORK_URL + 'about_us');
    } else if (selected == 'termsofuse') {
      _launchUrl(Constants.NETWORK_URL + 'term_of_use');
    } else if (selected == 'privacypolicy') {
      _launchUrl(Constants.NETWORK_URL + 'policy');
    } else if (selected == 'change') {
      _languageDialog();
    } else if (selected == 'contactus') {
      _launchUrl(Constants.NETWORK_URL + 'contact_us');
    } else if (selected == 'booking') {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => MerchantBookingListPage()));
    } else if (selected == 'community') {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => CommunityPage()));
    } else if (selected == 'event') {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => EventPage()));
    } else {
      _launchUrl(Constants.NETWORK_URL + '');
    }
    // setState(() {});
  }

  void _languageDialog() {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title:
                Text('CHANGE_LANGUAGE'.tr(), style: TextStyle(fontSize: 50.sp)),
            content: Container(
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (BuildContext ctx, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pop(ctx);
                      _changeLanguage(index);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: Text(
                        languageOption[index],
                        style: TextStyle(fontSize: 44.sp),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        });
  }

  void _changeLanguage(int languageInt) async {
    await context.setLocale(context.supportedLocales[languageInt]);

    prefs = await SharedPreferences.getInstance();
    if (languageInt == 0) {
      prefs.setString(Constants.PREF_LANGUAGE, 'en');
    } else if (languageInt == 1) {
      prefs.setString(Constants.PREF_LANGUAGE, 'bm');
    } else if (languageInt == 2) {
      prefs.setString(Constants.PREF_LANGUAGE, 'cn');
    } else {
      prefs.setString(Constants.PREF_LANGUAGE, 'en');
    }
  }

  void _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'There was a problem to open the url: $url';
    }
  }

  createQR(String link) {
    return QrImage(
      data: link,
      version: QrVersions.auto,
      size: 320,
      gapless: false,
    );
  }

  showQRCode(String link) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
                child: Text('Referral QR', style: TextStyle(fontSize: 40.sp)
                    // style: TextStyle(color: Colors.white),
                    )),
            content: Container(
              width: 0.6.sw,
              height: 0.6.sw,
              child: Center(
                  child: QrImage(
                data: link,
                version: QrVersions.auto,
                gapless: false,
              )),
            ),
          );
        });
  }
}
