import 'package:equatable/equatable.dart';

class BookingData extends Equatable {
  final String time;
  final String slot;

  BookingData({
    time,
    slot,
  })  : time = time ?? '',
        slot = slot ?? '';

  @override
  List<Object?> get props => [time, slot];

  static BookingData fromJson(Map<String, dynamic> json) => BookingData(
        time: json['time'].toString(),
        slot: json['slot'].toString(),
      );
}
