import 'package:flutter/material.dart';

import 'extension/expandedSection.dart';
import 'vertical-barchartmodel.dart';
import 'vertical-legend.dart';

class VerticalBarchart extends StatefulWidget {
  final Color? background;
  //Background color of the container
  //
  //
  //
  final Color? labelColor;
  //Color of the label, default is Colors.indigo
  //
  //
  //
  final Color? tooltipColor;
  //Color of the tooltip shown at right side of bar, default is Colors.indigo
  //
  //
  //
  final double maxX;
  //Maximum size of bars, use your List<VBarChartModel> biggest value, or you can choose more than it. default is 20
  //
  //
  //
  final double labelSizeFactor;
  //Width of label space reserved, range is from 0.0 - 0.5, default is 0.33
  //
  //
  //
  final bool showLegend;
  //Show or hide legend, the legend must not be null.
  //
  //
  //
  final List<VBarChartModel>? data;
  //Your Bar Data.
  //
  //
  //
  final List<Vlegend>? legend;
  //Legend data, use legend as group of colors of the bar.
  //
  //
  //
  final LegendPosition? legendPosition;
  //Position of legend, LegendPosition.TOP or LegendPosition.BOTTOM, default is LegendPosition.BOTTOM
  //
  //
  //
  final double tooltipSize;
  //Width of tooltip
  //
  //
  //
  final bool alwaysShowDescription;
  //Show description of bars, override tap function.
  //
  //
  //
  final bool showBackdrop;
  //show or hide backdrop of bars, default is false.
  //
  //
  //
  final Color? backdropColor;
  //Backdrop color, default is grey.
  //
  //
  //
  final double? barSize;
  //size of bars
  //
  //
  //
  final BarStyle? barStyle;
  //style of bars : DEFAULT / CIRCLE
  //
  //
  //

  //! servicer CUSTOM ADDED VARIABLES !//
  final Duration $startAnimationDuration;
  //* start animation에서 그래프가 우측으로 늘어나는 시간
  //
  final Duration $startAnimationDelay;
  //* start animation 시작하기 전의 딜레이
  //
  final Duration $backDropStartAnimationDuration;
  //* 전체 구간을 칠하는 backdrop이 우측으로 늘어나는 시간
  //
  final Curve $startAnimationCurve;
  //* start animation의 curve
  //
  final Curve $backDropStartAnimationCurve;
  //* backdrop start animation의 curve
  //
  final double $chartBorderRadius;
  //* backdrop과 그래프의 가장자리 둥글리는 정도 (double)
  //
  final double? $forcedLabelStartingPoint;
  //* 강제로 라벨의 가로 길이를 지정. 따로 지정하지 않을 경우 무시되고 패키지 기본값이 사용됨
  //
  final double $forcedChartLengthMultiplier;
  //* 패키지에서 자체적으로 그린 차트의 가로 길이에 강제로 배수를 적용함. 따로 지정하지 않을 경우 1로 설정됨.
  //

