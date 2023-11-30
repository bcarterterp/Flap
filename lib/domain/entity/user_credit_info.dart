import 'package:equatable/equatable.dart';

class UserCreditInfo extends Equatable {
  const UserCreditInfo({
    required this.score,
    required this.scoreDifference,
  });

  final int score;
  final int scoreDifference;

  ScoreRange get scoreInfo {
    ScoreRange info = ScoreRange.poor;

    switch (score) {
      case <= 579:
        info = ScoreRange.poor;
      case > 579 && <= 669:
        info = ScoreRange.fair;
      case > 669 && <= 739:
        info = ScoreRange.good;
      case > 739 && <= 799:
        info = ScoreRange.veryGood;
      case > 799:
        info = ScoreRange.excellent;
    }

    return info;
  }

  @override
  List<Object?> get props => [score, scoreDifference];
}

enum ScoreRange {
  poor(
    range: '(300-579)',
    rangeTitle: 'Poor',
    scoreColor: 0xFFde1818,
  ),
  fair(
    range: '(580-669)',
    rangeTitle: 'Fair',
    scoreColor: 0xFFf57520,
  ),
  good(
    range: '(670-739)',
    rangeTitle: 'Good',
    scoreColor: 0xFFbcd613,
  ),
  veryGood(
    range: '(740-799)',
    rangeTitle: 'Very good',
    scoreColor: 0xFF7bde0b,
  ),
  excellent(
    range: '(800-850)',
    rangeTitle: 'Excellent',
    scoreColor: 0xFF20b509,
  );

  const ScoreRange({
    required this.range,
    required this.rangeTitle,
    required this.scoreColor,
  });

  final String range;
  final String rangeTitle;
  final int scoreColor;
}
