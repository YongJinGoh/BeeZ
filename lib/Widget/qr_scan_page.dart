import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:scan/scan.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:images_picker/images_picker.dart';
import '../Widget/qr_result_page.dart';
import '../Model/qr_scan_result_model.dart';
import 'dart:async';
import 'dart:convert';
import '../Widget/main_title_bar.dart';

class QrScanPage extends StatefulWidget {
  // QrScanPage({required this.controller});

  @override
  _QrScanPageState createState() => _QrScanPageState();
}

class _QrScanPageState extends State<QrScanPage> {
  String qrcode = 'Unknown';
  ScanController controller = ScanController();

  @override
  void initState() {
    super.initState();
    setState(() {});
    // setState(() {
    //   getdatafromserver();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (() async {
        controller.pause();
        return true;
      }),
      child: SafeArea(
        child: SizedBox.expand(
          child: Container(
            color: Colors.black,
            width: 1.sw,
            height: 1.sh,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  MainTitleBar(
                      title: 'Scan QR',
                      action: () {
                        controller.pause();
                        Navigator.pop(context);
                      }),
                  SizedBox(
                    height: 200.h,
                  ),
                  Container(
                    width: 0.75.sw, // custom wrap size
                    height: 0.75.sw,
                    child: ScanView(
                      controller: controller,
                      scanAreaScale: .7,
                      scanLineColor: Colors.green.shade400,
                      onCapture: (data) async {
                        controller.pause();
                        try {
                          var result = QrResult.fromJson(jsonDecode(data));
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      new QrResultPage(data: result)));
                        } on Exception catch (e) {
                          Navigator.pop(context, false);
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 150.h,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      scanQRCodeFromLibrary();
                    },
                    child: Text(
                      'Pick QR from library',
                      style: TextStyle(fontSize: 50.sp),
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }

  Future<void> scanQRCode() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", "Cancel", false, ScanMode.QR);
  }

  Future<void> scanQRCodeFromLibrary() async {
    List<Media>? res = await ImagesPicker.pick();
    if (res != null) {
      String? str = await Scan.parse(res[0].path);

      if (str != null) {
        controller.pause();
        qrcode = str;
        try {
          var result = QrResult.fromJson(jsonDecode(qrcode));

          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      new QrResultPage(data: result)));
        } on Exception catch (e) {
          // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          //   content: Text(
          //     'Invalid QR code',
          //     style: TextStyle(color: Colors.white),
          //   ),
          // ));
          Navigator.pop(context, false);

          // print('1');
          // Future.delayed(Duration(milliseconds: 1000), () {

          // });
        }
      } else {
        Navigator.pop(context, false);
      }
    } else {
      Navigator.pop(context, false);
    }
  }
}
