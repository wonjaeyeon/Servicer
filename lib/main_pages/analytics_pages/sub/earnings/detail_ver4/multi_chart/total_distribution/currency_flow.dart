// import 'package:flutter/material.dart';
// import 'package:servicer/design_standards/colors.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:syncfusion_flutter_datagrid/datagrid.dart';

// import '../../../../../../../data_handler/mapData_handler/mapData_time.dart';
// import '../../../../../../../data_handler/text/chart_text.dart';
// import '../../../../../../../design_standards/text_styles.dart';
// import '../../../../../../../design_standards/widget_styles.dart';

// import '../../../../../../../../data_handler/data_standards/time.dart';
// import '../../../../bottomsheet.dart';
// import '../../../abstract_class/abstractChart.dart';
// import 'sub/analysis/total_summary_analysis.dart';
// import 'package:syncfusion_flutter_core/theme.dart';

// class CurrencyFlowChart extends StatefulWidget {
//   CurrencyFlowChart({Key? key, required double width}) : super(key: key);

//   @override
//   State<CurrencyFlowChart> createState() => _CurrencyFlowChartState();
// }

// class _CurrencyFlowChartState extends State<CurrencyFlowChart> {
//   //late List<ExpenseData> _chartData;
//   late Time time;
//   late TooltipBehavior _tooltipBehavior;
//   List<bool> _isSelectedTime = [true, false, false, false, false, false];

