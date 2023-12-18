class UserCreditHistory {
  UserCreditHistory({
    required this.data,
  });

  final List<CreditHistoryItem> data;
}

class CreditHistoryItem {
  CreditHistoryItem({required this.date, required this.score});

  final DateTime date;
  final int score;
}
