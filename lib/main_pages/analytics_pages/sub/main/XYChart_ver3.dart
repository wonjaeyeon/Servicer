/// Package imports
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

/// Barcode imports
// ignore: depend_on_referenced_packages
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../servicer_modules/shopping_mall_master.dart';

class XYChartV3 extends StatefulWidget {
  XYChartV3({Key? key}) : super(key: key);

  @override
  State<XYChartV3> createState() => _XYChartV3State();
}

class _XYChartV3State extends State<XYChartV3> {
  late bool _isLandscapeInMobileView;
  late _ColumnTypesDataGridSource _columnTypesDataGridSource;
  late List<Widget> _taxs;
  late List<String> _names;
  late List<List<double>> _winlossData;
  late List<Widget> _columnData;

  @override
  void initState() {
    super.initState();
    _names = <String>[
      '스마트스토어',
      '지그재그',
      '룩핀',
      '에이블리',
      '쿠팡',
      '11번가',
      '티몬',
    ];

    _winlossData = <List<double>>[
      <double>[0, 6, -4, 1, -3, 2, 5],
      <double>[5, -4, 6, 3, -1, 2, 0],
      <double>[6, 4, 0, 3, -2, 5, 1],
      <double>[4, -6, 3, 0, 1, -2, 5],
      <double>[3, 5, -6, -4, 0, 1, 2],
      <double>[1, -3, 4, -2, 5, 0, 6],
      <double>[2, 4, 0, -3, 5, -6, 1]
    ];

    _taxs = <Widget>[
      SfSparkLineChart(
          data: const <double>[0, 6, 4, 1, 3, 2, 5],
          axisLineWidth: 0,
          color: Colors.green,
          trackball: const SparkChartTrackball()),
      SfSparkLineChart(
          data: const <double>[5, 4, 6, 3, 1, 2, 0],
          axisLineWidth: 0,
          color: Colors.green,
          trackball: const SparkChartTrackball()),
      SfSparkLineChart(
          data: const <double>[6, 4, 0, 3, 2, 5, 1],
          axisLineWidth: 0,
          color: Colors.green,
          trackball: const SparkChartTrackball()),
      SfSparkLineChart(
          data: const <double>[4, 6, 3, 0, 1, 2, 5],
          axisLineWidth: 0,
          color: Colors.green,
          trackball: const SparkChartTrackball()),
      SfSparkLineChart(
          data: const <double>[3, 5, 6, 4, 0, 1, 2],
          axisLineWidth: 0,
          color: Colors.green,
          trackball: const SparkChartTrackball()),
      SfSparkLineChart(
          data: const <double>[1, 3, 4, 2, 5, 0, 6],
          axisLineWidth: 0,
          color: Colors.green,
          trackball: const SparkChartTrackball()),
      SfSparkLineChart(
          data: const <double>[2, 4, 0, 3, 5, 6, 1],
          axisLineWidth: 0,
          color: Colors.green,
          trackball: const SparkChartTrackball()),
      SfSparkLineChart(
          data: const <double>[5, 4, 6, 3, 1, 2, 0],
          axisLineWidth: 0,
          color: Colors.green,
          trackball: const SparkChartTrackball()),
      SfSparkLineChart(
          data: const <double>[0, 6, 4, 1, 3, 2, 5],
          axisLineWidth: 0,
          color: Colors.green,
          trackball: const SparkChartTrackball()),
      SfSparkLineChart(
          data: const <double>[6, 4, 0, 3, 2, 5, 1],
          axisLineWidth: 0,
          color: Colors.green,
          trackball: const SparkChartTrackball()),
      SfSparkLineChart(
          data: const <double>[4, 6, 3, 0, 1, 2, 5],
          axisLineWidth: 0,
          color: Colors.green,
          trackball: const SparkChartTrackball()),
      SfSparkLineChart(
          data: const <double>[3, 5, 6, 4, 0, 1, 2],
          axisLineWidth: 0,
          color: Colors.green,
          trackball: const SparkChartTrackball()),
      SfSparkLineChart(
          data: const <double>[1, 3, 4, 2, 5, 0, 6],
          axisLineWidth: 0,
          color: Colors.green,
          trackball: const SparkChartTrackball()),
      SfSparkLineChart(
          data: const <double>[2, 4, 0, 3, 5, 6, 1],
          axisLineWidth: 0,
          color: Colors.green,
          trackball: const SparkChartTrackball()),
      SfSparkLineChart(
          data: const <double>[5, 4, 6, 3, 1, 2, 0],
          axisLineWidth: 0,
          color: Colors.green,
          trackball: const SparkChartTrackball()),
      SfSparkLineChart(
          data: const <double>[0, 6, 4, 1, 3, 2, 5],
          axisLineWidth: 0,
          color: Colors.green,
          trackball: const SparkChartTrackball()),
      SfSparkLineChart(
          data: const <double>[6, 4, 0, 3, 2, 5, 1],
          axisLineWidth: 0,
          color: Colors.green,
          trackball: const SparkChartTrackball()),
      SfSparkLineChart(
          data: const <double>[4, 6, 3, 0, 1, 2, 5],
          axisLineWidth: 0,
          color: Colors.green,
          trackball: const SparkChartTrackball()),
      SfSparkLineChart(
          data: const <double>[2, 4, 0, 3, 5, 6, 1],
          axisLineWidth: 0,
          color: Colors.green,
          trackball: const SparkChartTrackball()),
      SfSparkLineChart(
          data: const <double>[3, 5, 6, 4, 0, 1, 2],
          axisLineWidth: 0,
          color: Colors.green,
          trackball: const SparkChartTrackball()),
    ];

    _columnData = <Widget>[
      SfSparkLineChart(
          data: const <double>[0, 6, -4, 1, -3, 2, 5],
          axisLineWidth: 0,
          color: Colors.red,
          trackball: const SparkChartTrackball()),
      SfSparkLineChart(
          data: const <double>[5, -4, 6, 3, -1, 2, 0],
          axisLineWidth: 0,
          color: Colors.red,
          trackball: const SparkChartTrackball()),
      SfSparkLineChart(
          data: const <double>[6, 4, 0, 3, -2, 5, 1],
          axisLineWidth: 0,
          color: Colors.red,
          trackball: const SparkChartTrackball()),
      SfSparkLineChart(
          data: const <double>[4, -6, 3, 0, 1, -2, 5],
          axisLineWidth: 0,
          color: Colors.red,
          trackball: const SparkChartTrackball()),
      SfSparkLineChart(
          data: const <double>[3, 5, -6, -4, 0, 1, 2],
          axisLineWidth: 0,
          color: Colors.red,
          trackball: const SparkChartTrackball()),
      SfSparkLineChart(
          data: const <double>[1, -3, 4, -2, 5, 0, 6],
          axisLineWidth: 0,
          color: Colors.red,
          trackball: const SparkChartTrackball()),
      SfSparkLineChart(
          data: const <double>[2, 4, 0, -3, 5, -6, 1],
          axisLineWidth: 0,
          color: Colors.red,
          trackball: const SparkChartTrackball()),
      SfSparkLineChart(
          data: const <double>[5, 4, -6, 3, 1, -2, 0],
          axisLineWidth: 0,
          color: Colors.red,
          trackball: const SparkChartTrackball()),
      SfSparkLineChart(
          data: const <double>[0, -6, 4, 1, -3, 2, 5],
          axisLineWidth: 0,
          color: Colors.red,
          trackball: const SparkChartTrackball()),
      SfSparkLineChart(
          data: const <double>[6, 4, 0, -3, 2, -5, 1],
          axisLineWidth: 0,
          color: Colors.red,
          trackball: const SparkChartTrackball()),
      SfSparkLineChart(
          data: const <double>[4, 6, -3, 0, 1, 2, 5],
          axisLineWidth: 0,
          color: Colors.red,
          trackball: const SparkChartTrackball()),
      SfSparkLineChart(
          data: const <double>[3, -5, -6, 4, 0, 1, 2],
          axisLineWidth: 0,
          color: Colors.red,
          trackball: const SparkChartTrackball()),
      SfSparkLineChart(
          data: const <double>[1, 3, -4, -2, 5, 0, 6],
          axisLineWidth: 0,
          color: Colors.red,
          trackball: const SparkChartTrackball()),
      SfSparkLineChart(
          data: const <double>[2, -4, 0, -3, 5, 6, 1],
          axisLineWidth: 0,
          color: Colors.red,
          trackball: const SparkChartTrackball()),
      SfSparkLineChart(
          data: const <double>[5, 4, -6, 3, 1, -2, 0],
          axisLineWidth: 0,
          color: Colors.red,
          trackball: const SparkChartTrackball()),
      SfSparkLineChart(
          data: const <double>[0, 6, 4, -1, -3, 2, 5],
          axisLineWidth: 0,
          color: Colors.red,
          trackball: const SparkChartTrackball()),
      SfSparkLineChart(
          data: const <double>[6, -4, 0, -3, 2, 5, 1],
          axisLineWidth: 0,
          color: Colors.red,
          trackball: const SparkChartTrackball()),
      SfSparkLineChart(
          data: const <double>[4, 6, -3, 0, -1, 2, 5],
          axisLineWidth: 0,
          color: Colors.red,
          trackball: const SparkChartTrackball()),
      SfSparkLineChart(
          data: const <double>[6, 4, 0, -3, 2, -5, 1],
          axisLineWidth: 0,
          color: Colors.red,
          trackball: const SparkChartTrackball()),
      SfSparkLineChart(
          data: const <double>[3, 5, 6, -4, 0, 1, 2],
          axisLineWidth: 0,
          color: Colors.red,
          trackball: const SparkChartTrackball())
    ];
    _columnTypesDataGridSource =
        _ColumnTypesDataGridSource(_generateList(7), true);
  }

