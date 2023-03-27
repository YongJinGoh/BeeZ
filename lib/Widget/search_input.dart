import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'merchant_page.dart';
import 'package:easy_localization/easy_localization.dart';

class SearchInput extends StatelessWidget {
  var textController;
  final searchText = TextEditingController();
  String searchStr = '';
  final void Function() onTap;

  SearchInput({required this.textController, required this.onTap});
  // SearchInput({required this.addUser});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(right: 15, left: 15),
        child: Container(
          height: 100.h,
          child: TextField(
            style: TextStyle(fontSize: 50.sp),
            controller: textController,
            onSubmitted: (value) {
              searchStr = value;
            },
            onChanged: (value) {
              searchStr = value;
            },
            onEditingComplete: () {
              onTap();
              FocusScopeNode currentFocus = FocusScope.of(context);

              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 35, right: 35),
              isDense: true,
              filled: true,
              fillColor: Colors.white,
              prefixIcon: IconButton(
                onPressed: () {
                  onTap();
                },
                icon: Icon(Icons.search_rounded),
                color: Colors.black,
                iconSize: 20,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              hintText: 'SEARCH'.tr(),
            ),
          ),
        ));
  }
}
