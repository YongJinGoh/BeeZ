import 'package:equatable/equatable.dart';

class QrResult extends Equatable {
  final String merchantName;
  final String orderId;
  final String amount;
  final String timeDate;
  final String qrFrom;

  //qrFrom 0 = default(payment), 1 = event,
  QrResult({merchantName, orderId, amount, timeDate, qrFrom})
      : merchantName = merchantName ?? '',
        orderId = orderId ?? '',
        amount = amount ?? '',
        timeDate = timeDate ?? '',
        qrFrom = qrFrom ?? '0';

  @override
  List<Object?> get props => [merchantName, orderId, amount, timeDate];

  static QrResult fromJson(Map<String, dynamic> json) => QrResult(
        merchantName: json['merchant_name'].toString(),
        orderId: json['order_id'].toString(),
        amount: json['amount'].toString(),
        timeDate: json['timedate'].toString(),
        qrFrom: json['qrFrom'].toString(),
      );

  Map<String, dynamic> toJson() => {
        'merchantName': merchantName,
        'orderId': orderId,
        'amount': amount,
        'timeDate': timeDate,
        'qrFrom': qrFrom,
      };
}
