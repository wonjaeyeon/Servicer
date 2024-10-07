import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:servicer/servicer_modules/getBanner.dart';
import 'package:servicer/MOD_PACKAGES/vertical_barchart-2.0.0+2/vertical-barchartmodel.dart';
import 'package:servicer/MOD_PACKAGES/vertical_barchart-2.0.0+2/vertical-barchart.dart';
import 'package:servicer/sample_data/getdata.dart';

double _labelWidth = 65;
double _labelHeight = 20;

class MainPageSalesStatusBarChart extends StatefulWidget {
  MainPageSalesStatusBarChart({Key? key}) : super(key: key);

  @override
  State<MainPageSalesStatusBarChart> createState() => _MainPageSalesStatusBarChartState();
}

class _MainPageSalesStatusBarChartState extends State<MainPageSalesStatusBarChart> {
  //ㅋㅋㅋ
  @override
  Widget build(BuildContext context) {
    List<VBarChartModel> barData = []; // 최종적으로 그래프 그릴 때 쓸 데이터를 추가하게 될 리스트
    double _maxValue = 0;
    Map<String, double> receivedData = {};
    return FutureBuilder(
      // NOTE 이 부분에서 future 타입으로 데이터를 불러온다.
      future: simulateGetData('mainBarChart'),
      builder: ((BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) return const CircularProgressIndicator();
        receivedData = snapshot.data;
        // 내림차순으로 데이터를 정렬
        var tmp_ = receivedData.entries.toList()..sort((b, a) => a.value.compareTo(b.value));
        receivedData
          ..clear()
          ..addEntries(tmp_); // 정렬한 값을 대체
        barData.clear();
        receivedData.forEach(
          (key, value) {
            if (_maxValue < value) _maxValue = value.toDouble();
            barData.add(
              VBarChartModel(
                tooltip: value.toInt().toString(),
                label: key,
                $labelWidget: getSmallBannerWithSize(key, _labelWidth, _labelHeight, false), //15
                colors: [Colors.indigo, Colors.red],
                value: value,
                //tooltip:
              ),
            );
          },
        );
        return Center(
          child: VerticalBarchart(
            maxX: _maxValue,
            data: barData,
            showLegend: true,
            alwaysShowDescription: false,
            showBackdrop: true,
            legend: [],

            $startAnimationDelay: Duration(milliseconds: 50),
            $startAnimationDuration: Duration(milliseconds: 1500),
            $backDropStartAnimationDuration: Duration(milliseconds: 250),
            $startAnimationCurve: Curves.fastLinearToSlowEaseIn,
            $backDropStartAnimationCurve: Curves.easeOutCirc,
            $chartBorderRadius: 4,
            $forcedLabelStartingPoint: _labelWidth,// NOTE 가로 위치임
            $forcedChartLengthMultiplier: 1.1, //? 왠지 모르겠지만 최대 길이....
          ),
        );
      }),
    );
  }
}
