import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Widget/main_title_bar.dart';
import '../Widget/password_condition_text.dart';
import '../Widget/text_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:image_picker/image_picker.dart';
import '../Widget/api_calling.dart';
import '../Utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';
import 'package:easy_localization/easy_localization.dart';

class ProfileDetailsPage extends StatefulWidget {
  late String name;
  late String email;
  late String phone;

  ProfileDetailsPage(
      {required this.name, required this.email, required this.phone});

  @override
  _ProfileDetailsState createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetailsPage> {
  late SharedPreferences prefs;
  late BuildContext dialogContext;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  String fullName = '';
  String email = '';
  String phoneNo = '';

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      nameController = TextEditingController(text: widget.name);
      emailController = TextEditingController(text: widget.email);
      phoneController = TextEditingController(text: removeNumber(widget.phone));
    });
  }

  removeNumber(String number) {
    String getInitials(String bank_account_name) => bank_account_name.isNotEmpty
        ? bank_account_name.trim().split(' ').map((l) => l[0]).take(2).join()
        : '';
    if (getInitials(number) == '0') {
      number = number.substring(1);
    }
    return number;
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
                height: 1.sw,
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
                            height: 660.h,
                            color: Constants.COLORS_PRIMARY_COLOR,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              MainTitleBar(
                                  title: 'Profile'.tr(),
                                  action: () => Navigator.pop(context)),
                              SizedBox(
                                height: 50.h,
                              ),
                              GestureDetector(
                                onTap: () {
                                  getProfilePicture();
                                },
                                child: Container(
                                  child: CircleAvatar(
                                    backgroundImage: AssetImage(
                                        'assets/images/appicon_profile_highres.png'),
                                  ),
                                  width: 400.w,
                                  height: 400.w,
                                ),
                              ),
                              SizedBox(
                                height: 50.h,
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 590.h),
                            width: 1.sw,
                            height: 75.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40)),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10.h,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              child: TextFormField(
                                style: TextStyle(fontSize: 50.sp),
                                controller: nameController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.fromLTRB(
                                      20.0, 10.0, 20.0, 10.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  labelText: 'NAME'.tr(),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              child: TextFormField(
                                style: TextStyle(fontSize: 50.sp),
                                controller: emailController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.fromLTRB(
                                      20.0, 10.0, 20.0, 10.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  labelText: 'EMAIL'.tr(),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              child: IntlPhoneField(
                                style: TextStyle(fontSize: 50.sp),
                                controller: phoneController,
                                initialValue: removeNumber(widget.phone),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.fromLTRB(
                                      20.0, 10.0, 20.0, 10.0),
                                  labelText: 'PHONE'.tr(),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                initialCountryCode: 'MY',
                                disableLengthCheck: true,
                                onChanged: (phone) {
                                  phoneNo = phone.completeNumber;
                                },
                              ),
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
                            fullName = nameController.value.text;
                            email = emailController.value.text;

                            updateProfile();
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Constants.COLORS_PRIMARY_COLOR,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            elevation: 15.0,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'UPDATE'.tr(),
                              style: TextStyle(fontSize: 50.sp),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(primary: Colors.red),
                          onPressed: () async {
                            await showDialog(
                              context: context,
                              builder: (context) {
                                dialogContext = context;
                                return AlertDialog(
                                  title: Text(
                                    'CONFIRMATION'.tr(),
                                    style: TextStyle(fontSize: 50.sp),
                                  ),
                                  content: Text(
                                    'DELETE_ACCOUNT_CONFIRMATION_MSG'.tr(),
                                    style: TextStyle(fontSize: 50.sp),
                                  ),
                                  actions: <Widget>[
                                    new TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(dialogContext);
                                      },
                                      child: Text(
                                        'NO'.tr(),
                                        style: TextStyle(fontSize: 50.sp),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        deleteAccount();
                                      },
                                      child: Text(
                                        'YES'.tr(),
                                        style: TextStyle(fontSize: 50.sp),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          icon: Icon(
                            Icons.delete,
                            size: 20,
                            color: Colors.white,
                          ),
                          label: Text(
                            'DELETE_ACCOUNT'.tr(),
                            style: TextStyle(fontSize: 50.sp),
                          ))
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }

  deleteAccount() async {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });

      Map<String, String> requestHeaders = {};

      Map<String, String> bodyArg = {};

      var returnData = await ApiCall().post(
          arg: bodyArg,
          method: Constants.NETWORK_DELETE_ACCOUNT,
          header: requestHeaders,
          context: context);

      if (returnData.code == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(returnData.message),
        ));
        prefs = await SharedPreferences.getInstance();

        prefs.setBool(Constants.PREF_LOGIN, false);
        prefs.setString(Constants.PREF_TOKEN, '');
        prefs.setString(Constants.PREF_ID, '');
        prefs.setString(Constants.PREF_NAME, '');
        prefs.setString(Constants.PREF_EMAIL, '');
        prefs.setString(Constants.PREF_PHONE, '');

        Navigator.of(context).pop(dialogContext);
        // logOut();
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
        setState(() {
          // Navigaxtor.of(context).pop(dialogContext);
        });
      }
    }
  }

  updateProfile() async {
    if (!_isLoading) {
      _isLoading = true;
      Map<String, String> requestHeaders = {};

      if (phoneNo.length == 0) {
        phoneNo = phoneController.value.text;
      }

      Map<String, String> bodyArg = {
        'name': fullName,
        'email': email,
        'phone': addNumber(phoneNo)
      };

      var returnData = await ApiCall().post(
          arg: bodyArg,
          method: Constants.NETWORK_UPDATE_PROFILE,
          header: requestHeaders,
          context: context);

      if (returnData.code == 200) {
        prefs = await SharedPreferences.getInstance();
        prefs.setString(Constants.PREF_PHONE, addNumber(phoneNo));
        prefs.setString(Constants.PREF_EMAIL, email);
        prefs.setString(Constants.PREF_NAME, fullName);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(returnData.message),
        ));

        Navigator.pop(context, true);
      } else {
        _isLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(returnData.message),
        ));
      }

      _isLoading = false;
    }
  }

  getProfilePicture() async {
    // image_picker: ^0.8.5
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    // // Capture a photo
    // final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    // // Pick a video
    // final XFile? image = await _picker.pickVideo(source: ImageSource.gallery);
    // // Capture a video
    // final XFile? video = await _picker.pickVideo(source: ImageSource.camera);
    // // Pick multiple images
    // final List<XFile>? images = await _picker.pickMultiImage();
    String path = image!.path;
  }

  addNumber(String number) {
    String getInitials(String bank_account_name) => bank_account_name.isNotEmpty
        ? bank_account_name.trim().split(' ').map((l) => l[0]).take(2).join()
        : '';
    if (getInitials(number) == '+') {
      number = number.substring(1);
    }
    if (getInitials(number) == '6') {
      number = number.substring(1);
    }
    if (getInitials(number) != '0') {
      number = '0' + number;
    }
    return number;
  }
}
