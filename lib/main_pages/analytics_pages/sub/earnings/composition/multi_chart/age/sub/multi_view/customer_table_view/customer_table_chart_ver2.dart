import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import '../../../../../../../../../../MOD_PACKAGES/BH_touchFX/bh_touchfx.dart';
import '../../../../../../../../../../design_standards/colors.dart';
import '../../../../../../../../../../servicer_modules/shopping_mall_master.dart';

///Dart import
import 'dart:math' as math;

class CustomerTableViewChartV2 extends StatefulWidget {
  const CustomerTableViewChartV2({super.key});

  @override
  CustomerTableViewChartV2State createState() =>
      CustomerTableViewChartV2State();
}

class CustomerTableViewChartV2State extends State<CustomerTableViewChartV2> {
  // Default pager height
  static const double dataPagerHeight = 60;

  final ConditionalStyleDataGridSource conditionalStyleDataGridSource =
      ConditionalStyleDataGridSource();
  int _rowsPerPage = 15;
  late EmployeeDataSource _employeeDataSource;

  List<Employee> _employees = <Employee>[];
  @override
  initState() {
    _employees = getEmployeeData();
    _employeeDataSource = EmployeeDataSource(employees: _employees);
    super.initState();
  }

  @override
  Widget _buildDataGrid() {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      SfDataGridTheme(
          data: SfDataGridThemeData(headerColor: $$lightGrey),
          child: SfDataGrid(
            rowsPerPage: 15,
            allowColumnsResizing: true,
            selectionMode: SelectionMode.multiple,
            shrinkWrapRows: true,
            allowSorting: true,
            allowFiltering: true,
            source: conditionalStyleDataGridSource,
            columnWidthMode: ColumnWidthMode.fill,
            columns: <GridColumn>[
              GridColumn(
                columnName: 'name',
                width: double.nan,
                label: Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(8.0),
                  child: const Text(
                    'Name',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              GridColumn(
                columnName: 'qs1',
                width: double.nan,
                label: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: const Center(
                    child: Text(
                      'Q1',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
              GridColumn(
                columnName: 'qs2',
                width: double.nan,
                label: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: const Center(
                    child: Text(
                      'Q2',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
              GridColumn(
                columnName: 'qs3',
                width: double.nan,
                label: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: const Center(
                    child: Text(
                      'Q3',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
              GridColumn(
                columnName: 'qs4',
                width: double.nan,
                label: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: const Center(
                    child: Text(
                      'Q4',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ],
          ))
    ]);
  }

  List<Employee> getEmployeeData() {
    return [
      Employee(100011111, "남", '김00', '블랙 가디건', 1, 20000),
      Employee(100021111, "남", '최00', '화이트 니트', 2, 30000),
      Employee(100031111, "여", '박00', '데님 치마', 1, 15000),
      Employee(100041111, "여", '원00', '블랙 가디건', 1, 20000),
      Employee(100051111, "남", '이00', '화이트 니트', 1, 15000),
      Employee(100061111, "여", '이00', '데님 치마', 1, 15000),
      Employee(100071111, "여", '김00', '스키니 청바지', 3, 45000),
      Employee(100081111, "여", '박00', '스키니 청바지', 1, 15000),
      Employee(100091111, "여", '최00', '화이트 니트', 1, 15000),
      Employee(100101111, "여", '박00', '데님 치마', 1, 15000)
    ];
  }

  Widget _buildDataPager() {
    return SfDataPagerTheme(
      data: SfDataPagerThemeData(),
      child: SfDataPager(
        delegate: _employeeDataSource,
        availableRowsPerPage: const <int>[15, 20, 25],
        pageCount: 20,
        onRowsPerPageChanged: (int? rowsPerPage) {
          setState(() {
            _rowsPerPage = rowsPerPage!;
          });
        },
      ),
    );
  }

  Widget _buildLayoutBuilder() {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraint) {
      return Column(
        children: <Widget>[
          SizedBox(child: _buildDataGrid()),
          Container(
            height: dataPagerHeight,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface.withOpacity(0.12),
                border: Border(
                    top: BorderSide(
                        width: .5,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.12)))),
            child: Align(child: _buildDataPager()),
          )
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildLayoutBuilder();
  }
}

class Employee {
  Employee(
      this.id, this.gender, this.name, this.product, this.number, this.salary);
  final int id;
  final String gender;
  final String name;
  final String product;
  final int number;
  final int salary;
}

class EmployeeDataSource extends DataGridSource {
  EmployeeDataSource({required List<Employee> employees}) {
    dataGridRows = employees
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: dataGridRow.id),
              DataGridCell<String>(
                  columnName: "gender", value: dataGridRow.gender),
              DataGridCell<String>(columnName: 'name', value: dataGridRow.name),
              DataGridCell<String>(
                  columnName: 'designation', value: dataGridRow.product),
              DataGridCell(columnName: 'Number', value: dataGridRow.number),
              DataGridCell<int>(
                  columnName: 'salary', value: dataGridRow.salary),
            ]))
        .toList();
  }

  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
          alignment: (dataGridCell.columnName == 'id' ||
                  dataGridCell.columnName == 'salary')
              ? Alignment.centerRight
              : Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            dataGridCell.value.toString(),
            overflow: TextOverflow.ellipsis,
          ));
    }).toList());
  }
}

class ConditionalStyleDataGridSource extends DataGridSource {
  /// Creates the stock data source class with required details.
  ConditionalStyleDataGridSource() {
    _stocks = _getStocks(100);
    buildDataGridRows();
  }

  final math.Random _random = math.Random();

  List<Stock> _stocks = <Stock>[];

  List<DataGridRow> _dataGridRows = <DataGridRow>[];

  /// Rows are generated once and for CRUD operation we have to refresh
  /// the data row.
  void buildDataGridRows() {
    _dataGridRows = _stocks
        .map<DataGridRow>(
            (Stock dataGridRow) => DataGridRow(cells: <DataGridCell<dynamic>>[
                  DataGridCell<String>(
                    columnName: 'name',
                    value: dataGridRow.name,
                  ),
                  DataGridCell<double>(
                    columnName: 'qs1',
                    value: dataGridRow.qs1,
                  ),
                  DataGridCell<double>(
                    columnName: 'qs2',
                    value: dataGridRow.qs2,
                  ),
                  DataGridCell<double>(
                    columnName: 'qs3',
                    value: dataGridRow.qs3,
                  ),
                  DataGridCell<double>(
                    columnName: 'qs4',
                    value: dataGridRow.qs4,
                  ),
                ]))
        .toList();
  }

  // Building the Widget for each data cells
  Widget _buildQ1(double value) {
    if (value > 2000 && value < 2500) {
      return Container(
          padding: const EdgeInsets.all(4.0),
          color: const Color(0xFFF4C5B9),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              NumberFormat.currency(locale: 'en_US', symbol: r'$')
                  .format(value),
              style: const TextStyle(color: Colors.black),
              overflow: TextOverflow.ellipsis,
            ),
          ));
    } else if (value > 2500) {
      return Container(
          padding: const EdgeInsets.all(4.0),
          color: const Color(0xFFEB552C),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              NumberFormat.currency(locale: 'en_US', symbol: r'$')
                  .format(value),
              style: const TextStyle(color: Colors.white),
              overflow: TextOverflow.ellipsis,
            ),
          ));
    } else {
      return Container(
          padding: const EdgeInsets.all(4.0),
          color: const Color(0xFFEF8465),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              NumberFormat.currency(locale: 'en_US', symbol: r'$')
                  .format(value),
              style: const TextStyle(color: Color.fromRGBO(0, 0, 0, 1)),
              overflow: TextOverflow.ellipsis,
            ),
          ));
    }
  }

  Widget _buildQ2(double value) {
    if (value > 2000 && value < 2500) {
      return Container(
          padding: const EdgeInsets.all(4.0),
          color: const Color(0xFFF5BD16),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              NumberFormat.currency(locale: 'en_US', symbol: r'$')
                  .format(value),
              style: const TextStyle(color: Color.fromRGBO(0, 0, 0, 1)),
              overflow: TextOverflow.ellipsis,
            ),
          ));
    } else if (value > 2500) {
      return Container(
        padding: const EdgeInsets.all(4.0),
        color: const Color(0xFFF8DBAE),
        child: Align(
          alignment: Alignment.centerRight,
          child: Text(
            NumberFormat.currency(locale: 'en_US', symbol: r'$').format(value),
            style: const TextStyle(
              color: Color.fromRGBO(0, 0, 0, 1),
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.all(4.0),
        color: const Color(0xFFF8DBAE),
        child: Align(
          alignment: Alignment.centerRight,
          child: Text(
            NumberFormat.currency(locale: 'en_US', symbol: r'$').format(value),
            style: const TextStyle(color: Color.fromRGBO(0, 0, 0, 1)),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );
    }
  }

  Widget _buildQ3(double value) {
    if (value > 2000 && value < 4000) {
      return Container(
        padding: const EdgeInsets.all(4.0),
        color: const Color(0xFF8A3D94),
        child: Align(
          alignment: Alignment.centerRight,
          child: Text(
            NumberFormat.currency(locale: 'en_US', symbol: r'$').format(value),
            style: const TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );
    } else if (value > 4000) {
      return Container(
        padding: const EdgeInsets.all(4.0),
        color: const Color(0xFFC390C1),
        child: Align(
          alignment: Alignment.centerRight,
          child: Text(
            NumberFormat.currency(locale: 'en_US', symbol: r'$').format(value),
            style: const TextStyle(color: Color.fromRGBO(0, 0, 0, 1)),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.all(4.0),
        color: const Color(0xFFDEB6D5),
        child: Align(
          alignment: Alignment.centerRight,
          child: Text(
            NumberFormat.currency(locale: 'en_US', symbol: r'$').format(value),
            style: const TextStyle(color: Color.fromRGBO(0, 0, 0, 1)),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );
    }
  }

  Widget _buildQ4(double value) {
    if (value > 2000 && value < 3000) {
      return Container(
        padding: const EdgeInsets.all(4.0),
        color: const Color(0xFF7BC282),
        child: Align(
          alignment: Alignment.centerRight,
          child: Text(
            NumberFormat.currency(locale: 'en_US', symbol: r'$').format(value),
            style: const TextStyle(color: Colors.black),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );
    } else if (value > 3000) {
      return Container(
        padding: const EdgeInsets.all(4.0),
        color: const Color(0xFFC1DCA7),
        child: Align(
          alignment: Alignment.centerRight,
          child: Text(
            NumberFormat.currency(locale: 'en_US', symbol: r'$').format(value),
            style: const TextStyle(color: Colors.black),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );
    } else {
      return Container(
          padding: const EdgeInsets.all(4.0),
          color: const Color(0xFF4CAC4C),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              NumberFormat.currency(locale: 'en_US', symbol: r'$')
                  .format(value),
              style: const TextStyle(
                color: Color.fromRGBO(255, 255, 255, 1),
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ));
    }
  }

  // Override method

  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: <Widget>[
      Container(
        padding: const EdgeInsets.all(8.0),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text(row.getCells()[0].value.toString())),
      ),
      _buildQ1(row.getCells()[1].value),
      _buildQ2(row.getCells()[2].value),
      _buildQ3(row.getCells()[3].value),
      _buildQ4(row.getCells()[4].value)
    ]);
  }

  // Generating the stock data collection

  final List<String> _names = <String>[
    'Maciej',
    'Shelley',
    'Linda',
    'Shanon',
    'Jauna',
    'Michael',
    'Terry',
    'Julie',
    'Twanna',
    'Gary',
    'Carol',
    'James',
    'Martha'
  ];

  List<Stock> _getStocks(int count) {
    final List<Stock> stockData = <Stock>[];
    for (int i = 1; i < count; i++) {
      stockData.add(Stock(
        _names[i < _names.length ? i : _random.nextInt(_names.length - 1)],
        1800.0 + _random.nextInt(2000),
        1500.0 + _random.nextInt(1000),
        2000.0 + _random.nextInt(3000),
        1400.0 + _random.nextInt(4000),
      ));
    }
    return stockData;
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the stock which will be rendered in datagrid.
class Stock {
  /// Creates the stock class with required details.
  Stock(
    this.name,
    this.qs1,
    this.qs2,
    this.qs3,
    this.qs4,
  );

  /// Qs1 of the stock.
  final double qs1;

  /// Qs2 of the stock.
  final double qs2;

  /// Qs3 of the stock.
  final double qs3;

  /// Qs4 of the stock.
  final double qs4;

  /// Name of the stock.
  final String name;
}
