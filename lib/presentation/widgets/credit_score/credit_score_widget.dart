import 'dart:math';
import 'package:flap_app/domain/entity/credit_error.dart';
import 'package:flap_app/domain/entity/event.dart';
import 'package:flap_app/domain/entity/user_credit_info.dart';
import 'package:flap_app/presentation/widgets/credit_score/notifier/credit_score_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class CreditScoreWidget extends ConsumerStatefulWidget {
  const CreditScoreWidget({
    super.key,
  });

  @override
  ConsumerState<CreditScoreWidget> createState() {
    return _CreditScoreWidgetState();
  }
}

class _CreditScoreWidgetState extends ConsumerState<CreditScoreWidget> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(creditScoreStateNotifierProvider);

    var creditInfo = UserCreditInfo(score: 0, scoreDifference: 0);

    final isLoading = state.viewData is LoadingEvent;
    final isError = state.viewData is EventError;

    if (state.viewData is SuccessEvent) {
      creditInfo =
          (state.viewData as SuccessEvent<UserCreditInfo, CreditError>).data;
    }

    SvgPicture scoreDifferenceArrow = SvgPicture.asset('assets/up_arrow.svg');
    String userMessage = 'You\'re on the right track!';

    if (creditInfo.scoreDifference < 0) {
      scoreDifferenceArrow = SvgPicture.asset('assets/down_arrow.svg');
      userMessage = 'Oh no! Your score dropped!';
    }
    if (isError) {
      userMessage = 'Error fetching score.';
    }
    if (isLoading) {
      userMessage = 'Fetching...';
    }

    const circleSize = 275.0;
    const progressIndicatorSize = circleSize - 50;
    const cardColor = Color.fromARGB(255, 250, 250, 250);
    int maxCreditScore = ScoreGroup.excellent.range.max;

    Widget bigCircle = Container(
      width: circleSize,
      height: circleSize,
      decoration: BoxDecoration(
        color: cardColor,
        shape: BoxShape.circle,
        boxShadow: [_cardShadow],
      ),
    );

    return SizedBox(
      width: double.infinity,
      height: 455,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Positioned(top: 15, child: bigCircle),
          Positioned.fill(
            top: 50,
            child: Container(
              margin: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [_cardShadow],
              ),
            ),
          ),
          Positioned(
            top: 15,
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                SizedBox(
                  width: progressIndicatorSize,
                  height: progressIndicatorSize,
                  child: Transform.rotate(
                    angle: -pi / 1.24,
                    child: TweenAnimationBuilder<double>(
                      tween: Tween<double>(
                        begin: 0.0,
                        end: creditInfo.score /
                            (maxCreditScore + (maxCreditScore / 3)),
                      ),
                      curve: Curves.easeInOut,
                      duration: const Duration(milliseconds: 900),
                      builder: (context, value, _) {
                        return CircularProgressIndicator(
                          value: value,
                          strokeWidth: 27,
                          strokeAlign: BorderSide.strokeAlignInside,
                          backgroundColor:
                              const Color.fromRGBO(220, 220, 220, 1),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Color(creditInfo.scoreGroup.color),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: circleSize,
                  height: circleSize,
                  child: SvgPicture.asset(
                    'assets/progress_mask.svg',
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: isLoading
                      ? [const CircularProgressIndicator()]
                      : [
                          Text(
                            creditInfo.scoreGroup.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text(
                            '(${creditInfo.scoreGroup.range.toString()})',
                            style: const TextStyle(fontSize: 11),
                          ),
                          Text(
                            creditInfo.score.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.w900, fontSize: 54),
                          ),
                          Row(
                            children: [
                              scoreDifferenceArrow,
                              Text(creditInfo.scoreDifference.abs().toString(),
                                  style: const TextStyle(fontSize: 18)),
                            ],
                          )
                        ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 240,
            child: Column(
              children: [
                Text(
                  userMessage,
                  style: const TextStyle(
                      fontWeight: FontWeight.w900, fontSize: 22),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    CreditButton(
                        logo: 'assets/logos/experian_logo.svg', onClick: () {}),
                    const SizedBox(width: 9),
                    CreditButton(
                        logo: 'assets/logos/equifax_logo.svg', onClick: () {}),
                    const SizedBox(width: 9),
                    CreditButton(
                        logo: 'assets/logos/trans_union_logo.svg',
                        onClick: () {}),
                  ],
                ),
                const SizedBox(height: 22),
                const SizedBox(
                  width: 200,
                  child: Text(
                    'This is a VantageScore 3.0 credit score using Equifax data.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w200),
                  ),
                ),
                const SizedBox(height: 22),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void fetchData() {
    ref.read(creditScoreStateNotifierProvider.notifier).getCreditScore();
  }
}

class CreditButton extends StatelessWidget {
  const CreditButton({super.key, required this.logo, required this.onClick});

  final String logo;
  final void Function() onClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: 132,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [_cardShadow],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onClick,
          splashColor: const Color.fromARGB(255, 242, 242, 242),
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
            child: Center(
              child: SvgPicture.asset(logo),
            ),
          ),
        ),
      ),
    );
  }
}

BoxShadow _cardShadow = const BoxShadow(
  color: Color.fromARGB(96, 109, 109, 109),
  offset: Offset(0, 2),
  blurRadius: 22,
  spreadRadius: -3,
);