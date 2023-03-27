import 'package:equatable/equatable.dart';

class OtherCategory extends Equatable {
  final bool header;
  final String name;
  final String picture;

  OtherCategory({
    header,
    name,
    picture,
  })  : header = header ?? '',
        picture = picture ?? '',
        name = name ?? '';

  @override
  List<Object?> get props => [header, name, picture];

  static OtherCategory fromJson(Map<String, dynamic> json) => OtherCategory(
        header: json['header'].toString(),
        picture: json['picture'].toString(),
        name: json['name'].toString(),
      );

  Map<String, dynamic> toJson() => {
        'header': header,
        'name': name,
        'picture': picture,
      };
}
