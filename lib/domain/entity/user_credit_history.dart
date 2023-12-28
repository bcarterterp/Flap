import 'package:equatable/equatable.dart';

class UserCreditHistory {
  UserCreditHistory({
    required this.data,
  });

  final List<CreditHistoryItem> data;
}

class CreditHistoryItem extends Equatable {
  const CreditHistoryItem({required this.date, required this.score});

  final DateTime date;
  final int score;

  @override
  List<Object?> get props => [date, score];
}
