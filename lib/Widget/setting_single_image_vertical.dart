import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingSingleImageVertical extends StatelessWidget {
  late String data;
  late String image;
  var nextPage;
  // final Function() updateParent;
  final void Function() onTap;

  SettingSingleImageVertical(
      {required this.data,
      required this.image,
      this.nextPage,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      // onTap: () => {
      //   if (data == 'Logout')
      //     {
      //       updateParent()
      //     }
      //   else{
      //     Navigator.of(context).push(MaterialPageRoute(builder: (_) => nextPage))
      //   }
      // },
      child: Container(
        width: 0.3.sw,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRect(
              child: Image.asset(
                image,
                width: 140.w,
                height: 140.w,
                fit: BoxFit.fitWidth,
              ),
            ),
            Center(
              child: Text(data,
                  style: TextStyle(
                    fontSize: 40.sp,
                    color: Colors.black,
                  ),
                  softWrap: false,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
      ),
    );
  }
}
