import 'package:flutter/material.dart';
import 'package:servicer/design_standards/colors.dart';

import '../../../../../../../../design_standards/text_styles.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import '../../../../../../../../design_standards/widget_styles.dart';

class TrendChartAnalysis extends StatefulWidget {
  final String timeRange;
  final String unit;
  TrendChartAnalysis({Key? key, required this.timeRange, required this.unit})
      : super(key: key);

  @override
  State<TrendChartAnalysis> createState() => _TrendChartAnalysisState();
}

class _TrendChartAnalysisState extends State<TrendChartAnalysis> {
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
            "상세",
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
        Padding(
          padding: $AnalyticsPageHorizontalPadding,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: SfDataGridTheme(
              data: SfDataGridThemeData(headerColor: $$lightGrey),
              child: SfDataGrid(
                verticalScrollPhysics: const NeverScrollableScrollPhysics(),
                horizontalScrollPhysics: const NeverScrollableScrollPhysics(),
                source: employeeDataSource,
                columnWidthMode: ColumnWidthMode.fill,
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
                        child: Text('분석항목',
                            style:
                                const TextStyle(fontFamily: 'IBMPlexSansKR')),
                      )),
                  GridColumn(
                      columnName: 'designation',
                      label: Container(
                          padding: EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: Text(
                            '결과값',
                            style: const TextStyle(fontFamily: 'IBMPlexSansKR'),
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
          ),
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 8)),
      ],
    );
  }

  List<Employee> getEmployeeData() {
    return [
      Employee('매출합계', '46.7만원'),
      Employee('하루매출 평균', '8.3만원'),
      Employee('이전 대비 매출량 변화', '15%증가'),
      Employee('기간 내 추세', '10.38%증가'),
      Employee('이전 대 추세', '7.7%증가'),
      Employee('최고매출기간', '2022.12.09~2023.01.01'),
      Employee('최저매출기간', '2022.12.26~2022.12.28'),
    ];
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the employee which will be rendered in datagrid.
class Employee {
  /// Creates the employee class with required details.
  Employee(
    this.name,
    this.designation,
  );

  /// Id of an employee.
  //final int id;

  /// Name of an employee.
  final String name;

  /// Designation of an employee.
  final String designation;

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
                  columnName: 'designation', value: e.designation),
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
        child: Text(e.value.toString(),
            style: const TextStyle(fontFamily: 'IBMPlexSansKR')),
      );
    }).toList());
  }
}
