import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Constants {
  // static const String SUCCESS_MESSAGE=" You will be contacted by us very soon.";
  static const int COLORS_ = 0xFFbfeb91;
  static const Color COLORS_PRIMARY_COLOR = Color(0xff62b7c5);
  static const Color COLORS_FONT_TITLE = Color(0xff62b7c5);
  static const Color COLORS_PRIMARY_ORANGE_COLOR = Color(0xffec8314);
  static const Color COLORS_FONT_DESC = Color.fromARGB(255, 98, 178, 190);

  static const String NETWORK_URL = "https://beez2u.com/";
  // static const String NETWORK_URL = "https://ready2code.beez2u.com/";

  static const String PREF_ = "pref";
  static const String PREF_LOGIN = "isLogin";
  static const String PREF_ID = "id";
  static const String PREF_NAME = "name";
  static const String PREF_TOKEN = "token";
  static const String PREF_DEVICE_ID = "deviceid";
  static const String PREF_EMAIL = "email";
  static const String PREF_PHONE = "phone";
  static const String PREF_LANGUAGE = "language";
  static const String PREF_DISPLAY_ADS = "displayAds";

  static const String NETWORK_ = "network";
  static const String NETWORK_LOGIN = "auth/login";
  static const String NETWORK_LOGIN_FB = "auth/loginfb";
  static const String NETWORK_LOGIN_APPLE = "auth/loginapple";
  static const String NETWORK_LOGOUT = "auth/logout";
  static const String NETWORK_REGISTER = "auth/register";
  static const String NETWORK_GET_REWARD = "orders/getreward";
  static const String NETWORK_GET_USER_DATA = "auth/userdata";
  static const String NETWORK_GET_VENDOR_LIST = "vendor/list?";
  static const String NETWORK_STORE_POINT = "orders/storepoint";
  static const String NETWORK_STORE_BOOKING = "vendor/createBooking";
  static const String NETWORK_FORGET_PASSWORD = "auth/forgotpassword";
  static const String NETWORK_CHANGE_PASSWORD = "auth/changepassword";
  static const String NETWORK_UPDATE_PROFILE = "auth/updateprofile";
  static const String NETWORK_DELETE_ACCOUNT = "auth/deleteaccount";
  static const String NETWORK_CHECKOUT_CART = "vendor/checkoutcart";
  static const String NETWORK_GET_VENDOR_FC_LIST = "vendor/getVendorList?";
  static const String NETWORK_GET_BOOKING_LIST = "vendor/getBookingList";

  static const String NETWORK_GET_EVENT_DETAILS = "vendor/getEventDetails/";
  static const String NETWORK_GET_FOLLOW_LIST = "vendor/getFollowList";
  static const String NETWORK_GET_EVENT_LIST = "vendor/getEventList";
  static const String NETWORK_POST_FOLLOW = "vendor/followMerchant";
  static const String NETWORK_POST_JOIN_EVENT = "vendor/joinEvent";

  static const String ERROR_MSG_ENTER_EMAIL = "Please enter email";
  static const String ERROR_MSG_INVALID_EMAIL = "Invalid email";
  static const String ERROR_MSG_EMPTY_USERNAME_PASSWORD =
      "Please make sure username and password is not empty";

  static const String SUCCESS_MSG_CREATE_ACCOUNT =
      "Successfully create account";

  static const String LABEL_SUCCESSFUL_PAYMENT = "Successful payment";
  static const String LABEL_FAILED_PAYMENT = "Payment failed";

  static const String LABEL_OLD_PASSWORD = "Old Password";
  static const String LABEL_NEW_PASSWORD = "New Password";
  static const String LABEL_CONFIRM_PASSWORD = "Confirm Password";

  static const String LABEL_CHANGE_PASSWORD = "Change Password";
  static const String LABEL_CHANGE_YOUR_PASSWORD = "Change Your Password";
  static const String LABEL_CHANGE_PASSWORD_REMINDER =
      "In order to keep your account safe \n  you need to create a strong password.";

  static String NETWORK_GET_VENDOR_ITEMS(String id) {
    String url = 'vendor/$id/items';
    return url;
  }

  static String NETWORK_GET_BOOKING_DATA(String id, String date) {
    String url = 'vendor/getBookingData?restorant_id=$id&date=$date';
    return url;
  }

  static const String NETWORK_GET_QR_ORDER_DETAILS = "orders/getqrdetails/";
}
