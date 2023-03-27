import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class QrScanPage extends StatelessWidget {
  QrScanPage();

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      //   child: SingleChildScrollView(
      // physics: ScrollPhysics(),
      // child: Container(
      //     child: Column(
      //   mainAxisSize: MainAxisSize.min,
      //   mainAxisAlignment: MainAxisAlignment.start,
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   children: [
      //     Stack(
      //       alignment: Alignment.topCenter,
      //       children: [
      //         Container(
      //           height: 160.h,
      //           color: Colors.green,
      //         ),
      //         Padding(
      //           padding: EdgeInsets.only(top: 40.h),
      //           child: Text(
      //             "QR",
      //             style: TextStyle(
      //                 color: Colors.white,
      //                 fontSize: 22,
      //                 fontWeight: FontWeight.bold),
      //           ),
      //         ),
      //       ],
      //     ),
      //     SizedBox(
      //       height: 150.h,
      //     ),
      //     Container(
      //       padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 20.h),
      //       decoration: BoxDecoration(
      //         border: Border.all(
      //           color: Colors.white,
      //         ),
      //         borderRadius: BorderRadius.all(Radius.circular(10)),
      //         color: Colors.white),
      //       child: QrImage(
      //         data: "1234567890",
      //         version: QrVersions.auto,
      //         size: 250.0,
      //       ),
      //     ),
      //     SizedBox(height: 30.h),
      //     Text('Please present QR to merchant.',style: TextStyle(fontSize: 55.sp,),),
      //   ],
      // )),)
        );
  }

  Future<void> scanQRCode() async{
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode("#ff6666", "Cancel", false, ScanMode.QR);
  }

}
