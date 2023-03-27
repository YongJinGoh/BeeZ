import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Widget/api_calling.dart';
import '../Utils/constants.dart';
import 'package:localization/localization.dart';
import 'package:easy_localization/easy_localization.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String name = '';
  String email = '';
  String phone = '';
  String password = '';
  String referral = '';

  bool _loading = false;
  late SharedPreferences prefs;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController referralController = TextEditingController();

  getSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          extendBodyBehindAppBar: true,
          body: Builder(
              builder: (ctx) => Container(
                    color: Constants.COLORS_PRIMARY_COLOR,
                    child: SafeArea(
                      left: false,
                      right: false,
                      bottom: false,
                      child: SingleChildScrollView(
                        physics: ScrollPhysics(),
                        child: Container(
                            height: 1.sh,
                            width: 1.sw,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/login_bg.png'),
                                  fit: BoxFit.fill),
                            ),
                            child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      width: 1.sw,
                                      child: Stack(
                                        children: [
                                          GestureDetector(
                                            child: Icon(Icons.arrow_back,
                                                color: Colors.white),
                                            onTap: () => Navigator.pop(context),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 100.h,
                                    ),
                                    Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                          'SIGN_UP'.tr(),
                                          style: TextStyle(
                                              fontSize: 60.sp,
                                              color: Colors.white),
                                        )),
                                    SizedBox(
                                      height: 200.h,
                                    ),
                                    Container(
                                      height: 110.h,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 12),
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
                                                'assets/images/icon_username_login.png',
                                                fit: BoxFit.contain,
                                              )),
                                          Expanded(
                                            child: TextField(
                                              style: TextStyle(fontSize: 50.sp),
                                              controller: nameController,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: 'NAME'.tr(),
                                                hintStyle: TextStyle(
                                                    color: Constants
                                                        .COLORS_PRIMARY_COLOR,
                                                    fontSize: 50.sp),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30.h,
                                    ),
                                    Container(
                                      height: 110.h,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 12),
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
                                                'assets/images/icon_email_login.png',
                                                fit: BoxFit.contain,
                                              )),
                                          Expanded(
                                            child: TextField(
                                              style: TextStyle(fontSize: 50.sp),
                                              controller: emailController,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText:
                                                    'EMAIL_USE_AS_LOGIN'.tr(),
                                                hintStyle: TextStyle(
                                                    color: Constants
                                                        .COLORS_PRIMARY_COLOR,
                                                    fontSize: 50.sp),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30.h,
                                    ),
                                    Container(
                                      height: 110.h,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 12),
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
                                                'assets/images/icon_phone_login.png',
                                                fit: BoxFit.contain,
                                              )),
                                          Expanded(
                                            child: TextField(
                                              style: TextStyle(fontSize: 50.sp),
                                              controller: phoneController,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: 'PHONE'.tr(),
                                                hintStyle: TextStyle(
                                                    color: Constants
                                                        .COLORS_PRIMARY_COLOR,
                                                    fontSize: 50.sp),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30.h,
                                    ),
                                    Container(
                                      height: 110.h,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 12),
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
                                          Expanded(
                                            child: TextField(
                                              style: TextStyle(fontSize: 50.sp),
                                              obscureText: true,
                                              controller: passwordController,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: 'PASSWORD'.tr(),
                                                hintStyle: TextStyle(
                                                    color: Constants
                                                        .COLORS_PRIMARY_COLOR,
                                                    fontSize: 50.sp),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30.h,
                                    ),
                                    Container(
                                      height: 110.h,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 12),
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
                                          Expanded(
                                            child: TextField(
                                              style: TextStyle(fontSize: 50.sp),
                                              obscureText: true,
                                              controller:
                                                  confirmPasswordController,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText:
                                                    'CONFIRM_PASSWORD'.tr(),
                                                hintStyle: TextStyle(
                                                    color: Constants
                                                        .COLORS_PRIMARY_COLOR,
                                                    fontSize: 50.sp),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30.h,
                                    ),
                                    Container(
                                      height: 110.h,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 12),
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
                                                'assets/images/icon_email_login.png',
                                                fit: BoxFit.contain,
                                              )),
                                          Expanded(
                                            child: TextField(
                                              style: TextStyle(fontSize: 50.sp),
                                              controller: referralController,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: 'REFERRAL_EMAIL'.tr(),
                                                hintStyle: TextStyle(
                                                    color: Constants
                                                        .COLORS_PRIMARY_COLOR,
                                                    fontSize: 50.sp),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 45.h,
                                    ),
                                    Container(
                                        height: 110.h,
                                        width: 0.8.sw,
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 0, 10, 0),
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                            ),
                                          ),
                                          child: Text('SIGN_UP'.tr(),
                                              style:
                                                  TextStyle(fontSize: 50.sp)),
                                          onPressed: () async {
                                            bool emailValid = RegExp(
                                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                .hasMatch(
                                                    emailController.value.text);
                                            if (emailValid) {
                                              if (emailController
                                                          .value.text.length !=
                                                      0 &&
                                                  passwordController
                                                          .value.text.length !=
                                                      0 &&
                                                  confirmPasswordController
                                                          .value.text.length !=
                                                      0) {
                                                if (passwordController.value ==
                                                    confirmPasswordController
                                                        .value) {
                                                  name =
                                                      nameController.value.text;
                                                  email = emailController
                                                      .value.text;
                                                  password = passwordController
                                                      .value.text;
                                                  phone = phoneController
                                                      .value.text;
                                                  referral = referralController
                                                      .value.text;
                                                  register(ctx);
                                                } else {
                                                  ScaffoldMessenger.of(ctx)
                                                      .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'PASSWORD_DONT_MATCH'
                                                            .tr()),
                                                  ));
                                                }
                                              } else {
                                                ScaffoldMessenger.of(ctx)
                                                    .showSnackBar(SnackBar(
                                                  content: Text(
                                                      'MAKE_SURE_EMAIL_NOT_EMPTY'
                                                          .tr()),
                                                ));
                                              }
                                            } else {
                                              ScaffoldMessenger.of(ctx)
                                                  .showSnackBar(SnackBar(
                                                content:
                                                    Text('INVALID_EMAIL'.tr()),
                                              ));
                                            }
                                          },
                                        )),
                                  ],
                                ))),
                      ),
                    ),
                  ))),
    );
  }

  register(BuildContext ctx) async {
    _loading = true;

    Map<String, String> requestHeaders = {};

    Map<String, String> requestBody = {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'referral': referral,
    };

    var responseData = await ApiCall().post(
        arg: requestBody,
        method: Constants.NETWORK_REGISTER,
        header: requestHeaders,
        context: context);

    if (responseData.code == 200) {
      ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
        content: Text(Constants.SUCCESS_MSG_CREATE_ACCOUNT),
      ));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        content: Text(responseData.message),
      ));
    }
  }
}
