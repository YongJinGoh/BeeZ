import 'package:equatable/equatable.dart';

class BookingDisplayData extends Equatable {
  final String time;
  final String slot;
  final String date;
  final String remark;
  final String restaurantName;

  BookingDisplayData({
    time,
    slot,
    date,
    remark,
    restaurantName,
  })  : time = time ?? '',
        slot = slot ?? '',
        date = date ?? '',
        remark = remark ?? '',
        restaurantName = restaurantName ?? '';

  @override
  List<Object?> get props => [time, slot];

  static BookingDisplayData fromJson(Map<String, dynamic> json) =>
      BookingDisplayData(
        time: json['time'].toString(),
        slot: json['slot'].toString(),
        date: json['booking_date'].toString(),
        remark: json['remark'].toString(),
        restaurantName: json['restorant_name'].toString(),
      );
}
