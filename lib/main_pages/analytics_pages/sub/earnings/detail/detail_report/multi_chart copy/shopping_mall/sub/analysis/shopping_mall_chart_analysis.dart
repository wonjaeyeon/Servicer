import 'package:flutter/material.dart';
import 'package:servicer/design_standards/colors.dart';

import '../../../../../../../../../../design_standards/text_styles.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import '../../../../../../../../../../design_standards/widget_styles.dart';
import '../../../../../../../../../../servicer_modules/shopping_mall_master.dart';

class SMChartAnalysis extends StatefulWidget {
  final String timeRange;
  final String unit;
  SMChartAnalysis({Key? key, required this.timeRange, required this.unit})
      : super(key: key);

  @override
  State<SMChartAnalysis> createState() => _SMChartAnalysisState();
}

class _SMChartAnalysisState extends State<SMChartAnalysis> {
  List<Employee> employees = <Employee>[];
  late EmployeeDataSource employeeDataSource;
  @override
  void initState() {
    super.initState();
    employees = getEmployeeData();
    employeeDataSource = EmployeeDataSource(employeeData: employees);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: $AnalyticsPageHorizontalPadding,
          child: Text(
            "입점몰별 매출 분석",
            style: TextStyle(
              color: Colors.black,
              fontSize: $mediumFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Padding(
          padding: $AnalyticsPageHorizontalPadding,
          child: Text(widget.timeRange,
              style: TextStyle(fontSize: $mediumFontSize - 2)),
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 8)),
        SfDataGridTheme(
          data: SfDataGridThemeData(headerColor: $$lightGrey),
          child: SfDataGrid(
            verticalScrollPhysics: const NeverScrollableScrollPhysics(),
            source: employeeDataSource,
            columnWidthMode: ColumnWidthMode.auto,
            shrinkWrapRows: true,
            columns: <GridColumn>[
              // GridColumn(
              //     columnName: 'id',
              //     label: Container(
              //         padding: EdgeInsets.all(16.0),
              //         alignment: Alignment.center,
              //         child: Text(
              //           'ID',
              //         ))),
              GridColumn(
                  columnName: 'name',
                  label: Container(
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: Text('분석항목'))),
              GridColumn(
                  columnName: 'smartStore',
                  label: Container(
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: mallMaster
                                  .themeColorOf(Mall.NaverSmartStore)
                                  .withOpacity(0.8),
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text('스마트스토어'),
                        ],
                      ))),
              GridColumn(
                  columnName: 'zigzag',
                  label: Container(
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: mallMaster
                                  .themeColorOf(Mall.Zigzag)
                                  .withOpacity(0.8),
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text('지그재그'),
                        ],
                      ))),
              GridColumn(
                  columnName: 'ably',
                  label: Container(
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: mallMaster
                                  .themeColorOf(Mall.Ably)
                                  .withOpacity(0.8),
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text('에이블리'),
                        ],
                      ))),
              GridColumn(
                  columnName: 'coupang',
                  label: Container(
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: mallMaster
                                  .themeColorOf(Mall.Coupang)
                                  .withOpacity(0.8),
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text('쿠팡'),
                        ],
                      ))),
              GridColumn(
                  columnName: 'designation',
                  label: Container(
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: Text(
                        '결과값',
                        overflow: TextOverflow.ellipsis,
                      ))),
              // GridColumn(
              //     columnName: 'salary',
              //     label: Container(
              //         padding: EdgeInsets.all(8.0),
              //         alignment: Alignment.center,
              //         child: Text('Salary'))),
            ],
            gridLinesVisibility: GridLinesVisibility.both,
            headerGridLinesVisibility: GridLinesVisibility.both,
          ),
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 8)),
      ],
    );
  }

  List<Employee> getEmployeeData() {
    return [
      Employee('매출합계', '16.7만원', '10만원', '10만원', '10만원', '46.7만원'),
      Employee('하루매출 평균', '2만원', '1만원', '1만원', '3.3만원', '8.3만원'),
      Employee('이전 대비 매출량 변화', '20%증가', '10%증가', '8%증가', '5%증가', '15%증가'),
      Employee('기간 내 추세', '20%증가', '10%증가', '7%증가', '10%증가', '10.38%증가'),
      Employee('이전 대 추세', '30%증가', '13%증가', '10%증가', '10%증가', '7.7%증가'),
      // Employee('최고매출기간', '2022.12.10~2023.01.01', '2022.12.09~2022.12.29',
      //     '2022.12.09~2023.01.01'),
      // Employee('최저매출기간', '2022.12.26~2022.12.28', '2022.12.28~2022.12.30',
      //     '2022.12.26~2022.12.28'),
    ];
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the employee which will be rendered in datagrid.
class Employee {
  /// Creates the employee class with required details.
  Employee(
    this.name,
    this.smartStore,
    this.zigzag,
    this.ably,
    this.coupang,
    this.totalValue,
  );

  /// Id of an employee.
  //final int id;

  /// Name of an employee.
  final String name;

  final String smartStore;

  final String zigzag;

  final String ably;

  final String coupang;

  /// Designation of an employee.
  final String totalValue;

  /// Salary of an employee.
  //final int salary;
}

/// An object to set the employee collection data source to the datagrid. This
/// is used to map the employee data to the datagrid widget.
class EmployeeDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  EmployeeDataSource({required List<Employee> employeeData}) {
    _employeeData = employeeData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              //DataGridCell<int>(columnName: 'id', value: e.id),
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell<String>(
                  columnName: 'smartStore', value: e.smartStore),
              DataGridCell<String>(columnName: 'zigzag', value: e.zigzag),
              DataGridCell<String>(columnName: 'ably', value: e.ably),
              DataGridCell<String>(columnName: 'coupang', value: e.coupang),
              DataGridCell<String>(
                  columnName: 'designation', value: e.totalValue),
              //DataGridCell<int>(columnName: 'salary', value: e.salary),
            ]))
        .toList();
  }

  List<DataGridRow> _employeeData = [];

  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
        child: Text(e.value.toString()),
      );
    }).toList());
  }
}
