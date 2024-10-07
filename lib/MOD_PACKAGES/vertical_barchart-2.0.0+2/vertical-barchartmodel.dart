import 'package:flutter/material.dart';

class VBarChartModel {
  final int? index;
  //used for touch animation
  //
  //
  //
  final String? label;
  //text shown on left side of bar
  //
  //
  //
  final String? tooltip;
  //text shown on right side of bar
  //
  //
  //
  final double value;
  //size of bar
  //
  //
  //
  final List<Color> colors;
  //Colors of bar, liniergradient start from left to right
  //
  //
  //
  final Widget? description;
  //Description of bars
  //
  //
  //
  // ! servicer CUSTOM VARIABLES ! //
  final Widget? $labelWidget;
  //* 패키지를 사용할떄 기본적으로는 label 파라미터에 string을 넣게 되지만, 서비서 프로젝트에서는 텍스트가 아닌 이미지를 넣어야 함.
  //* 때문에, 이 파라미터에 위젯을 넣으면 Text(label) 대신 해당 위젯을 넣어서 그려줌.
  //* NOTE 이때 그래프의 정렬과 라벨 길이 등이 망가지기 때문에 VerticalBarChart의 $forcedLabelStartingPoint, $forcedChartLengthMultiplier를 이용하여 미세조정이 필요함.
  //

  const VBarChartModel({
    this.index,
    this.label,
    this.tooltip,
    this.value = 0,
    this.colors = const [Colors.teal, Colors.indigo],
    this.description,

    //! servicer custom
    this.$labelWidget,
  });
}