  const VerticalBarchart({
    Key? key,
    this.maxX = 20,
    this.data,
    this.labelSizeFactor = 0.25,
    this.background = Colors.white,
    this.showLegend = false,
    this.legend,
    this.labelColor = Colors.indigo,
    this.tooltipColor = Colors.indigo,
    this.legendPosition = LegendPosition.BOTTOM,
    this.tooltipSize = 40,
    this.alwaysShowDescription = false,
    this.showBackdrop = false,
    this.backdropColor = const Color(0xFFE0E0E0),
    this.barSize = 8,
    this.barStyle = BarStyle.DEFAULT,
    // ! servicer custom
    this.$startAnimationDelay = const Duration(milliseconds: 300),
    this.$startAnimationDuration = const Duration(milliseconds: 400),
    this.$backDropStartAnimationDuration = const Duration(milliseconds: 400),
    this.$startAnimationCurve = Curves.easeOutCirc,
    this.$backDropStartAnimationCurve = Curves.easeOutCirc,
    this.$chartBorderRadius = 10.0,
    this.$forcedLabelStartingPoint,
    this.$forcedChartLengthMultiplier = 1.0,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => VerticalBarchartState();
}

class VerticalBarchartState extends State<VerticalBarchart> {
  late double width;
  double sizePadding = 0;
  int touchIndex = -1;
  int showIndex = -1;
  double animWidth = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(widget.$startAnimationDelay).then((value) => setState(() {
          animWidth = 1;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      width = constraints.biggest.width;
      List<Widget> isi = [];
      if (widget.showLegend && widget.legendPosition == LegendPosition.TOP) {
        try {
          isi.add(
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Wrap(
                runSpacing: 6,
                spacing: 20,
                alignment: WrapAlignment.center,
                children: widget.legend!,
              ),
            ),
          );
        } catch (Exception) {
          print("Legend not found");
        }
      }

      try {
        if (widget.data!.length > 0) {
          widget.data!.forEach((e) {
            isi.add(GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                setState(() {
                  try {
                    widget.alwaysShowDescription
                        ? showIndex = -1
                        : showIndex == e.index!
                            ? showIndex = -1
                            : showIndex = e.index!;
                  } catch (e) {
                    null;
                  }
                });
              },
              onTapDown: (a) {
                setState(() {
                  try {
                    touchIndex = e.index!;
                  } catch (e) {
                    null;
                  }
                });
              },
              onTapCancel: () {
                setState(() {
                  try {
                    touchIndex = -1;
                  } catch (e) {
                    null;
                  }
                });
              },
              onTapUp: (a) {
                setState(() {
                  try {
                    touchIndex = -1;
                  } catch (e) {
                    null;
                  }
                });
              },
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: widget.barStyle == BarStyle.DEFAULT
                      ? _barData(e.label, widget.labelColor, e.tooltip, widget.tooltipColor, e.value, e.colors, e.index,
                          widget.alwaysShowDescription ? true : false, e.description, e.$labelWidget)
                      : _barDataCircle(e.label, widget.labelColor, e.tooltip, widget.tooltipColor, e.value, e.colors, e.index,
                          widget.alwaysShowDescription ? true : false, e.description, e.$labelWidget)),
            ));
          });
        } else {
          isi.add(Container());
        }
      } catch (Exception) {
        isi.add(Container(
          color: widget.background,
          child: Text(
            "Nothing to display.",
            style: TextStyle(fontSize: 12),
          ),
        ));
      }

      if (widget.showLegend && widget.legendPosition == LegendPosition.BOTTOM) {
        try {
          isi.add(
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Wrap(
                runSpacing: 6,
                spacing: 20,
                alignment: WrapAlignment.center,
                children: widget.legend!,
              ),
            ),
          );
        } catch (Exception) {
          print("Legend not found");
        }
      }

