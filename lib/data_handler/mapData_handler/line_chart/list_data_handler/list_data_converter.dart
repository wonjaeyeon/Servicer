//funtion inputs the List<FlSpot> and convert FlSpot.x to 1~n int
//function outputs List<FlSpot> data
import '../../../../MOD_PACKAGES/fl_chart_svc/fl_chart.dart';

List<FlSpot> convertToNumber(List<FlSpot> data) {
  List<FlSpot> convertedData = [];
  int i = 1;
  for (FlSpot element in data) {
    convertedData.add(FlSpot(i.toDouble(), element.y));
    i++;
  }
  return convertedData;
}
//