//   List<Employee> employees = <Employee>[];
//   List<Employee> subEmployees = <Employee>[];
//   late EmployeeDataSource employeeDataSource;
//   late EmployeeDataSource subEmployeeDataSource;
// // AnimatedOpacity를 위한 변수
//   bool _visible = true;
//   @override
//   void initState() {
//     time = Time.day;
//     //_chartData = getChartData(widget.time);
//     _tooltipBehavior = TooltipBehavior(enable: true, color: $$Grey, opacity: 1);
//     employees = getEmployeeData();
//     employeeDataSource = EmployeeDataSource(employeeData: employees);
//     subEmployees = getSubEmployeeData();
//     subEmployeeDataSource = EmployeeDataSource(employeeData: subEmployees);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       scrollDirection: Axis.vertical,
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       children: [
//         const SizedBox(
//           height: 10,
//         ),
//         //현재 그래프 기간
//         Padding(
//           padding: $AnalyticsPageHorizontalPadding,
//           child: Text(getTimeRange(time),
//               style: TextStyle(fontSize: $mediumFontSize - 2)),
//         ),
//         const SizedBox(
//           height: 10,
//         ),

//         Container(
//           margin: EdgeInsets.symmetric(horizontal: 0),
//           padding: EdgeInsets.symmetric(vertical: 16),
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             // borderRadius: BorderRadius.circular(16),
//             border: Border.all(color: Colors.transparent),
//           ),
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: Align(
//                   alignment: Alignment.topLeft,
//                   child: Text(
//                     '매출액 요약 정리',
//                     style: TextStyle(fontSize: 15),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 4),
//               Padding(
//                 padding: $AnalyticsPageHorizontalPadding,
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.2),
//                         spreadRadius: 2,
//                         blurRadius: 5,
//                         offset:
//                             const Offset(0, 3), // changes position of shadow
//                       ),
//                     ],
//                   ),
//                   child: SfDataGridTheme(
//                     data: SfDataGridThemeData(headerColor: $$lightGrey),
//                     child: SfDataGrid(
//                       verticalScrollPhysics:
//                           const NeverScrollableScrollPhysics(),
//                       horizontalScrollPhysics:
//                           const NeverScrollableScrollPhysics(),
//                       source: employeeDataSource,
//                       columnWidthMode: ColumnWidthMode.fill,
//                       shrinkWrapRows: true,
//                       columns: <GridColumn>[
//                         // GridColumn(
//                         //     columnName: 'id',
//                         //     label: Container(
//                         //         padding: EdgeInsets.all(16.0),
//                         //         alignment: Alignment.center,
//                         //         child: Text(
//                         //           'ID',
//                         //         ))),
//                         GridColumn(
//                             columnName: 'name',
//                             label: Container(
//                               padding: EdgeInsets.all(8.0),
//                               alignment: Alignment.center,
//                               child: Text('분석항목',
//                                   style: const TextStyle(
//                                       fontFamily: 'IBMPlexSansKR')),
//                             )),
//                         GridColumn(
//                             columnName: 'designation',
//                             label: Container(
//                                 padding: EdgeInsets.all(8.0),
//                                 alignment: Alignment.center,
//                                 child: Text(
//                                   '결과값',
//                                   style: const TextStyle(
//                                       fontFamily: 'IBMPlexSansKR'),
//                                   overflow: TextOverflow.ellipsis,
//                                 ))),
//                         // GridColumn(
//                         //     columnName: 'salary',
//                         //     label: Container(
//                         //         padding: EdgeInsets.all(8.0),
//                         //         alignment: Alignment.center,
//                         //         child: Text('Salary'))),
//                       ],
//                       gridLinesVisibility: GridLinesVisibility.both,
//                       headerGridLinesVisibility: GridLinesVisibility.both,
//                     ),
//                   ),
//                 ),
//               ),
//               const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
//             ],
//           ),
//         ),
//         TimeClicker(
//           isSelectedTime: _isSelectedTime,
//           callbackFunction: callbackFunction,
//         ),
//         const SizedBox(
//           height: 4,
//         ),
//         TSChartAnalysis(
//           timeRange: getTimeRange(time),
//           unit: "원",
//         ),
//         const SizedBox(
//           height: 4,
//         ),
//         const SizedBox(
//           height: 10,
//         ),
//       ],
//     );
//   }

//   Future<void> callbackFunction(int newIndex) async {
//     setState(() {
//       //_visible = false;
//       for (int i = 0; i < _isSelectedTime.length; i++) {
//         if (i == newIndex) {
//           _isSelectedTime[i] = true;
//         } else {
//           _isSelectedTime[i] = false;
//           switch (newIndex) {
//             case 0:
//               //sleep(Duration(milliseconds: 50));
//               time = Time.day;
//               break;
//             case 1:
//               time = Time.week;
//               break;
//             case 2:
//               time = Time.month;
//               break;
//             case 3:
//               time = Time.year;
//               break;
//             case 4:
//               time = Time.all;
//               break;
//             case 5:
//               break;
//           }
//         }
//         //print(_isSelectedTime);
//       }
//       if (newIndex == 5) {
//         final data = BottomSheetTime().makeShowModalBottomSheet(context);
//         //print startDate whien Navigor.pop
//         data.then((value) {
//           if (value != null) {
//             print(value["startDate"]);
//           }
//         });
//       } else {
//         _visible = false;
//       }
//     });
//     await Future.delayed(Duration(milliseconds: 800));
//   }

//   List<Employee> getEmployeeData() {
//     return [
//       Employee('매출합계', makeSubTable()),
//       Employee('매출평균(1일)', makeSubTable()),
//       Employee('매출추세', Text("A")),
//       //Employee("예상 마진", '23.3만원'),
//       Employee("기간 내 총매출 중 비중", Text("A")),
//       Employee("상품 가격 범위", Text("A")),
//       Employee("상품 평균가", Text("A")),
//     ];
//   }

//   List<Employee> getSubEmployeeData() {
//     return [
//       Employee('매출합계', Text("A")),
//       Employee('매출평균(1일)', Text("A")),
//     ];
//   }

//   Widget makeSubTable() {
//     //make a sub table using SfDataGrid
//     return SfDataGrid(
//       source: subEmployeeDataSource,
//       columnWidthMode: ColumnWidthMode.fill,
//       columns: <GridColumn>[
//         GridColumn(
//             width: 160,
//             columnName: 'name',
//             label: Container(
//               padding: EdgeInsets.all(8.0),
//               alignment: Alignment.center,
//               child: Text('분석항목',
//                   style: const TextStyle(fontFamily: 'IBMPlexSansKR')),
//             )),
//         GridColumn(
//             width: 160,
//             columnName: 'designation',
//             label: Container(
//                 padding: EdgeInsets.all(8.0),
//                 alignment: Alignment.center,
//                 child: Text(
//                   '결과값',
//                   style: const TextStyle(fontFamily: 'IBMPlexSansKR'),
//                   overflow: TextOverflow.ellipsis,
//                 ))),
//       ],
//       gridLinesVisibility: GridLinesVisibility.both,
//       headerGridLinesVisibility: GridLinesVisibility.both,
//     );
//   }
// }

// /// Custom business object class which contains properties to hold the detailed
// /// information about the employee which will be rendered in datagrid.
// class Employee {
//   /// Creates the employee class with required details.
//   Employee(
//     this.name,
//     this.designation,
//   );

//   /// Id of an employee.
//   //final int id;

//   /// Name of an employee.
//   final String name;

//   /// Designation of an employee.
//   final Widget designation;

//   /// Salary of an employee.
//   //final int salary;
// }

// /// An object to set the employee collection data source to the datagrid. This
// /// is used to map the employee data to the datagrid widget.
// class EmployeeDataSource extends DataGridSource {
//   /// Creates the employee data source class with required details.
//   EmployeeDataSource({required List<Employee> employeeData}) {
//     _employeeData = employeeData
//         .map<DataGridRow>((e) => DataGridRow(cells: [
//               //DataGridCell<int>(columnName: 'id', value: e.id),
//               DataGridCell<String>(columnName: 'name', value: e.name),
//               DataGridCell<Widget>(
//                   columnName: 'designation', value: e.designation),
//               //DataGridCell<int>(columnName: 'salary', value: e.salary),
//             ]))
//         .toList();
//   }

//   List<DataGridRow> _employeeData = [];

//   @override
//   List<DataGridRow> get rows => _employeeData;

//   @override
//   DataGridRowAdapter buildRow(DataGridRow row) {
//     return DataGridRowAdapter(cells: <Widget>[
//       Container(
//         padding: EdgeInsets.all(8.0),
//         alignment: Alignment.center,
//         child: Text(row.getCells()[0].value.toString(),
//             style: const TextStyle(fontFamily: 'IBMPlexSansKR')),
//       ),
//       Container(
//         alignment: Alignment.center,
//         child: row.getCells()[1].value,
//       ),
//     ]);
//   }
// }

// //make a function inputs time and outputs time range by subtract time from today
// String getTimeRange(Time time) {
//   DateTime now = DateTime.now();
//   String today = '${now.year}.${now.month}.${now.day}';

//   // get StartDate by subtracting time from today
//   DateTime startDate = now.subtract(Duration(days: getTimeLength(time)));
//   String start = '${startDate.year}.${startDate.month}.${startDate.day}';
//   return '$start ~ $today';
// }