      return Container(
        padding: EdgeInsets.all(sizePadding),
        color: widget.background,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: isi,
        ),
      );
    });
  }

  Widget _barData(String? label, Color? labelColor, String? tooltip, Color? tooltipColor, double jml, List<Color> colors,
      int? index, bool showDesc, Widget? description, Widget? $labelWidget) {
    double maxLabel = 0.3;
    double sizeLabel = width * maxLabel - 16 - (sizePadding * 2);
    double sizeFullBar = width - sizeLabel - widget.tooltipSize - 16 - (sizePadding * 2);
    double sizeBar = jml / widget.maxX * sizeFullBar;
    double offSetX = widget.maxX - jml + 1;
    double sizeBarHeight = (widget.barSize!) < 8 ? 8 : widget.barSize!;

    return Container(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: widget.alwaysShowDescription ? CrossAxisAlignment.start : CrossAxisAlignment.center,
          children: [
            // ANCHOR 라벨
            SizedBox(
              width: widget.$forcedLabelStartingPoint ?? sizeLabel,
              child: Align(
                alignment: Alignment.centerRight,
                child: $labelWidget ??
                    Text(
                      //! NOTE vertical labels
                      label ?? "",
                      textAlign: TextAlign.end,
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: labelColor),
                    ),
              ),
            ),
            // ANCHOR 라벨과 그래프 사이 간격 띄우기
            SizedBox(
              width: 8,
            ),
            // ANCHOR 그래프
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Row(children: [
                  Stack(alignment: Alignment.centerLeft, children: [
                    widget.showBackdrop
                        //* backdrop
                        ? AnimatedContainer(
                            width: widget.$forcedChartLengthMultiplier * sizeFullBar * animWidth,
                            height: touchIndex == index ? sizeBarHeight + 5 : sizeBarHeight,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(widget.$chartBorderRadius), color: widget.backdropColor),
                            duration: widget.$backDropStartAnimationDuration,
                            curve: widget.$backDropStartAnimationCurve,
                          )
                        : Container(),
                    //* colored bar
                    AnimatedContainer(
                      width: widget.$forcedChartLengthMultiplier * sizeBar * animWidth,
                      height: touchIndex == index ? sizeBarHeight + 5 : sizeBarHeight,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(widget.$chartBorderRadius),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment(offSetX, 1.0),
                            colors: colors,
                          )),
                      duration: widget.$startAnimationDuration,
                      curve: widget.$startAnimationCurve,
                    ),
                  ]),
                  //ANCHOR 간격
                  SizedBox(
                    width: 8,
                  ),
                  //ANCHOR 툴팁 (숫자)
                  Container(
                    child: Text(
                      tooltip ?? "",
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: tooltipColor),
                    ),
                  ),
                ]),
                //ExpandedSection(expand: showIndex == index ? !showDesc : showDesc, child: description ?? Container())
              ]),
            ),
          ]),
    );
  }

  Widget _barDataCircle(String? label, Color? labelColor, String? tooltip, Color? tooltipColor, double jml, List<Color> colors,
      int? index, bool showDesc, Widget? description, Widget? $labelWidget) {
    double maxLabel = widget.labelSizeFactor > 0.5 ? 0.5 : widget.labelSizeFactor;
    double sizeLabel = width * maxLabel - 16 - (sizePadding * 2);
    double sizeFullBar = width - sizeLabel - widget.tooltipSize - 16 - (sizePadding * 2);
    double sizeBar = jml / widget.maxX * sizeFullBar;
    double sizeBarHeight = (widget.barSize!) < 8 ? 8 : widget.barSize!;
    double spacing = 2;

    int circleFullWidth = sizeFullBar ~/ (sizeBarHeight + spacing);
    int circleWidth = sizeBar ~/ (sizeBarHeight + spacing);

    List<Widget> circleBackdrop = [];
    List<Widget> circleContent = [];
    for (int i = 0; i < circleFullWidth; i++) {
      circleBackdrop.add(Container(
        width: sizeBarHeight,
        height: sizeBarHeight,
        decoration: BoxDecoration(shape: BoxShape.circle, color: widget.backdropColor),
      ));
    }
    for (int i = 0; i < circleWidth; i++) {
      double offsetX = circleFullWidth.toDouble() - (i + 1);
      print(offsetX);
      circleContent.add(Container(
        width: sizeBarHeight,
        height: sizeBarHeight,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: colors.first,
          gradient: LinearGradient(
            begin: Alignment((i + 0.5) * (-1), 0),
            end: Alignment(offsetX, 0),
            tileMode: TileMode.clamp,
            colors: colors,
          ),
        ),
      ));
    }
    if (circleContent.length <= 0)
      circleContent.add(Container(
        width: sizeBarHeight,
        height: sizeBarHeight,
        decoration: BoxDecoration(shape: BoxShape.circle, color: colors.first.withOpacity(0.5)),
      ));

    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
        width: sizeLabel,
        child: Text(
          label ?? "",
          textAlign: TextAlign.end,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: labelColor),
        ),
      ),
      SizedBox(
        width: 8,
      ),
      Expanded(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Stack(children: [
              widget.showBackdrop
                  ? Wrap(
                      spacing: spacing,
                      children: circleBackdrop,
                    )
                  : Container(),
              Wrap(
                spacing: spacing,
                children: circleContent,
              )
            ]),
            SizedBox(
              width: 8,
            ),
            SizedBox(
              width: widget.tooltipSize,
              child: Text(
                tooltip ?? "",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: tooltipColor),
              ),
            ),
          ]),
          ExpandedSection(expand: showIndex == index ? !showDesc : showDesc, child: description ?? Container())
        ]),
      ),
    ]);
  }
}

enum LegendPosition { TOP, BOTTOM }

enum BarStyle { DEFAULT, CIRCLE }
