import 'package:equatable/equatable.dart';

class MerchantDetails extends Equatable {
  final String id;
  final String title;
  // final String cover;
  // final String workingHour;
  // final String lat;
  // final String lng;
  // final String desc;
  final List<MerchantDetailsModel> lists;

  MerchantDetails({
    id,
    title,
    // cover,
    // workingHour,
    // lat,
    // lng,
    // desc,
    lists,
  })  : id = id ?? '',
        title = title ?? '',
        // cover = cover ?? '',
        // workingHour = workingHour ?? '',
        // lat = lat ?? '',
        // lng = lng ?? '',
        // desc = desc ?? '',
        lists = lists ?? [];

  @override
  List<Object?> get props =>
      [id, title, lists];

  static MerchantDetails fromJson(Map<String, dynamic> json, lists) =>
      MerchantDetails(
        id: json['id'].toString(),
        title: json['name'].toString(),
        // cover: json['cover'].toString(),
        // workingHour: json['working_hour'].toString(),
        // lat: json['lat'].toString(),
        // lng: json['lng'].toString(),
        // desc: json['description'].toString(),
        lists: lists,
      );
}

class MerchantDetailsModel extends Equatable {
  final String id;
  final String name;
  final String picture;
  final String desc;
  final String price;

  MerchantDetailsModel({
    id,
    name,
    picture,
    desc,
    price,
  })  : id = id ?? '',
        name = name ?? '',
        picture = picture ?? '',
        desc = desc ?? '',
        price = price ?? '';

  @override
  List<Object?> get props => [id, name, picture, desc, price];

  static MerchantDetailsModel fromJson(Map<String, dynamic> json) =>
      MerchantDetailsModel(
        id: json['id'].toString(),
        name: json['name'].toString(),
        picture: json['icon'].toString(),
        desc: json['description'].toString(),
        price: json['price'].toString(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'icon': picture,
        'desc': desc,
        'price': price,
      };
}
