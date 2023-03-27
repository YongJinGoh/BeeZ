import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Widget/main_title_bar.dart';
import '../Widget/password_condition_text.dart';
import '../Widget/text_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Widget/api_calling.dart';
import '../Utils/constants.dart';
import 'package:easy_localization/easy_localization.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePasswordPage> {
  bool _loading = false;

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController =
      TextEditingController();

  bool _isObscureOldPass = true;
  bool _isObscureNewPass = true;
  bool _isObscureConfirmPass = true;

  String oldPassword = '';
  String password = '';
  String passwordConfirmation = '';

  bool _amountChecking = false;
  bool _specialChecking = false;
  bool _numberChecking = false;
  bool _capsChecking = false;
  bool _passwordMatching = false;

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 1.sw,
                        height: 720.h,
                        color: Constants.COLORS_PRIMARY_COLOR,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          MainTitleBar(
                              title: 'CHANGE_PASSWORD'.tr(),
                              action: () => Navigator.pop(context)),
                          SizedBox(
                            height: 5.h,
                          ),
                          Image.asset(
                            'assets/images/appicon_changePassword.png',
                            width: 360.w,
                            height: 360.w,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            'CHANGE_PASSWORD'.tr(),
                            style:
                                TextStyle(fontSize: 40.sp, color: Colors.white),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            'PASSWORD_REMINDER'.tr(),
                            style:
                                TextStyle(fontSize: 40.sp, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 50.h,
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 650.h),
                        width: 1.sw,
                        height: 90.h,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40)),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20.w, 0, 20.w, 0),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                        ),
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4),
                          child: Center(
                            child: TextField(
                              style: TextStyle(fontSize: 40.sp),
                              controller: oldPasswordController,
                              obscureText: _isObscureOldPass,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                labelText: 'OLD_PASSWORD'.tr(),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isObscureOldPass
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isObscureOldPass = !_isObscureOldPass;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4),
                          child: Center(
                            child: TextField(
                              style: TextStyle(fontSize: 40.sp),
                              controller: passwordController,
                              obscureText: _isObscureNewPass,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                labelText: 'NEW_PASSWORD'.tr(),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isObscureNewPass
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isObscureNewPass = !_isObscureNewPass;
                                    });
                                  },
                                ),
                              ),
                              onChanged: (text) {
                                checkForPassword(text);
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4),
                          child: Center(
                            child: TextField(
                              style: TextStyle(fontSize: 40.sp),
                              controller: passwordConfirmationController,
                              obscureText: _isObscureConfirmPass,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                labelText: 'CONFIRM_PASSWORD'.tr(),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isObscureConfirmPass
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isObscureConfirmPass =
                                          !_isObscureConfirmPass;
                                    });
                                  },
                                ),
                              ),
                              onChanged: (text) {
                                checkSimilarity(text);
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 30.w,
                            ),
                            Text('NEW_PASSWORD_CONTAIN'.tr(),
                                style: TextStyle(fontSize: 40.sp)),
                          ],
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        _amountChecking
                            ? PasswordConditionText(
                                title: 'AT_LEAST_CHARACTERS'.tr(),
                                imageAsset:
                                    'assets/images/appicon_greendot-01.png',
                              )
                            : PasswordConditionText(
                                title: 'AT_LEAST_CHARACTERS'.tr(),
                                imageAsset:
                                    'assets/images/appicon_reddot-01.png',
                              ),
                        _capsChecking
                            ? PasswordConditionText(
                                title: 'AT_LEAST_UPPER_CASE'.tr(),
                                imageAsset:
                                    'assets/images/appicon_greendot-01.png',
                              )
                            : PasswordConditionText(
                                title: 'AT_LEAST_UPPER_CASE'.tr(),
                                imageAsset:
                                    'assets/images/appicon_reddot-01.png',
                              ),
                        _numberChecking
                            ? PasswordConditionText(
                                title: 'AT_LEAST_NUMBER'.tr(),
                                imageAsset:
                                    'assets/images/appicon_greendot-01.png',
                              )
                            : PasswordConditionText(
                                title: 'AT_LEAST_NUMBER'.tr(),
                                imageAsset:
                                    'assets/images/appicon_reddot-01.png',
                              ),
                        _specialChecking
                            ? PasswordConditionText(
                                title: 'AT_LEAST_SPECIAL'.tr(),
                                imageAsset:
                                    'assets/images/appicon_greendot-01.png',
                              )
                            : PasswordConditionText(
                                title: 'AT_LEAST_SPECIAL'.tr(),
                                imageAsset:
                                    'assets/images/appicon_reddot-01.png',
                              ),
                        _passwordMatching
                            ? PasswordConditionText(
                                title: 'PASSWORD_MATCH'.tr(),
                                imageAsset:
                                    'assets/images/appicon_greendot-01.png',
                              )
                            : PasswordConditionText(
                                title: 'PASSWORD_MATCH'.tr(),
                                imageAsset:
                                    'assets/images/appicon_reddot-01.png',
                              ),
                        SizedBox(
                          height: 20.h,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 0.8.sw,
                    child: ElevatedButton(
                      onPressed: () {
                        oldPassword = oldPasswordController.value.text;
                        password = passwordController.value.text;
                        passwordConfirmation =
                            passwordConfirmationController.value.text;

                        if (oldPassword.length == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('MAKE_SURE_OLD_PASS_NOT_EMPTY'.tr()),
                          ));
                        } else {
                          if (!_specialChecking ||
                              !_numberChecking ||
                              !_capsChecking ||
                              !_amountChecking) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('MEET_PASSWORD_REQUIREMENT'.tr()),
                            ));
                          } else if (password != passwordConfirmation) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('MAKE_SURE_BOTH_PASS_MATCH'.tr()),
                            ));
                          } else {
                            changePassword();
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        elevation: 15.0,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'CHANGE_PASSWORD'.tr(),
                          style: TextStyle(fontSize: 40.sp),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }

  checkForPassword(String password) {
    RegExp capsRegex = RegExp(r'^(?=.*?[A-Z])');
    RegExp specialRegex = RegExp(r'^(?=.*?[!@#\-?/+$&*~])');
    RegExp numRegex = RegExp(r'^(?=.*?[0-9])');
    RegExp amountRegex = RegExp(r'^.{8,}');

    if (!capsRegex.hasMatch(password)) {
      _capsChecking = false;
    } else {
      _capsChecking = true;
    }

    if (!specialRegex.hasMatch(password)) {
      _specialChecking = false;
    } else {
      _specialChecking = true;
    }
    if (!numRegex.hasMatch(password)) {
      _numberChecking = false;
    } else {
      _numberChecking = true;
    }
    if (!amountRegex.hasMatch(password)) {
      _amountChecking = false;
    } else {
      _amountChecking = true;
    }

    setState(() {});
  }

  checkSimilarity(String confirmPass) {
    String getNewPassword = passwordController.value.text;

    if (getNewPassword == confirmPass) {
      _passwordMatching = true;
    } else {
      _passwordMatching = false;
    }
    setState(() {});
  }

  changePassword() async {
    _loading = true;

    Map<String, String> requestHeaders = {};

    Map<String, String> requestBody = {
      'old_password': oldPassword,
      'password': password,
      'password_confirmation': passwordConfirmation,
    };

    var responseData = await ApiCall().post(
        arg: requestBody,
        method: Constants.NETWORK_CHANGE_PASSWORD,
        header: requestHeaders,
        context: context);

    if (responseData.code == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(responseData.message),
      ));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(responseData.message),
      ));
      // Navigator.pop(context);
    }
  }
}
