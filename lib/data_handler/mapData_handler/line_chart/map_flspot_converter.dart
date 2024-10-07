import 'package:servicer/MOD_PACKAGES/fl_chart_svc/fl_chart.dart';

List<FlSpot> mapToFlSpotConverter(Map<String, dynamic> data) {
  List<FlSpot> flSpotList = [];
  data.forEach((key, value) {
    // erase dash
    String keyString = key.replaceAll('-', '');
    //convert keyString to double
    double keyDouble = double.parse(keyString);

    //add to flSpotList
    flSpotList.add(FlSpot(keyDouble, value.toDouble()));
  });
  //print(flSpotList);
  return flSpotList;
}

List<FlSpot> mapToFlSpotConverter2(Map<String, dynamic> data) {
  List<FlSpot> flSpotList = [];
  data.forEach((key, value) {
    //add to flSpotList
    //flSpotList.add(FlSpot(keyDouble, value.toDouble()));
    print(value);
    //for loop to add all value's value to flSpotList
    for (int i = 0; i < value.length; i++) {
      //String keyString = value[i][x].replaceAll value[i]
      flSpotList.add(FlSpot(value[i]['x'], value[i]['y'].toDouble()));
    }
  });
  //print(flSpotList);
  //print("called");
  return flSpotList;
}

//function to convert map keys to divided String data
//안 쓸 예정
List<List> keyToDividedStringConverter(Map<String, dynamic> data) {
  List<List> dividedStringList = [];
  data.forEach((key, value) {
    // erase dash
    String keyString = key.replaceAll('-', '');
    //get year
    String year = keyString.substring(0, 4);
    //get month
    String month = keyString.substring(4, 6);
    //get day
    String day = keyString.substring(6, 8);
    //add to dividedStringList
    dividedStringList.add([year, month, day]);
  });
  //print(dividedStringList);
  return dividedStringList;
}
