import 'package:equatable/equatable.dart';

class EventModel extends Equatable {
  final String id;
  final String eventName;
  final String restaurantId;
  final String eventStartDate;
  final String eventEndDate;
  final String registerStartDate;
  final String registerEndDate;
  final String eventStartTime;
  final String eventEndTime;
  final String eventDesc;
  final String picture;
  final String restaurantName;
  final String eventCode;
  final String active;

  EventModel(
      {id,
      eventName,
      restaurantId,
      eventStartDate,
      eventEndDate,
      registerStartDate,
      registerEndDate,
      eventStartTime,
      eventEndTime,
      eventDesc,
      picture,
      restaurantName,
      eventCode,
      active})
      : id = id ?? '',
        eventName = eventName ?? '',
        restaurantId = restaurantId ?? '',
        eventStartDate = eventStartDate ?? '',
        eventEndDate = eventEndDate ?? '',
        registerStartDate = registerStartDate ?? '',
        registerEndDate = registerEndDate ?? '',
        eventStartTime = eventStartTime ?? '',
        eventEndTime = eventEndTime ?? '',
        eventDesc = eventDesc ?? '',
        picture = picture ?? '',
        restaurantName = restaurantName ?? '',
        eventCode = eventCode ?? '',
        active = active ?? '';

  @override
  List<Object?> get props => [
        id,
        eventName,
        eventName,
        eventStartDate,
        eventEndDate,
        registerStartDate,
        registerEndDate,
        eventStartTime,
        eventEndTime,
        eventDesc,
        picture,
        restaurantName,
        eventCode,
        active
      ];

  static EventModel fromJson(Map<String, dynamic> json) => EventModel(
        id: json['id'].toString(),
        eventName: json['event_name'].toString(),
        restaurantId: json['restorant_id'].toString(),
        eventStartDate: json['event_start_date'].toString(),
        eventEndDate: json['event_end_date'].toString(),
        registerStartDate: json['register_start_date'].toString(),
        registerEndDate: json['register_end_date'].toString(),
        eventStartTime: json['event_start_time'].toString(),
        eventEndTime: json['event_end_time'].toString(),
        eventDesc: json['event_desc'].toString(),
        picture: json['icon'].toString(),
        restaurantName: json['restorant_name'].toString(),
        eventCode: json['event_code'].toString(),
        active: json['active'].toString(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'eventName': eventName,
        'restaurantId': restaurantId,
        'eventStartDate': eventStartDate,
        'eventEndDate': eventEndDate,
        'registerStartDate': registerStartDate,
        'registerEndDate': registerEndDate,
        'eventStartTime': eventStartTime,
        'eventEndTime': eventEndTime,
        'eventDesc': eventDesc,
        'picture': picture,
        'restaurantName': restaurantName,
        'eventCode': eventCode,
        'active': active
      };
}
