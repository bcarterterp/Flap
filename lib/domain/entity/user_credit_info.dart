import 'package:equatable/equatable.dart';

class UserCreditInfo extends Equatable {
  UserCreditInfo({
    required this.score,
    required this.scoreDifference,
  });

  final int score;
  final int scoreDifference;

  final _scoreInfo = [
    const ScoreInfo(
      range: '(300-579)',
      rangeTitle: 'Poor',
      scoreColor: 0xFFde1818,
    ),
    const ScoreInfo(
      range: '(580-669)',
      rangeTitle: 'Fair',
      scoreColor: 0xFFf57520,
    ),
    const ScoreInfo(
      range: '(670-739)',
      rangeTitle: 'Good',
      scoreColor: 0xFFbcd613,
    ),
    const ScoreInfo(
      range: '(740-799)',
      rangeTitle: 'Very good',
      scoreColor: 0xFF7bde0b,
    ),
    const ScoreInfo(
      range: '(800-850)',
      rangeTitle: 'Excellent',
      scoreColor: 0xFF20b509,
    ),
  ];

  ScoreInfo get scoreInfo {
    ScoreInfo info = _scoreInfo[0];

    switch (score) {
      case <= 579:
        info = _scoreInfo[0];
      case > 579 && <= 669:
        info = _scoreInfo[1];
      case > 669 && <= 739:
        info = _scoreInfo[2];
      case > 739 && <= 799:
        info = _scoreInfo[3];
      case > 799:
        info = _scoreInfo[4];
    }

    return info;
  }

  @override
  List<Object?> get props => [score, scoreDifference];
}

class ScoreInfo {
  const ScoreInfo({
    required this.range,
    required this.rangeTitle,
    required this.scoreColor,
  });

  final String range;
  final String rangeTitle;
  final int scoreColor;
}
