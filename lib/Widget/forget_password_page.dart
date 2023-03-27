import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/constants.dart';
import '../Widget/api_calling.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  String email = '';
  bool _loading = false;
  late SharedPreferences prefs;

  TextEditingController emailController = TextEditingController();

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
                  width: 1.sw,
                  height: 0.95.sh,
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 140.h,
                        width: 1.sw,
                        child: Stack(
                          children: [
                            Container(
                              height: 140.h,
                              width: 1.sw,
                              color: Constants.COLORS_PRIMARY_COLOR,
                            ),
                            Align(
                              alignment: AlignmentDirectional.topCenter,
                              child: Container(
                                margin: EdgeInsets.only(top: 40.h),
                                child: Text(
                                  'Forget Password',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 59.sp),
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Align(
                                  alignment: AlignmentDirectional.topStart,
                                  child: Container(
                                    margin:
                                        EdgeInsets.only(left: 40.w, top: 20.h),
                                    width: 100.w,
                                    height: 100.w,
                                    child: Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      Text(
                        'Enter your email below to reset your password.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 50.sp,
                            color: Constants.COLORS_PRIMARY_ORANGE_COLOR),
                      ),
                      SizedBox(
                        height: 60.h,
                      ),
                      Container(
                        color: Colors.white,
                        height: 155.h,
                        width: 1.sw,
                        padding: EdgeInsets.symmetric(horizontal: 40.w),
                        child: Center(
                          child: TextField(
                            keyboardType: TextInputType.text,
                            cursorColor: Constants.COLORS_PRIMARY_COLOR,
                            controller: emailController,
                            style: TextStyle(
                                fontSize: 40.sp,
                                color: Constants.COLORS_PRIMARY_COLOR),
                            decoration: InputDecoration(
                              isDense: true,
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(18.0)),
                                borderSide: BorderSide(
                                    color: Constants.COLORS_PRIMARY_COLOR),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(18.0)),
                                borderSide: BorderSide(
                                    color: Constants.COLORS_PRIMARY_COLOR),
                              ),
                              hintStyle: TextStyle(
                                color: Constants.COLORS_PRIMARY_COLOR,
                              ),
                              border: OutlineInputBorder(),
                              labelText: 'Email',
                              // fillColor: Constants.COLORS_PRIMARY_DARK_PINK,
                              labelStyle: TextStyle(
                                  fontSize: 40.sp,
                                  color: Constants.COLORS_PRIMARY_COLOR),
                            ),
                          ),
                        ),
                      ),
                      Expanded(child: Container()),
                      Container(
                          height: 110.h,
                          width: 0.8.sw,
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Constants.COLORS_PRIMARY_COLOR),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                            ),
                            child: Text(
                              'Forget password',
                              style: TextStyle(fontSize: 50.sp),
                            ),
                            onPressed: () {
                              bool emailValid = RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(emailController.value.text);
                              if (emailValid) {
                                EasyLoading.show(status: 'loading...');
                                email = emailController.value.text;
                                forgetPassword(ctx);
                              } else {
                                if (emailController.value.text.length == 0) {
                                  ScaffoldMessenger.of(ctx)
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                      'Please enter email',
                                    ),
                                  ));
                                } else {
                                  ScaffoldMessenger.of(ctx)
                                      .showSnackBar(SnackBar(
                                    content: Text('Invalid email'),
                                  ));
                                }
                              }
                            },
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  forgetPassword(BuildContext ctx) async {
    Map<String, String> requestHeaders = {};

    Map<String, String> requestBody = {
      'email': email,
    };

    var responseData = await ApiCall().post(
        arg: requestBody,
        method: Constants.NETWORK_FORGET_PASSWORD,
        header: requestHeaders,
        context: context);

    EasyLoading.dismiss();

    if (responseData.code == 200) {
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        content: Text(responseData.message),
      ));
      Future.delayed(
        Duration(seconds: 2),
        () {
          Navigator.of(context).pop(true);
        },
      );
    } else {
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        content: Text(responseData.message),
      ));
      // Navigator.pop(context);
    }
  }
}
