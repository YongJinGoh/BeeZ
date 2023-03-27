import 'package:equatable/equatable.dart';

class CommunityDisplayData extends Equatable {
  final String restorant_id;
  final String restorant_name;
  final String icon;
  final String desc;

  CommunityDisplayData({
    restorant_id,
    restorant_name,
    icon,
    desc,
  })  : restorant_id = restorant_id ?? '',
        restorant_name = restorant_name ?? '',
        icon = icon ?? '',
        desc = desc ?? '';

  @override
  List<Object?> get props => [restorant_id, restorant_name];

  static CommunityDisplayData fromJson(Map<String, dynamic> json) =>
      CommunityDisplayData(
        restorant_id: json['restorant_id'].toString(),
        restorant_name: json['restorant_name'].toString(),
        icon: json['booking_icon'].toString(),
        desc: json['restorant_desc'].toString(),
      );
}
