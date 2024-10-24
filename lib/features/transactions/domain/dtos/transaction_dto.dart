import 'package:equatable/equatable.dart';

final class TransactionDto extends Equatable {
  final String hash;
  final DateTime time;
  final Map<String, dynamic> metadata;

  const TransactionDto({
    required this.hash,
    required this.time,
    required this.metadata,
  });

  @override
  List<Object> get props => [hash, time, metadata];
}
