import 'package:flutter/material.dart';
import 'package:servicer/design_standards/colors.dart';

import '../../../../../../../../design_standards/text_styles.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import '../../../../../../../../design_standards/widget_styles.dart';

class ExpectedProfitChartAnalysis extends StatefulWidget {
  final String timeRange;
  final String unit;
  ExpectedProfitChartAnalysis(
      {Key? key, required this.timeRange, required this.unit})
      : super(key: key);

  @override
  State<ExpectedProfitChartAnalysis> createState() =>
      _ExpectedProfitChartAnalysisState();
}

class _ExpectedProfitChartAnalysisState
    extends State<ExpectedProfitChartAnalysis> {
  List<Element> employees = <Element>[];
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

  List<Element> getEmployeeData() {
    return [
      Element('매출합계', '20.6만원'),
      Element('하루매출 평균', '8.3만원'),
      Element('고정 비용', '3만원'),
      Element('변동 비용', '0~2만원'),
      Element('예상 수익', '15.6~18.6만원'),
      Element('예상 수익률', '10.5~12.3%'),
      Element('1인 예상 수익(인원 : 2)', '7.8~9.3만원'),
    ];
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the employee which will be rendered in datagrid.
class Element {
  /// Creates the employee class with required details.
  Element(
    this.name,
    this.result,
  );

  /// Id of an employee.
  //final int id;

  /// Name of an employee.
  final String name;

  /// Designation of an employee.
  final String result;

  /// Salary of an employee.
  //final int salary;
}

/// An object to set the employee collection data source to the datagrid. This
/// is used to map the employee data to the datagrid widget.
class EmployeeDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  EmployeeDataSource({required List<Element> employeeData}) {
    _employeeData = employeeData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              //DataGridCell<int>(columnName: 'id', value: e.id),
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell<String>(columnName: 'designation', value: e.result),
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
