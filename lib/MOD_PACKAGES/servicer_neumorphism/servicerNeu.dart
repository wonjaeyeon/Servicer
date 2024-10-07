import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/diagnostics.dart';
import 'package:servicer/main_pages/analytics_pages/new_main.dart';

/// neumorphism designed card.
/// 기본 내부 테두리의 두께는 내부 위젯의 최상단에 _neuCardMagin을 사용함.
/// 가로를 꽉 채우기 위해 width: double.infinity를 사용함.
class NeuCard extends StatelessWidget {
  static double defaultSpaceBetweenCards = 7;

  final Widget? child;
  final double? width;
  final double? height;
  final double? spaceBetweenCards;
  final Color? bgColor;
  final double? rounding;
  final EdgeInsets? innerPadding;
  final double? borderlineWidth;
  final double? borderlineOpacity;
  final double? elevation;

  const NeuCard({
    Key? key,
    this.child,
    this.width,
    this.height,
    this.spaceBetweenCards,
    this.bgColor,
    this.rounding,
    this.innerPadding,
    this.borderlineWidth,
    this.borderlineOpacity,
    this.elevation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // NOTE default value of card rounding
    double defaultRounding = 0;
    return Card(
      color: bgColor ?? Colors.white.withOpacity(1),
      elevation: elevation ?? 1, //NOTE 각 카드들의 그림자 깊이
      borderOnForeground: true,
      shadowColor: Colors.black.withOpacity(1), //NOTE 각 카드들의 그림자 색상
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(rounding ?? defaultRounding), //NOTE 각 카드들의 모서리 둥글기
        side: BorderSide(
          color: Colors.black.withOpacity(borderlineOpacity ?? 0.1), //NOTE 각 카드들의 테두리 색상
          width: borderlineWidth ?? 0.5, //NOTE 각 카드들의 테두리 두께
        ),
      ),
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: spaceBetweenCards ?? 7),

      child: Container(
        margin: innerPadding ?? EdgeInsets.symmetric(horizontal: 15, vertical: 15), //NOTE 카드 내부 테두리의 두께
        width: width ?? double.infinity,
        height: height ?? null,
        child: child ?? Container(),
      ),
    );
  }
}
