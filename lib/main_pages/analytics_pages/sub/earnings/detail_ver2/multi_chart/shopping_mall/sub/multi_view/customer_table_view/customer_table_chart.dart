import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import '../../../../../../../../../../MOD_PACKAGES/BH_touchFX/bh_touchfx.dart';
import '../../../../../../../../../../design_standards/colors.dart';
import '../../../../../../../../../../servicer_modules/shopping_mall_master.dart';

class CustomerTableViewChart extends StatefulWidget {
  const CustomerTableViewChart({super.key});

  @override
  CustomerTableViewChartState createState() => CustomerTableViewChartState();
}

class CustomerTableViewChartState extends State<CustomerTableViewChart> {
  late EmployeeDataSource _employeeDataSource;
  late Map<String, double> columnWidths = {
    'id': double.nan,
    'gender': double.nan,
    'name': double.nan,
    'designation': double.nan,
    'salary': double.nan
  };
  List<Employee> _employees = <Employee>[];
  @override
  initState() {
    _employees = getEmployeeData();
    _employeeDataSource = EmployeeDataSource(employees: _employees);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SfDataGridTheme(
          data: SfDataGridThemeData(headerColor: $$lightGrey),
          child: SfDataGrid(
              onColumnResizeUpdate: (ColumnResizeUpdateDetails details) {
                setState(() {
                  columnWidths[details.column.columnName] = details.width;
                });
                return true;
              },
              allowColumnsResizing: true,
              selectionMode: SelectionMode.multiple,
              shrinkWrapRows: true,
              allowSorting: true,
              allowFiltering: true,
              gridLinesVisibility: GridLinesVisibility.both,
              headerGridLinesVisibility: GridLinesVisibility.both,
              columnWidthMode: ColumnWidthMode.auto,
              source: _employeeDataSource,
              columns: [
                GridColumn(
                    width: columnWidths['id']!,
                    filterPopupMenuOptions: FilterPopupMenuOptions(
                        filterMode: FilterMode.checkboxFilter),
                    columnName: 'ID',
                    label: Container(
                        padding: EdgeInsets.symmetric(horizontal: 2.0),
                        alignment: Alignment.centerRight,
                        child: Text(
                          '주문ID',
                          overflow: TextOverflow.ellipsis,
                        ))),
                GridColumn(
                    width: columnWidths['gender']!,
                    columnName: 'Gender',
                    label: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '성별',
                          overflow: TextOverflow.ellipsis,
                        ))),
                GridColumn(
                    columnName: 'Name',
                    label: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '이름',
                          overflow: TextOverflow.ellipsis,
                        ))),
                GridColumn(
                    columnName: 'Designation',
                    label: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '상품명',
                          overflow: TextOverflow.ellipsis,
                        ))),
                GridColumn(
                    columnName: 'Number',
                    label: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '주문수량',
                          overflow: TextOverflow.ellipsis,
                        ))),
                GridColumn(
                    columnName: 'Salary',
                    label: Container(
                        padding: EdgeInsets.symmetric(horizontal: 2.0),
                        alignment: Alignment.centerRight,
                        child: Text(
                          '건별 매출',
                          overflow: TextOverflow.ellipsis,
                        ))),
              ]),
        ),
        // MaterialButton(
        //     child: Text('Add Filter'),
        //     onPressed: () {
        //       // _employeeDataSource.addFilter('ID',
        //       //     FilterCondition(type: FilterType.lessThan, value: 1005));
        //       _employeeDataSource.addFilter('ID',
        //           FilterCondition(type: FilterType.greaterThan, value: 1005));
        //     }),
      ],
    );
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
