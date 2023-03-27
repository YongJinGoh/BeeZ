import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Model/merchant_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:io' as Platform;

class MerchantToolbarItem extends StatelessWidget {
  late String data;
  late String image;
  var nextPage;
  final void Function() onTap;

  MerchantToolbarItem(
      {required this.data,
      required this.image,
      required this.nextPage,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
          onTap: () {
            if (data == 'Call') {
              _callNumber(nextPage);
            } else if (data == 'Direction') {
              MerchantModel merchantModel = nextPage;
              _openMap(double.parse(merchantModel.lat),
                  double.parse(merchantModel.lng));
            } else if (data == 'Social Media') {
              onTap();
              // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //   content: Text("Social Media clicked"),
              // ));
            } else {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => nextPage));
            }
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRect(
                child: Image.asset(
                  image,
                  height: 30.h,
                  fit: BoxFit.fitWidth,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Flexible(
                child: Text(data,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.blue[900],
                    ),
                    softWrap: false,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
              ),
            ],
          )),
    );
  }

  void _callNumber(String number) async {
    String url = "tel://" + number;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not call $number';
    }
  }

  void _openMap(double lat, double lng) async {
    // var uri = Uri.parse("google.navigation:q=$lat,$lng&mode=d");
    String uri = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
    } else {
      throw 'Could not launch ${uri.toString()}';
    }
  }

  // if (size == 1) {
  //   return SimpleDialog(
  //     title: const Text('Social Media'),
  //     children: [widgetList[0]],
  //   );
  // } else if (size == 2) {
  //   return SimpleDialog(
  //     title: const Text('Social Media'),
  //     children: [widgetList[0], widgetList[1]],
  //   );
  // } else {
  //   return const SimpleDialog(
  //     title:  Text('Social Media'),
  //     children: [],
  //   );
  // }
}
