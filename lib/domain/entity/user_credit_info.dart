import 'package:equatable/equatable.dart';

class UserCreditInfo extends Equatable {
  UserCreditInfo({
    required this.score,
    required this.scoreDifference,
  }) : scoreGroup = ScoreGroup.getGroupForScore(score);

  final int score;
  final int scoreDifference;
  final ScoreGroup scoreGroup;

  @override
  List<Object?> get props => [score, scoreDifference];
}

enum ScoreGroup {
  poor(
    range: Range(min: 300, max: 579),
    title: 'Poor',
    color: 0xFFde1818,
  ),
  fair(
    range: Range(min: 580, max: 669),
    title: 'Fair',
    color: 0xFFf57520,
  ),
  good(
    range: Range(min: 670, max: 739),
    title: 'Good',
    color: 0xFFbcd613,
  ),
  veryGood(
    range: Range(min: 740, max: 799),
    title: 'Very good',
    color: 0xFF7bde0b,
  ),
  excellent(
    range: Range(min: 800, max: 850),
    title: 'Excellent',
    color: 0xFF20b509,
  );

  const ScoreGroup({
    required this.range,
    required this.title,
    required this.color,
  });

  final Range range;
  final String title;
  final int color;

  static ScoreGroup getGroupForScore(int score) => ScoreGroup.values.firstWhere(
      (group) => score >= group.range.min && score <= group.range.max);
}

class Range {
  const Range({required this.min, required this.max});

  final int min;
  final int max;

  @override
  String toString() {
    return '$min-$max';
  }
}
