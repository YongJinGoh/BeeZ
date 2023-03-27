import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RewardsTabBar extends StatelessWidget {
  const RewardsTabBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Container(
        child: TabBar(
          indicator: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            color: Colors.orangeAccent,
          ),
          indicatorWeight: 2,
          indicatorColor: Colors.orangeAccent,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.black,
          tabs: [
            Tab(
              child: Text(
                "All",
                style: TextStyle(fontSize: 35.sp),
              ),
            ),
            Tab(
              child: Text(
                "Rewards",
                style: TextStyle(fontSize: 35.sp),
              ),
            ),
            Tab(
              child: Text(
                "Request",
                style: TextStyle(fontSize: 35.sp),
              ),
            ),
            Tab(
              child: Text(
                "History",
                style: TextStyle(fontSize: 35.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
