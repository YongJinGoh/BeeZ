import 'package:equatable/equatable.dart';

class GetQrDetailsModel extends Equatable {
  final String id;
  final String status;
  final String created_date;
  final String voucher_amount;
  final String from;
  final String percent;
  final String use_point;
  final String giving;
  final String invoice_number;

  GetQrDetailsModel(
      {id,
      status,
      created_date,
      voucher_amount,
      from,
      percent,
      use_point,
      giving,
      invoice_number})
      : id = id ?? '',
        status = status ?? '',
        created_date = created_date ?? '',
        voucher_amount = voucher_amount ?? '',
        from = from ?? '',
        percent = percent ?? '',
        use_point = use_point ?? '',
        giving = giving ?? '',
        invoice_number = invoice_number ?? '';

  @override
  List<Object?> get props => [
        id,
        status,
        created_date,
        voucher_amount,
        from,
        percent,
        use_point,
        giving,
        invoice_number
      ];

  static GetQrDetailsModel fromJson(Map<String, dynamic> json) =>
      GetQrDetailsModel(
        id: json['id'].toString(),
        status: json['status'].toString(),
        created_date: json['created_date'].toString(),
        voucher_amount: json['voucher_amount'].toString(),
        from: json['from'].toString(),
        percent: json['percent'].toString(),
        use_point: json['use_point'].toString(),
        giving: json['giving'].toString(),
        invoice_number: json['invoice'].toString(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'status': status,
        'created_date': created_date,
        'voucher_amount': voucher_amount,
        'from': from,
        'percent': percent,
        'use_point': use_point,
        'giving': giving,
        'invoice_number': invoice_number,
      };
}
