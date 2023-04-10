import '../main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Widget/sign_up_page.dart';
import '../Widget/forget_password_page.dart';
import '../Widget/api_calling.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../home.dart';
import 'dart:io';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import '../Widget/component/logo.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:localization/localization.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:async';
import 'dart:convert';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late Locale _locale;

  String email = '';
  String finalToken = '';
  String password = '';
  double emptyHeight = 1.sh;
  double emptyTopHeight = 0.4.sh;
  bool _loading = false;
  late SharedPreferences prefs;
  bool _obscureText = true;
  // AccessToken _accessToken;

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  getSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    print('inside login');

    getToken();
    Future.delayed(Duration(seconds: 4)).then((value) => setState(() {
          emptyTopHeight = 0.0;
        }));
    Future.delayed(Duration(seconds: 5)).then((value) => setState(() {
          emptyHeight = 0.0;
        }));
  }

  void setLocale(Locale value) {
    setState(() {
      _locale = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: "/",
        home: Scaffold(
          extendBodyBehindAppBar: true,
          body: Builder(
            builder: (ctx) => Container(
                color: Constants.COLORS_PRIMARY_COLOR,
                child: SafeArea(
                  left: false,
                  right: false,
                  bottom: false,
                  child: Container(
                      height: 1.sh,
                      width: 1.sw,
                      // decoration: BoxDecoration(
                      //   image: DecorationImage(
                      //       image: AssetImage('assets/images/login_bg.png'),
                      //       fit: BoxFit.fill),
                      // ),
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: SingleChildScrollView(
                          physics: ScrollPhysics(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: 5.h,
                              ),
                              // AnimatedContainer(
                              //   duration: Duration(seconds: 1),
                              //   height: emptyTopHeight,
                              // ),
                              // const Logo(),
                              // AnimatedContainer(
                              //   duration: Duration(seconds: 1),
                              //   height: emptyHeight,
                              // ),
                              Container(
                                height: 160,
                                width: 350,
                                padding: EdgeInsets.symmetric(
                                    vertical: 20.h, horizontal: 20.w),
                                child:
                                    Image.asset('assets/images/logo-beez.png'),
                              ),
                              Container(
                                height: 0.85.sh,
                                // height: 1.sh,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30),
                                  ),
                                  color: Colors.white,
                                ),
                                child: Column(children: [
                                  SizedBox(
                                    height: 50.h,
                                  ),
                                  Stack(
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        height: 120.h,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 30),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30.0)),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                                margin: EdgeInsets.only(
                                                    left: 8.w, right: 6.w),
                                                width: 90.w,
                                                height: 90.w,
                                                child: Image.asset(
                                                  'assets/images/icon_username_login.png',
                                                  fit: BoxFit.contain,
                                                )),
                                            Container(
                                              height: 100.h,
                                              width: 0.7.sw,
                                              child: TextField(
                                                style:
                                                    TextStyle(fontSize: 50.sp),
                                                controller: nameController,
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  border: InputBorder.none,
                                                  hintText: 'EMAIL'.tr(),
                                                  hintStyle: TextStyle(
                                                      height: 1.6,
                                                      fontSize: 50.sp,
                                                      color: Constants
                                                          .COLORS_PRIMARY_COLOR),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      _loading
                                          ? Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                          : Container(),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 40.h,
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    height: 120.h,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 30),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30.0)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                            margin: EdgeInsets.only(
                                                left: 8.w, right: 6.w),
                                            width: 90.w,
                                            height: 90.w,
                                            child: Image.asset(
                                              'assets/images/icon_password_login.png',
                                              fit: BoxFit.contain,
                                            )),
                                        Container(
                                          height: 100.h,
                                          width: 0.7.sw,
                                          child: TextField(
                                            style: TextStyle(fontSize: 50.sp),
                                            controller: passwordController,
                                            obscureText: true,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              border: InputBorder.none,
                                              hintText: 'PASSWORD'.tr(),
                                              hintStyle: TextStyle(
                                                  fontSize: 50.sp,
                                                  height: 1.6,
                                                  color: Constants
                                                      .COLORS_PRIMARY_COLOR),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 45.h,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      if (nameController.value.text.length !=
                                              0 &&
                                          passwordController
                                                  .value.text.length !=
                                              0) {
                                        email = nameController.value.text;
                                        password =
                                            passwordController.value.text;
                                        EasyLoading.show(status: 'loading...');
                                        login(ctx);
                                        // Navigator.pop(context);
                                      } else {
                                        ScaffoldMessenger.of(ctx)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                              'MAKE_SURE_EMAIL_NOT_EMPTY'.tr()),
                                        ));
                                      }
                                    },
                                    child: Container(
                                      height: 110.h,
                                      width: 0.8.sw,
                                      decoration: BoxDecoration(
                                        color: Constants.COLORS_PRIMARY_COLOR,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                      ),
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 10, 0),
                                      child: Center(
                                        child: Text(
                                          'LOGIN'.tr(),
                                          style: TextStyle(
                                              fontSize: 50.sp,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  ForgetPasswordPage()));
                                    },
                                    child: Text(
                                      'FORGET_PASSWORD'.tr(),
                                      style: TextStyle(
                                          fontSize: 50.sp,
                                          color:
                                              Constants.COLORS_PRIMARY_COLOR),
                                    ),
                                  ),
                                  Text('CONNECT_WITH'.tr(),
                                      style: TextStyle(fontSize: 40.sp)),
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                  Container(
                                    width: 0.6.sw,
                                    height: 100.h,
                                    child: ElevatedButton.icon(
                                        onPressed: () async {
                                          facebookLogin(ctx);
                                          // LoginPage.of(context).setLocale(Locale.fromSubtags(languageCode: 'cn'));
                                          // print('inside');
                                          // prefs =
                                          //     await SharedPreferences.getInstance();
                                          // prefs.setString(
                                          //     Constants.PREF_LANGUAGE, 'cn');
                                        },
                                        icon: Image.asset(
                                          'assets/images/square_facebook.png',
                                          height: 75.w,
                                          width: 75.w,
                                          fit: BoxFit.contain,
                                        ),
                                        label: Text(
                                          'LOGIN_FACEBOOK'.tr(),
                                          style: TextStyle(fontSize: 35.sp),
                                        )),
                                  ),
                                  Platform.isAndroid
                                      ? SizedBox(
                                          height: 0.h,
                                        )
                                      : SizedBox(
                                          height: 20.h,
                                        ),
                                  Platform.isAndroid
                                      ? Container()
                                      : Container(
                                          height: 100.h,
                                          width: 0.6.sw,
                                          child: SignInWithAppleButton(
                                            onPressed: () async {
                                              appleLogin(ctx);
                                            },
                                          ),
                                        ),
                                  SizedBox(
                                    height: 200.h,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text('DONT_HAVE_ACCOUNT'.tr(),
                                          style: TextStyle(fontSize: 35.sp)),
                                      TextButton(
                                        child: Text(
                                          'SIGN_UP'.tr(),
                                          style: TextStyle(
                                              fontSize: 35.sp,
                                              color: Constants
                                                  .COLORS_PRIMARY_COLOR),
                                        ),
                                        onPressed: () {
                                          Navigator.of(ctx).push(
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      SignUpPage()));
                                          //signup screen
                                        },
                                      )
                                    ],
                                    mainAxisAlignment: MainAxisAlignment.center,
                                  ),
                                ]),
                              )
                            ],
                          ),
                        ),
                      )),
                )),
          ),
        ));
  }

  facebookLogin(BuildContext ctx) async {
    // final result = await FacebookAuth.instance.login();
    // print(result);

    final LoginResult result = await FacebookAuth.instance.login(permissions: [
      'email'
    ]); // by default we request the email and the public profile
    // or FacebookAuth.i.login()
    if (result.status == LoginStatus.success) {
      // you are logged
      final AccessToken accessToken = result.accessToken!;
      final userData = await FacebookAuth.i.getUserData(
        fields: "name,email,id",
      );
      loginFacebook(userData['email'], userData['name'], userData['id'], ctx);
    } else {
      print(result.status);
      print(result.message);
    }
  }

  appleLogin(BuildContext ctx) async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
    setState(() {
      _loading = true;
    });
    String name = credential.familyName.toString() +
        ' ' +
        credential.givenName.toString();
    String email = credential.email.toString();
    String token = credential.userIdentifier.toString();

    Map<String, String> requestHeaders = {'deviceid': "finalToken"};
    Map<String, String> requestBody = {
      'email': email,
      'name': name,
      'apple_id': token,
    };

    var responseData = await ApiCall().post(
        arg: requestBody,
        method: Constants.NETWORK_LOGIN_APPLE +
            '?email=$email&apple_id=$token=&name=$name',
        header: requestHeaders,
        context: context);
    if (responseData.code == 200) {
      prefs = await SharedPreferences.getInstance();
      prefs.setBool(Constants.PREF_LOGIN, true);
      prefs.setString(Constants.PREF_DEVICE_ID, finalToken);
      prefs.setString(Constants.PREF_TOKEN, responseData.data['token']);
      prefs.setString(Constants.PREF_ID, responseData.data['id'].toString());
      prefs.setString(Constants.PREF_EMAIL, responseData.data['email']);
      prefs.setString(Constants.PREF_NAME, responseData.data['name']);
      prefs.setString(
          Constants.PREF_PHONE, responseData.data['phone'].toString());

      // Navigator.pop(context, true);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => home()));
    } else {
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        content: Text(responseData.message),
      ));
    }
  }

  getToken() {
    // FirebaseMessaging.instance.getToken().then((token) {
    //   finalToken = token.toString();
    // });
  }

  loginFacebook(
      String email, String name, String token, BuildContext ctx) async {
    setState(() {
      _loading = true;
    });
    Map<String, String> requestHeaders = {'deviceid': "finalToken"};
    Map<String, String> requestBody = {
      'email': email,
      'name': name,
      'fb_id': token,
    };
    var responseData = await ApiCall().post(
        arg: requestBody,
        method: Constants.NETWORK_LOGIN_FB +
            '?email=$email&fb_id$token=&name=$name',
        header: requestHeaders,
        context: context);
    if (responseData.code == 200) {
      prefs = await SharedPreferences.getInstance();
      prefs.setBool(Constants.PREF_LOGIN, true);
      prefs.setString(Constants.PREF_DEVICE_ID, finalToken);
      prefs.setString(Constants.PREF_TOKEN, responseData.data['token']);
      prefs.setString(Constants.PREF_ID, responseData.data['id'].toString());
      prefs.setString(Constants.PREF_EMAIL, responseData.data['email']);
      prefs.setString(Constants.PREF_NAME, responseData.data['name']);
      prefs.setString(
          Constants.PREF_PHONE, responseData.data['phone'].toString());

      // Navigator.pop(context, true);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => home()));
    } else {
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        content: Text(responseData.message),
      ));
    }
  }

  login(BuildContext ctx) async {
    Map<String, String> requestHeaders = {'deviceid': "finalToken"};

    Map<String, String> requestBody = {
      'email': email,
      'password': password,
    };

    var responseData = await ApiCall().post(
        arg: requestBody,
        method: Constants.NETWORK_LOGIN,
        header: requestHeaders,
        context: context);
    if (responseData.code == 200) {
      prefs = await SharedPreferences.getInstance();
      prefs.setBool(Constants.PREF_LOGIN, true);
      prefs.setString(Constants.PREF_DEVICE_ID, finalToken);
      prefs.setString(Constants.PREF_TOKEN, responseData.data['token']);
      prefs.setString(Constants.PREF_ID, responseData.data['id'].toString());
      prefs.setString(Constants.PREF_EMAIL, responseData.data['email']);
      prefs.setString(Constants.PREF_NAME, responseData.data['name']);
      prefs.setString(
          Constants.PREF_PHONE, responseData.data['phone'].toString());

      // Navigator.pop(context, true);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => home()));
    } else {
      print(responseData.message);
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        content: Text(responseData.message),
      ));
      // prefs = await SharedPreferences.getInstance();
      // prefs.setBool(Constants.PREF_LOGIN, true);
      // Navigator.pop(context);
    }

    EasyLoading.dismiss();
  }
}
