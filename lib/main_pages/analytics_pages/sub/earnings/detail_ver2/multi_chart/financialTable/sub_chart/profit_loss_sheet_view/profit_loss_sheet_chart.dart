import 'package:flutter/material.dart';
import 'package:servicer/design_standards/colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import '../../../../../../../../../data_handler/data_standards/time.dart';

class ProfitLossSubChartContainer extends StatefulWidget {
  final double width;
  final Time time;
  const ProfitLossSubChartContainer(
      {Key? key, required this.time, required this.width})
      : super(key: key);

  @override
  State<ProfitLossSubChartContainer> createState() =>
      ProfitLossSubChartContainerState();
}

class ProfitLossSubChartContainerState
    extends State<ProfitLossSubChartContainer> {
  List<Element> assets = <Element>[];
  late ElementDataSource assetsDataSource;

  @override
  void initState() {
    super.initState();
    assets = getAssetData();
    assetsDataSource = ElementDataSource(ElementData: assets);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          // borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.transparent),
        ),
        child: makeAssetTable(),
      ),
    );
  }

  Widget makeAssetTable() {
    return SfDataGridTheme(
      data: SfDataGridThemeData(headerColor: $$lightGrey),
      child: SfDataGrid(
        verticalScrollPhysics: const NeverScrollableScrollPhysics(),
        horizontalScrollPhysics: const NeverScrollableScrollPhysics(),
        headerRowHeight: 30,
        source: assetsDataSource,
        columnWidthMode: ColumnWidthMode.fill,
        shrinkWrapRows: true,
        stackedHeaderRows: <StackedHeaderRow>[
          StackedHeaderRow(cells: <StackedHeaderCell>[
            StackedHeaderCell(
                columnNames: <String>["name", "designation"],
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.center,
                  child: Text('손익계산서',
                      style: const TextStyle(fontFamily: 'IBMPlexSansKR')),
                )),
          ])
        ],
        columns: <GridColumn>[
          GridColumn(
              columnName: 'name',
              label: Container(
                padding: EdgeInsets.all(0.0),
                alignment: Alignment.center,
                child: Text('항목',
                    style: const TextStyle(fontFamily: 'IBMPlexSansKR')),
              )),
          GridColumn(
              columnName: 'designation',
              label: Container(
                  padding: EdgeInsets.all(0.0),
                  alignment: Alignment.center,
                  child: Text(
                    '결과',
                    style: const TextStyle(fontFamily: 'IBMPlexSansKR'),
                    overflow: TextOverflow.ellipsis,
                  ))),
        ],
        gridLinesVisibility: GridLinesVisibility.both,
        headerGridLinesVisibility: GridLinesVisibility.both,
      ),
    );
  }

  List<Element> getAssetData() {
    return [
      Element('매출액', '+50.6만원'),
      Element('매출원가', '-20만원'),
      Element('매출총이익', '30.6만원'),
      Element('판매비와관리비', '-20만원'),
      Element('영업이익', '30.6만원'),
      Element('영엽외이익', '+20만원'),
      Element('이익총합', '50.6만원'),
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
class ElementDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  ElementDataSource({required List<Element> ElementData}) {
    _employeeData = ElementData.map<DataGridRow>((e) => DataGridRow(cells: [
          //DataGridCell<int>(columnName: 'id', value: e.id),
          DataGridCell<String>(columnName: 'name', value: e.name),
          DataGridCell<String>(columnName: 'designation', value: e.result),
          //DataGridCell<int>(columnName: 'salary', value: e.salary),
        ])).toList();
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