  List<_Employee> _generateList(int count) {
    final List<_Employee> employeeData = <_Employee>[];
    for (int i = 0; i < count; i++) {
      employeeData.add(_Employee(
          1 + i,
          _names[i],
          Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: _taxs[i]),
          Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: _columnData[i]),
          Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: SfSparkWinLossChart(
                  data: _winlossData[i],
                  trackball: const SparkChartTrackball()))));
    }
    return employeeData;
  }

  SfDataGrid _buildDataGrid() {
    return SfDataGrid(
        horizontalScrollPhysics: const NeverScrollableScrollPhysics(),
        source: _columnTypesDataGridSource,
        columnWidthMode: ColumnWidthMode.fill,
        columns: <GridColumn>[
          GridColumn(
              columnName: 'id',
              label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.centerRight,
                  child: const Text('')),
              width: 50),
          GridColumn(
            columnName: 'name',
            label: Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.centerLeft,
                child: const Text('입점몰')),
          ),
          // GridColumn(
          //   columnName: 'shipCountry',
          //   label: Container(
          //       padding: const EdgeInsets.all(8.0),
          //       alignment: Alignment.centerLeft,
          //       child: const Text('Ship country')),
          // ),
          GridColumn(
              columnName: 'tax',
              width: true ? double.nan : 130,
              label: Container(
                  alignment: Alignment.center, child: const Text('주문건 추이'))),
          GridColumn(
              columnName: 'column',
              width: true ? double.nan : 130,
              label: Container(
                  alignment: Alignment.center, child: const Text('반품건 추이'))),
          GridColumn(
              columnName: 'winloss',
              label: Container(
                  alignment: Alignment.center, child: const Text('영업수익 추이'))),
        ]);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _isLandscapeInMobileView =
        !true && MediaQuery.of(context).orientation == Orientation.landscape;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(0), child: _buildDataGrid());
  }
}

