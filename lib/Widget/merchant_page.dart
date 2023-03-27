import 'dart:convert';
import '../home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Widget/setting_single_image.dart';
import '../Widget/search_input.dart';
import '../Widget/setting_single_image_vertical.dart';
import '../Widget/merchant_sorting_bar.dart';
import '../Widget/merchant_category_grid.dart';
import '../Widget/merchant_category.dart';
import '../Widget/merchant_list_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Widget/api_calling.dart';
import '../Widget/api_result.dart';
import '../Model/merchant_model.dart';
import '../Model/other_category_model.dart';
import '../Utils/constants.dart';
import 'package:easy_localization/easy_localization.dart';

// class MerchantPage extends StatefulWidget {
//   String? data;
//   MerchantPage({this.data});
//
//   @override
//   _MerchantPageState createState() => _MerchantPageState();
// }
//
// class _MerchantPageState extends State<MerchantPage> {
//   @override
//   Widget build(BuildContext context) {
//     String? test = widget.data;
//     return Container();
//   }
// }

class MerchantPage extends StatefulWidget {
  static final navKey = new GlobalKey<NavigatorState>();

  @override
  _MerchantPageState createState() => _MerchantPageState();
}

class _MerchantPageState extends State<MerchantPage> {
  late Future<List<MerchantModel>> _tasks;
  List<MerchantModel> lists = [];
  bool _isLoading = false;
  bool _isError = false;
  bool _isSearch = false;
  bool _isEmpty = false;
  String searchString = '';
  var searchTextController = TextEditingController();
  String selected = '';
  List<OtherCategory> otherCategoryLists = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      _tasks = getdatafromserver(searchString);
      setUpList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting &&
              snapshot.hasData == null) {
            return SizedBox.expand(
                child: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Container(
                            height: 360.h,
                            color: Constants.COLORS_PRIMARY_COLOR,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 40.h),
                            child: Text(
                              'MERCHANT'.tr(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 66.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: 20.h),
                                //Pass in empty search from here then update for search later.
                                SearchInput(
                                  textController: searchString,
                                  onTap: () => search(),
                                ),
                              ]),
                          Container(
                            margin: EdgeInsets.only(top: 200.h),
                            child: MerchantCategory(
                              selected: selected,
                              onTap: () => searchViaCategory(selected, context),
                            ),
                          ),
                        ],
                      ),
                      MerchantSortingBar(
                        onTap: () => viewAll(),
                      ),
                      // Container(child: Text('No internet'),),
                    ],
                  )),
            ));
          }
          return Scaffold(
              backgroundColor: Colors.transparent,
              resizeToAvoidBottomInset: true,
              extendBodyBehindAppBar: true,
              body: Builder(
                builder: (ctx) => Container(
                    child: SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: Container(
                      color: Colors.white,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              Container(
                                height: 500.h,
                                color: Constants.COLORS_PRIMARY_COLOR,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 60.h),
                                child: Text(
                                  'MERCHANT'.tr(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 68.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 180.h),
                                    SearchInput(
                                      textController: searchTextController,
                                      onTap: () => search(),
                                    ),
                                  ]),
                              Container(
                                margin: EdgeInsets.only(top: 350.h),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40)),
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.all(10),
                                    child: IntrinsicHeight(
                                      child: Column(
                                        children: <Widget>[
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              MerchantCategoryGrid(
                                                data: 'CATEGORY_FNB'.tr(),
                                                image:
                                                    'assets/images/main-cat-icon-f&b.png',
                                                maxLine: 2,
                                                fSize: 46.sp,
                                                onTap: () => searchViaCategory(
                                                    'F&B', context),
                                              ),
                                              VerticalDivider(
                                                width: 4,
                                                thickness: 1,
                                              ),
                                              //update icon here
                                              MerchantCategoryGrid(
                                                data: 'CATEGORY_AUTO'.tr(),
                                                image:
                                                    'assets/images/icon_automotive.png',
                                                maxLine: 1,
                                                fSize: 46.sp,
                                                onTap: () => searchViaCategory(
                                                    'automobile', context),
                                              ),
                                              VerticalDivider(
                                                width: 4,
                                                thickness: 1,
                                              ),
                                              MerchantCategoryGrid(
                                                data: 'CATEGORY_BEAUTY'.tr(),
                                                image:
                                                    'assets/images/main-cat-icon-beauty.png',
                                                maxLine: 1,
                                                fSize: 46.sp,
                                                onTap: () => searchViaCategory(
                                                    'beauty', context),
                                              ),
                                              VerticalDivider(
                                                width: 4,
                                                thickness: 1,
                                              ),
                                              MerchantCategoryGrid(
                                                data: 'CATEGORY_FITNESS'.tr(),
                                                image:
                                                    'assets/images/main-cat-icon-fitness.png',
                                                maxLine: 1,
                                                fSize: 12,
                                                onTap: () => searchViaCategory(
                                                    'fitness', context),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          Row(
                                            children: [
                                              MerchantCategoryGrid(
                                                data: 'CATEGORY_HEALTH'.tr(),
                                                image:
                                                    'assets/images/main-cat-icon-health.png',
                                                maxLine: 1,
                                                fSize: 46.sp,
                                                onTap: () => searchViaCategory(
                                                    'health', context),
                                              ),
                                              VerticalDivider(
                                                width: 4,
                                                thickness: 1,
                                              ),
                                              MerchantCategoryGrid(
                                                data: 'CATEGORY_CHARITY'.tr(),
                                                image:
                                                    'assets/images/main-cat-icon-holiday.png',
                                                maxLine: 1,
                                                fSize: 46.sp,
                                                onTap: () => searchViaCategory(
                                                    'charity', context),
                                              ),
                                              VerticalDivider(
                                                width: 4,
                                                thickness: 1,
                                              ),
                                              MerchantCategoryGrid(
                                                data: 'CATEGORY_HOUSE_SERVICE'
                                                    .tr(),
                                                image:
                                                    'assets/images/main-cat-icon-houseService.png',
                                                maxLine: 1,
                                                fSize: 46.sp,
                                                onTap: () => searchViaCategory(
                                                    'services', context),
                                              ),
                                              VerticalDivider(
                                                width: 4,
                                                thickness: 1,
                                              ),
                                              MerchantCategoryGrid(
                                                data: 'CATEGORY_OTHERS'.tr(),
                                                image:
                                                    'assets/images/main-cat-icon-others.png',
                                                maxLine: 1,
                                                fSize: 46.sp,
                                                onTap: () => searchViaCategory(
                                                    'others', context),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          MerchantSortingBar(
                            onTap: () => viewAll(),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          // CircularProgressIndicator(),
                          _isLoading
                              ? CircularProgressIndicator()
                              : _isError
                                  ? Dialog(
                                      child: Padding(
                                        padding: EdgeInsets.all(20),
                                        child:
                                            Text('NO_INTERNET_CONNECTION'.tr()),
                                      ),
                                    )
                                  : _isEmpty
                                      ? Dialog(
                                          child: Padding(
                                            padding: EdgeInsets.all(20),
                                            child: Text(
                                                'ALERT_NO_ITEM_AT_THIS_MOMENT'
                                                    .tr()),
                                          ),
                                        )
                                      : ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: lists.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            MerchantModel merchant =
                                                lists[index];
                                            return MerchantListItem(
                                                data: merchant);
                                          },
                                        )
                        ],
                      )),
                )),
              ));
        },
        future: _tasks);
  }

  setUpCategoryDialog(
      List<OtherCategory> otherCategoryLists, BuildContext ctx) {
    showDialog(
        context: ctx,
        useRootNavigator: false,
        builder: (_) {
          return AlertDialog(
              title: GestureDetector(
                  onTap: () {
                    Navigator.of(ctx).pop();
                    searchViaSub(otherCategoryLists[0].name);
                  },
                  child: Text(otherCategoryLists[0].name,
                      style: TextStyle(fontSize: 50.sp))),
              content: Container(
                  width: double.maxFinite,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: otherCategoryLists.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      return otherCategoryLists[index].header
                          ? Container(
                              height: 0,
                              width: 0,
                            )
                          : GestureDetector(
                              onTap: () {
                                Navigator.pop(ctx);
                                searchViaSubCat(otherCategoryLists[index].name);
                              },
                              child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 10.h),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        otherCategoryLists[index].picture,
                                        width: 75.w,
                                        height: 75.w,
                                        fit: BoxFit.fitWidth,
                                      ),
                                      SizedBox(
                                        width: 15.w,
                                      ),
                                      Text(
                                        otherCategoryLists[index].name,
                                        style: TextStyle(fontSize: 44.sp),
                                      )
                                    ],
                                  )),
                            );
                    },
                  )));
        });
  }

  setUpList() {}

  viewAll() {
    searchTextController = TextEditingController(text: '');
    getdatafromserver('');
  }

  setUpListFitness() {
    otherCategoryLists.clear();

    otherCategoryLists.add(OtherCategory(
        header: true,
        name: 'Fitness & classes',
        picture: 'assets/images/appicon_services.png'));
    otherCategoryLists.add(OtherCategory(
        header: false, name: 'Gym', picture: 'assets/images/subicon_gym.png'));
    otherCategoryLists.add(OtherCategory(
        header: false,
        name: 'Studio',
        picture: 'assets/images/subicon_studio_dance.png'));
    otherCategoryLists.add(OtherCategory(
        header: false,
        name: 'Yoga',
        picture: 'assets/images/subicon_yoga.png'));
  }

  setUpListHealth() {
    otherCategoryLists.clear();

    otherCategoryLists.add(OtherCategory(
        header: true,
        name: 'Health',
        picture: 'assets/images/appicon_services.png'));
    otherCategoryLists.add(OtherCategory(
        header: false,
        name: 'Clinic',
        picture: 'assets/images/subicon_clinic.png'));
    otherCategoryLists.add(OtherCategory(
        header: false,
        name: 'Dentist',
        picture: 'assets/images/subicon_dentist.png'));
  }

  setUpListHoliday() {
    otherCategoryLists.clear();

    otherCategoryLists.add(OtherCategory(
        header: true,
        name: 'Holiday',
        picture: 'assets/images/appicon_services.png'));
    otherCategoryLists.add(OtherCategory(
        header: false,
        name: 'Activities',
        picture: 'assets/images/subicon_themePark.png'));
    otherCategoryLists.add(OtherCategory(
        header: false,
        name: 'Hotel',
        picture: 'assets/images/subicon_hotel.png'));
  }

  setUpListService() {
    otherCategoryLists.clear();

    otherCategoryLists.add(OtherCategory(
        header: true,
        name: 'House services',
        picture: 'assets/images/appicon_services.png'));
    otherCategoryLists.add(OtherCategory(
        header: false,
        name: 'Cleaning',
        picture: 'assets/images/subicon_maidCleaning.png'));
    otherCategoryLists.add(OtherCategory(
        header: false,
        name: 'Lighting',
        picture: 'assets/images/subicon_lighting.png'));
    otherCategoryLists.add(OtherCategory(
        header: false,
        name: 'Moving',
        picture: 'assets/images/subicon_housemoving.png'));
    otherCategoryLists.add(OtherCategory(
        header: false,
        name: 'Plumber',
        picture: 'assets/images/subicon_plumber.png'));
    otherCategoryLists.add(OtherCategory(
        header: false,
        name: 'Renovation',
        picture: 'assets/images/subicon_renovation.png'));
  }

  setUpListCar() {
    otherCategoryLists.clear();

    otherCategoryLists.add(OtherCategory(
        header: true,
        name: 'Auto',
        picture: 'assets/images/appicon_services.png'));
    otherCategoryLists.add(OtherCategory(
        header: false,
        name: 'Accessories',
        picture: 'assets/images/subicon_accesories.png'));
    otherCategoryLists.add(OtherCategory(
        header: false,
        name: 'Tinted',
        picture: 'assets/images/subicon_tinted.png'));
    otherCategoryLists.add(OtherCategory(
        header: false,
        name: 'Wash',
        picture: 'assets/images/subicon_carWash.png'));
    otherCategoryLists.add(OtherCategory(
        header: false,
        name: 'Workshop',
        picture: 'assets/images/subicon_workShop.png'));
  }

  setUpListBeauty() {
    otherCategoryLists.clear();

    otherCategoryLists.add(OtherCategory(
        header: true,
        name: 'Beauty',
        picture: 'assets/images/appicon_services.png'));
    otherCategoryLists.add(OtherCategory(
        header: false,
        name: 'Beauty saloon',
        picture: 'assets/images/subicon_facial.png'));
    otherCategoryLists.add(OtherCategory(
        header: false,
        name: 'Embroidery',
        picture: 'assets/images/subicon_Embroidery.png'));
    otherCategoryLists.add(OtherCategory(
        header: false,
        name: 'Hair saloon',
        picture: 'assets/images/subicon_hairCut.png'));
    otherCategoryLists.add(OtherCategory(
        header: false,
        name: 'Nail saloon',
        picture: 'assets/images/subicon_nailBeauty.png'));
    otherCategoryLists.add(OtherCategory(
        header: false, name: 'Spa', picture: 'assets/images/subicon_spa.png'));
  }

  setUpListFnB() {
    otherCategoryLists.clear();

    otherCategoryLists.add(OtherCategory(
        header: true,
        name: 'F&B',
        picture: 'assets/images/appicon_services.png'));
    otherCategoryLists.add(OtherCategory(
        header: false,
        name: 'Asian',
        picture: 'assets/images/subicon_assian.png'));
    otherCategoryLists.add(OtherCategory(
        header: false,
        name: 'Beverage',
        picture: 'assets/images/subicon_beverage.png'));
    otherCategoryLists.add(OtherCategory(
        header: false,
        name: 'Bistro',
        picture: 'assets/images/subicon_bistro.png'));
    otherCategoryLists.add(OtherCategory(
        header: false,
        name: 'Chinese',
        picture: 'assets/images/subicon_chineseFood.png'));
    otherCategoryLists.add(OtherCategory(
        header: false,
        name: 'Dessert',
        picture: 'assets/images/subicon_dassert.png'));
    otherCategoryLists.add(OtherCategory(
        header: false,
        name: 'HotPot/Steamboat',
        picture: 'assets/images/subicon_hotpot.png'));
    otherCategoryLists.add(OtherCategory(
        header: false,
        name: 'Korean',
        picture: 'assets/images/subicon_korean.png'));
    otherCategoryLists.add(OtherCategory(
        header: false,
        name: 'Western',
        picture: 'assets/images/subicon_western.png'));
  }

  Future<List<MerchantModel>> getdatafromserver(String search) async {
    lists = [];
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });
      Map<String, String> requestHeaders = {};
      String searchParam = '';
      if (search.length != 0) {
        searchParam = 'search=' + search;
      }

      var hmmm = await ApiCall().get(
          arg: requestHeaders,
          method: Constants.NETWORK_GET_VENDOR_LIST + searchParam,
          header: requestHeaders,
          context: context);

      List<Merchant> merchants = [];

      if (hmmm.code == 200) {
        hmmm.data['sections'].forEach((mer) {
          mer['restorants'].forEach((res) {
            if (mer['title'] == "Food Courts") {
              String categoryName = '';
              try {
                mer['restorants'].forEach((cat) {
                  categoryName = cat['name'];
                });
              } on Exception catch (e) {
                categoryName = '';
              }
              lists.add(MerchantModel.fromJson(res, true, categoryName));
            } else {
              lists.add(MerchantModel.fromJson(res, false, ''));
            }
          });
          merchants.add(Merchant.fromJson(mer, lists));
        });

        setState(() {
          _isLoading = false;
          _isError = false;
          lists = lists;
        });
        // Iterable l = json.decode(hmmm.data['sections']['restorants']);
        // List<MerchantModel> posts =
      } else {
        _isLoading = false;
        _isError = true;
      }

      print(lists.length);

      if (lists.isEmpty) {
        _isEmpty = true;
      } else {
        _isEmpty = false;
      }

      print(_isEmpty);

      setState(() {
        lists = lists;
      });
    }

    return lists;
  }

  Future<List<MerchantModel>> getdatafromserverSubCategory(
      String search) async {
    lists = [];
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });
      Map<String, String> requestHeaders = {};
      String searchParam = '';
      if (search.length != 0) {
        searchParam = 'merchant_subcategory=' + search;
      }

      var returnData = await ApiCall().get(
          arg: requestHeaders,
          method: Constants.NETWORK_GET_VENDOR_LIST + searchParam,
          header: requestHeaders,
          context: context);

      List<Merchant> merchants = [];

      if (returnData.code == 200) {
        returnData.data['sections'].forEach((mer) {
          mer['restorants'].forEach((res) {
            mer['restorants'].forEach((res) {
              if (mer['title'] == "Food Courts") {
                String categoryName = '';
                try {
                  mer['restorants'].forEach((cat) {
                    categoryName = cat['name'];
                  });
                } on Exception catch (e) {
                  categoryName = '';
                }
                lists.add(MerchantModel.fromJson(res, true, categoryName));
              } else {
                lists.add(MerchantModel.fromJson(res, false, ''));
              }
            });
          });
          merchants.add(Merchant.fromJson(mer, lists));
        });
        _isLoading = false;
        _isError = false;
        // Iterable l = json.decode(hmmm.data['sections']['restorants']);
        // List<MerchantModel> posts =
      } else {
        _isLoading = false;
        _isError = true;
      }

      print(lists.length);

      if (lists.isEmpty) {
        _isEmpty = true;
      } else {
        _isEmpty = false;
      }

      print(_isEmpty);

      setState(() {
        searchTextController = TextEditingController(text: search);
        lists = lists;
      });

      _isLoading = false;
    }

    return lists;
  }

  Future<List<MerchantModel>> getdatafromserverCategory(String search) async {
    lists = [];
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });
      Map<String, String> requestHeaders = {};
      String searchParam = '';
      if (search.length != 0) {
        searchParam = 'merchant_category=' + search;
      }

      var returnData = await ApiCall().get(
          arg: requestHeaders,
          method: Constants.NETWORK_GET_VENDOR_LIST + searchParam,
          header: requestHeaders,
          context: context);

      List<Merchant> merchants = [];

      if (returnData.code == 200) {
        returnData.data['sections'].forEach((mer) {
          mer['restorants'].forEach((res) {
            if (mer['title'] == "Food Courts") {
              String categoryName = '';
              try {
                mer['restorants'].forEach((cat) {
                  categoryName = cat['name'];
                });
              } on Exception catch (e) {
                categoryName = '';
              }
              lists.add(MerchantModel.fromJson(res, true, categoryName));
            } else {
              lists.add(MerchantModel.fromJson(res, false, ''));
            }
          });
          merchants.add(Merchant.fromJson(mer, lists));
        });
        _isLoading = false;
        _isError = false;
      } else {
        _isLoading = false;
        _isError = true;
      }

      if (lists.isEmpty) {
        _isEmpty = true;
      } else {
        _isEmpty = false;
      }

      setState(() {
        if (search == 'F%26B') {
          searchTextController = TextEditingController(text: 'F&B');
        } else {
          searchTextController = TextEditingController(text: search);
        }
        lists = lists;
      });

      _isLoading = false;
    }

    return lists;
  }

  search() async {
    String searchText = searchTextController.text;
    getdatafromserver(searchText);
  }

  searchViaSub(String subCategory) async {
    searchTextController = TextEditingController(text: subCategory);
    if (subCategory == 'F&B') {
      getdatafromserverCategory('F%26B');
    } else {
      getdatafromserverCategory(subCategory);
    }
  }

  searchViaSubCat(String subCategory) async {
    searchTextController = TextEditingController(text: subCategory);
    getdatafromserverSubCategory(subCategory);
  }

  searchViaCategory(String pass, BuildContext ctx) async {
    if (pass == 'F&B') {
      getdatafromserverCategory('F%26B');
      // setUpListFnB();
      // setUpCategoryDialog(otherCategoryLists, ctx);
    } else if (pass == 'automobile') {
      getdatafromserverCategory('auto');
      // setUpListCar();
      // setUpCategoryDialog(otherCategoryLists, ctx);
    } else if (pass == 'fitness') {
      getdatafromserverCategory('fitness');
      // setUpListFitness();
      // setUpCategoryDialog(otherCategoryLists, ctx);
    } else if (pass == 'beauty') {
      getdatafromserverCategory('beauty');
      // setUpListBeauty();
      // setUpCategoryDialog(otherCategoryLists, ctx);
    } else if (pass == 'services') {
      getdatafromserverCategory('house services');
      // setUpListService();
      // setUpCategoryDialog(otherCategoryLists, ctx);
    } else if (pass == 'fashion') {
      getdatafromserverCategory('fashion');
      // setUpListBeauty();
      // setUpCategoryDialog(otherCategoryLists, ctx);
    } else if (pass == 'holiday') {
      getdatafromserverCategory('holiday');
      // setUpListHoliday();
      // setUpCategoryDialog(otherCategoryLists, ctx);
    } else if (pass == 'health') {
      getdatafromserverCategory('health');
      // setUpListHealth();
      // setUpCategoryDialog(otherCategoryLists, ctx);
    } else if (pass == 'charity') {
      getdatafromserverCategory('charity');
      // setUpListHealth();
      // setUpCategoryDialog(otherCategoryLists, ctx);
    } else {
      getdatafromserverCategory(pass);
    }
  }
}
