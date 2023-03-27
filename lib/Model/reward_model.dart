import 'package:equatable/equatable.dart';

class Reward extends Equatable {
  final String title;
  final List<RewardModel> lists;

  Reward({
    title,
    lists,
  })  : title = title ?? '',
        lists = lists ?? [];

  @override
  List<Object?> get props => [title, lists];

  static Reward fromJson(Map<String, dynamic> json, lists) => Reward(
        title: json['title'].toString(),
        lists: lists,
      );
}

class RewardModel extends Equatable {
  final String id;
  final String name;
  final String points;
  final String deductPoints;
  final String refNo;
  final String date;
  final String logo;

  RewardModel({
    id,
    name,
    points,
    deductPoints,
    refNo,
    date,
    logo,
  })  : id = id ?? '',
        name = name ?? '',
        points = points ?? '',
        deductPoints = deductPoints ?? '',
        refNo = refNo ?? '',
        logo = logo ?? '',
        date = date ?? '';

  @override
  List<Object?> get props =>
      [id, name, points, deductPoints, refNo, logo, date];

  static RewardModel fromJson(Map<String, dynamic> json) => RewardModel(
        id: json['id'].toString(),
        name: json['merchant'].toString(),
        points: json['add_point'].toString(),
        deductPoints: json['deduct_point'].toString(),
        refNo: json['ref_no'].toString(),
        logo: json['logo'].toString(),
        date: json['created_date'].toString(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'points': points,
        'deductPoints': deductPoints,
        'refNo': refNo,
        'logo': logo,
        'date': date,
      };
}

class VoucherModel extends Equatable {
  final String voucherCode;
  final String voucherType;
  final String voucherValue;
  final String expiryDate;
  final String voucherStatus;
  final String discountType;
  final String tnc;
  final String merchantName;
  final String voucherTitle;

  VoucherModel(
      {voucherCode,
      voucherType,
      voucherValue,
      expiryDate,
      voucherStatus,
      discountType,
      tnc,
      merchantName,
      voucherTitle})
      : voucherCode = voucherCode ?? '',
        voucherType = voucherType ?? '',
        voucherValue = voucherValue ?? '',
        expiryDate = expiryDate ?? '',
        voucherStatus = voucherStatus ?? '',
        discountType = discountType ?? '',
        tnc = tnc ?? '',
        merchantName = merchantName ?? '',
        voucherTitle = voucherTitle ?? '';

  @override
  List<Object?> get props => [
        voucherCode,
        voucherType,
        voucherValue,
        expiryDate,
        voucherStatus,
        discountType,
        tnc,
        merchantName,
        voucherTitle
      ];

  static VoucherModel fromJson(Map<String, dynamic> json) => VoucherModel(
        voucherCode: json['voucher_code'].toString(),
        voucherType: json['voucher_type'].toString(),
        voucherValue: json['voucher_value'].toString(),
        expiryDate: json['expiry_date'].toString(),
        voucherStatus: json['voucher_status'].toString(),
        discountType: json['discount_type'].toString(),
        tnc: json['voucher_tnc'].toString(),
        merchantName: json['merchant_name'].toString(),
        voucherTitle: json['voucher_title'].toString(),
      );

  Map<String, dynamic> toJson() => {
        'voucherCode': voucherCode,
        'voucherType': voucherType,
        'voucherValue': voucherValue,
        'expiryDate': expiryDate,
        'voucherStatus': voucherStatus,
        'discountType': discountType,
        'tnc': tnc,
        'merchantName': merchantName,
        'voucherTitle': voucherTitle,
      };
}
