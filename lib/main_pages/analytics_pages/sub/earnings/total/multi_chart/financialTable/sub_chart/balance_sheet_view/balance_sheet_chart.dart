import 'package:flutter/material.dart';
import 'package:servicer/design_standards/colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import '../../../../../../../../../data_handler/data_standards/time.dart';

class BalanceSheetSubChartContainer extends StatefulWidget {
  final double width;
  final Time time;
  const BalanceSheetSubChartContainer(
      {Key? key, required this.time, required this.width})
      : super(key: key);

  @override
  State<BalanceSheetSubChartContainer> createState() =>
      BalanceSheetSubChartContainerState();
}

class BalanceSheetSubChartContainerState
    extends State<BalanceSheetSubChartContainer> {
  List<Element> assets = <Element>[];
  late ElementDataSource assetsDataSource;
  List<Element> debt = <Element>[];
  late ElementDataSource debtsDataSource;
  List<Element> equity = <Element>[];
  late ElementDataSource equitysDataSource;

  @override
  void initState() {
    super.initState();
    assets = getAssetData();
    assetsDataSource = ElementDataSource(ElementData: assets);
    debt = getDebtData();
    debtsDataSource = ElementDataSource(ElementData: debt);
    equity = getEquityData();
    equitysDataSource = ElementDataSource(ElementData: equity);
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: Align(
                    alignment: Alignment.center,
                    child: AspectRatio(
                        aspectRatio: 0.7, child: makeAssetTable()))),
            const SizedBox(
              width: 8,
            ),
            Expanded(
                child: Align(
              alignment: Alignment.center,
              child: AspectRatio(
                aspectRatio: 0.7,
                child: Column(
                  children: [
                    Expanded(child: makeDebtTable()),
                    const SizedBox(
                      height: 8,
                    ),
                    Expanded(child: makeEquityTable()),
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }

  Widget makeAssetTable() {
    return SfDataGridTheme(
      data: SfDataGridThemeData(headerColor: $$lightGrey),
      child: SfDataGrid(
        verticalScrollPhysics: const NeverScrollableScrollPhysics(),
        horizontalScrollPhysics: const NeverScrollableScrollPhysics(),
        headerRowHeight: 20,
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
                  child: Text('자산항목',
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

  Widget makeDebtTable() {
    return SfDataGridTheme(
      data: SfDataGridThemeData(headerColor: $$lightGrey),
      child: SfDataGrid(
        verticalScrollPhysics: const NeverScrollableScrollPhysics(),
        horizontalScrollPhysics: const NeverScrollableScrollPhysics(),
        headerRowHeight: 20,
        source: debtsDataSource,
        columnWidthMode: ColumnWidthMode.fill,
        shrinkWrapRows: true,
        stackedHeaderRows: <StackedHeaderRow>[
          StackedHeaderRow(cells: <StackedHeaderCell>[
            StackedHeaderCell(
                columnNames: <String>["name", "designation"],
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.center,
                  child: Text('부채항목',
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

  Widget makeEquityTable() {
    return SfDataGridTheme(
      data: SfDataGridThemeData(headerColor: $$lightGrey),
      child: SfDataGrid(
        verticalScrollPhysics: const NeverScrollableScrollPhysics(),
        horizontalScrollPhysics: const NeverScrollableScrollPhysics(),
        headerRowHeight: 20,
        source: equitysDataSource,
        columnWidthMode: ColumnWidthMode.fill,
        shrinkWrapRows: true,
        stackedHeaderRows: <StackedHeaderRow>[
          StackedHeaderRow(cells: <StackedHeaderCell>[
            StackedHeaderCell(
                columnNames: <String>["name", "designation"],
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.center,
                  child: Text('자본항목',
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
      Element('현금', '20.6만원'),
      Element('매출채권', '20만원'),
      Element('기타', '10만원'),
      Element('총자산', '50.6만원'),
    ];
  }

  List<Element> getDebtData() {
    return [
      Element('부채 총계', '20만원'),
    ];
  }

  List<Element> getEquityData() {
    return [
      Element('자본 총계', '30.6만원'),
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
