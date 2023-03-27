import 'package:equatable/equatable.dart';

class RestApiResult extends Equatable {
  final bool status;
  final int? code;
  final dynamic message;
  final dynamic data;

  const RestApiResult({
    required this.status,
    this.code,
    this.message,
    this.data,
  });

  @override
  List<Object?> get props => [status, code, message, data];

  @override
  String toString() =>
      "RestApiResult { status: $status, code: $code, message: ${message.toString()}, data: ${data.toString()}}";
}