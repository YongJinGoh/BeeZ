import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import '../Widget/home_page.dart';
import '../Widget/profile_page.dart';
import '../Widget/blankQRScanPage.dart';
import '../Widget/rewards_page.dart';
import '../Widget/qr_scan_page.dart';
import '../Widget/login_page.dart';
import '../Widget/qr_result_page.dart';
import '../Widget/bottom_bar.dart';
import '../Widget/wallet_page.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import '../Widget/api_calling.dart';
import '../Widget/api_result.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/qr_scan_result_model.dart';
import 'Utils/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:app_links/app_links.dart';
import 'package:scan/scan.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:images_picker/images_picker.dart';

class home extends StatefulWidget {
  static final navKey = new GlobalKey<NavigatorState>();

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<home> {
  bool _isLogin = false;
  int lastClicked = 0;
  late SharedPreferences prefs;
  GlobalKey<ConvexAppBarState> _appBarKey = GlobalKey<ConvexAppBarState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  final _navigatorKey = GlobalKey<NavigatorState>();
  late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;

  ScanController controller = ScanController();
  String qrcode = 'Unknown';

  @override
  void initState() {
    super.initState();
    initDeepLinks();

    setState(() {
      // getdatafromserver();
      // getdatafromserver().whenComplete(() => print ('done d $returnData'));
      // returnData = ApiCall().post(method: 'method');
    });
  }

  Future<void> initDeepLinks() async {
    _appLinks = AppLinks();

    // Check initial link if app was in cold state (terminated)
    final appLink = await _appLinks.getInitialAppLink();
    if (appLink != null) {
      print('getInitialAppLink: $appLink');
      openAppLink(appLink);
    }

    // Handle link when app is in warm state (front or background)
    _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
      print('onAppLink: $uri');
      openAppLink(uri);
    });
  }

  void openAppLink(Uri uri) {
    _navigatorKey.currentState?.pushNamed(uri.fragment);
  }

  final List<Widget> _pages = [
    HomePage(),
    WalletPage(),
    QrBlankPage(),
    RewardsPage(),
    ProfilePage()
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScaffoldMessenger(
          key: scaffoldMessengerKey,
          child: Scaffold(
            key: _scaffoldKey,
            body: Container(
                color: Constants.COLORS_PRIMARY_COLOR,
                child: SafeArea(
                    left: false,
                    right: false,
                    bottom: false,
                    child: Container(
                        color: Colors.white, child: _pages[_selectedIndex]))),
            bottomNavigationBar: StyleProvider(
                style: Style(),
                child: ConvexAppBar(
                  height: 0.06.sh,
                  key: _appBarKey,
                  curveSize: 80,
                  top: -20,
                  style: TabStyle.fixed,
                  backgroundColor: Colors.white,
                  color: Colors.grey,
                  activeColor: Colors.orange,
                  items: [
                    TabItem(
                        icon: Image.asset('assets/images/appicon_home.png'),
                        title: 'BOTTOM_BAR_HOME'.tr(),
                        activeIcon: Image.asset(
                            'assets/images/appicon_home_active.png')),
                    TabItem(
                        icon: Image.asset('assets/images/appicon_merchant.png'),
                        title: 'WALLET'.tr(),
                        activeIcon: Image.asset(
                            'assets/images/appicon_merchant_active.png')),
                    TabItem(
                        icon: Image.asset(
                          'assets/images/appicon_qrcode.png',
                          width: 90.h,
                          height: 90.h,
                        ),
                        title: 'SCAN_QR'.tr()),
                    TabItem(
                        icon: Image.asset('assets/images/appicon_rewards.png'),
                        title: 'REWARDS'.tr(),
                        activeIcon: Image.asset(
                            'assets/images/appicon_rewards_active.png')),
                    TabItem(
                        icon: Image.asset('assets/images/appicon_settings.png'),
                        title: 'SETTINGS'.tr(),
                        activeIcon: Image.asset(
                            'assets/images/appicon_settings_active.png')),
                  ],
                  initialActiveIndex: 0,
                  //optional, default as 0
                  onTap: _onTap,
                )),
          )),
    );
  }

  getSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future _getLogin() async {
    prefs = await SharedPreferences.getInstance();
    _isLogin = prefs.getBool(Constants.PREF_LOGIN) ?? false;

    return _getLogin();
  }

  Future<void> _onTap(int index) async {
    if (index != 2) {
      lastClicked = index;
    }
    _selectedIndex = index;
    _appBarKey.currentState?.animateTo(_selectedIndex);
    if (_selectedIndex == 2) {
      goToScanPage();
      _onTap(0);
      // setState(() {});
    } else {
      if (_selectedIndex == 0) {
        setState(() {});
      } else if (_selectedIndex == 1) {
        setState(() {});
      } else if (_selectedIndex == 3) {
        setState(() {});
      } else if (_selectedIndex == 4) {
        prefs = await SharedPreferences.getInstance();
        bool isLogin = prefs.getBool(Constants.PREF_LOGIN) ?? false;

        if (isLogin) {
          setState(() {});
        } else {
          var result = await Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => LoginPage()));

          if (result == null) {
            _onTap(0);
          }

          if (result == true) {
            _onTap(4);
          }
        }
      }
    }
  }

  goToScanPage() {
    Navigator.of(context)
        .push(
          new MaterialPageRoute(builder: (_) => new QrScanPage()),
        )
        .then((val) => val ? print('inside 1 2 3') : toastmsg());

    // Navigator.push(context, MaterialPageRoute(builder: (_) {
    //   return QrScanPage();
    // }));
  }

  toastmsg() {
    print(
        '----------------------------------INSIDE -------------------------------------');

    scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
      content: Text('Invalid QR code'),
    ));
  }

  updatePage() async {
    prefs = await SharedPreferences.getInstance();
    bool isLogin = prefs.getBool(Constants.PREF_LOGIN) ?? false;
    _onTap(0);
    // if (!isLogin && lastClicked == 4) {
    //   _onTap(0);
    // } else {
    //   _onTap(lastClicked);
    // }
  }

  scanQrFromLibrary() async {
    List<Media>? res = await ImagesPicker.pick();
    if (res != null) {
      String? str = await Scan.parse(res[0].path);
      if (str != null) {
        setState(() {
          qrcode = str;
        });
      }
    }
  }

  Future<void> scanQRCode() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", "Cancel", false, ScanMode.QR);

    try {
      var result = QrResult.fromJson(jsonDecode(barcodeScanRes));
      if (result.orderId.length != 0) {
        var returnResult = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    new QrResultPage(data: result)));
        if (returnResult) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(Constants.LABEL_SUCCESSFUL_PAYMENT),
          ));
          _onTap(0);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(Constants.LABEL_FAILED_PAYMENT),
          ));
        }
      } else {
        _onTap(0);
      }
    } catch (error) {
      prefs = await SharedPreferences.getInstance();
      bool isLogin = prefs.getBool(Constants.PREF_LOGIN) ?? false;

      if (!isLogin && lastClicked == 4) {
        _onTap(0);
      } else {
        _onTap(lastClicked);
      }
    }
  }
}

class Style extends StyleHook {
  @override
  double get activeIconSize => 70.h;

  @override
  double get activeIconMargin => 0;

  @override
  double get iconSize => 50.h;

  @override
  TextStyle textStyle(Color color, String? textStyle) {
    return TextStyle(fontSize: 38.sp, color: color);
  }
}