class _Employee {
  _Employee(this.id, this.name, this.tax, this.column, this.winloss);
  final int id;
  final String name;
  final Widget tax;
  final Widget column;
  final Widget winloss;
}

class _ColumnTypesDataGridSource extends DataGridSource {
  _ColumnTypesDataGridSource(List<_Employee> employees, this.isWeb) {
    _employeeData = employees
        .map<DataGridRow>(
            (_Employee e) => DataGridRow(cells: <DataGridCell<dynamic>>[
                  DataGridCell<int>(columnName: 'id', value: e.id),
                  DataGridCell<String>(columnName: 'name', value: e.name),
                  DataGridCell<Widget>(columnName: 'tax', value: e.tax),
                  DataGridCell<Widget>(columnName: 'column', value: e.column),
                  DataGridCell<Widget>(columnName: 'winloss', value: e.winloss),
                ]))
        .toList();
  }

  late List<DataGridRow> _employeeData;

  final bool isWeb;

  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: <Widget>[
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(3.0),
        child: Text(row.getCells()[0].value.toString()),
      ),
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(2.0),
        child: getshoppingMallWidget(row.getCells()[1].value),
      ),
      // Container(
      //   alignment: Alignment.centerLeft,
      //   padding: const EdgeInsets.all(8.0),
      //   child: Text(row.getCells()[2].value),
      // ),
      Container(
        padding: const EdgeInsets.all(3),
        child: row.getCells()[2].value,
      ),
      Container(
        padding: const EdgeInsets.all(3),
        child: row.getCells()[3].value,
      ),
      Container(
        padding: const EdgeInsets.all(3),
        child: row.getCells()[4].value,
      )
    ]);
  }

  Widget getshoppingMallWidget(String shoppingMall) {
    final Mall mallName = mallMaster.mallOf(shoppingMall);

    return Row(
      children: [
        SizedBox(width: 20, height: 20, child: mallMaster.smallImgOf(mallName)),
        const SizedBox(
          width: 4,
        ),
        Expanded(child: Text(shoppingMall))
      ],
    );
  }
}
