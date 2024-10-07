import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

///Dart import
import 'dart:math' as math;

class CustomerTableViewChartV3 extends StatefulWidget {
  const CustomerTableViewChartV3({super.key});

  @override
  CustomerTableViewChartV3State createState() =>
      CustomerTableViewChartV3State();
}

class CustomerTableViewChartV3State extends State<CustomerTableViewChartV3> {
  // Default pager height
  static const double dataPagerHeight = 60;

  /// Determine to decide whether the device in landscape or in portrait.
  bool isLandscapeInMobileView = false;

  int _rowsPerPage = 10;

  /// DataGridSource required for SfDataGrid to obtain the row data.
  late OrderInfoDataGridSource orderInfoDataSource;

  @override
  void initState() {
    orderInfoDataSource =
        OrderInfoDataGridSource(isWebOrDesktop: true, orderDataCount: 300);
    super.initState();
  }

  Widget _buildDataGrid() {
    return SfDataGrid(
        source: orderInfoDataSource,
        rowsPerPage: _rowsPerPage,
        verticalScrollPhysics: NeverScrollableScrollPhysics(),
        //allowColumnsResizing: true,
        selectionMode: SelectionMode.multiple,
        shrinkWrapRows: true,
        allowSorting: true,
        allowFiltering: true,
        gridLinesVisibility: GridLinesVisibility.both,
        headerGridLinesVisibility: GridLinesVisibility.both,
        columnWidthMode: ColumnWidthMode.auto,
        columns: <GridColumn>[
          GridColumn(
            width: 160,
            columnName: 'id',
            label: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.centerLeft,
              child: const Text(
                '주문번호',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          GridColumn(
            width: double.nan,
            columnWidthMode: ColumnWidthMode.fitByColumnName,
            autoFitPadding: const EdgeInsets.all(8),
            columnName: 'customerId',
            label: Container(
              padding: const EdgeInsets.all(8),
              alignment: Alignment.centerLeft,
              child: const Text(
                '소비자ID',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          GridColumn(
            width: double.nan,
            columnName: 'age',
            columnWidthMode: ColumnWidthMode.fitByColumnName,
            label: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              alignment: Alignment.centerLeft,
              child: const Text(
                '연령대',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          GridColumn(
            width: double.nan,
            columnName: 'name',
            label: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              alignment: Alignment.centerLeft,
              child: const Text(
                '이름',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          GridColumn(
            width: double.nan,
            columnName: 'productName',
            label: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              alignment: Alignment.centerLeft,
              child: const Text(
                '상품명',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          GridColumn(
            width: double.nan,
            columnName: 'productPrice',
            label: Container(
              padding: const EdgeInsets.all(8),
              alignment: Alignment.centerLeft,
              child: const Text(
                '상품가',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          GridColumn(
            width: double.nan,
            columnName: 'order',
            label: Container(
              padding: const EdgeInsets.all(8),
              alignment: Alignment.centerLeft,
              child: const Text(
                '주문건',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          GridColumn(
            width: double.nan,
            columnName: 'price',
            label: Container(
              padding: const EdgeInsets.all(8),
              alignment: Alignment.centerRight,
              child: const Text(
                '건별 매출',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
        ]);
  }

  Widget _buildDataPager() {
    return SfDataPagerTheme(
      data: SfDataPagerThemeData(),
      child: SfDataPager(
        delegate: orderInfoDataSource,
        availableRowsPerPage: const <int>[15, 20, 25],
        pageCount: orderInfoDataSource.orders.length / _rowsPerPage,
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

class OrderInfoDataGridSource extends DataGridSource {
  /// Creates the order data source class with required details.
  OrderInfoDataGridSource(
      {required this.isWebOrDesktop,
      this.orderDataCount,
      this.ordersCollection,
      this.culture,
      bool? isFilteringSample}) {
    this.isFilteringSample = isFilteringSample ?? false;
    orders = ordersCollection ??
        getOrders(orders, orderDataCount ?? 100, culture: culture ?? '');
    currencySymbol = getCurrencySymbol();
    buildDataGridRows();
  }

  /// Determine to decide whether the platform is web or desktop.
  final bool isWebOrDesktop;

  /// Localization Source.
  String? culture;

  /// Get data count of an order.
  int? orderDataCount;
  final math.Random _random = math.Random();

  /// Instance of an order.
  List<OrderInfo> orders = <OrderInfo>[];

  /// Instance of an order collection for rtl sample
  List<OrderInfo>? ordersCollection;

  /// Instance of DataGridRow.
  List<DataGridRow> dataGridRows = <DataGridRow>[];

  /// Currency symbol for culture.
  String currencySymbol = '';

  /// Checks whether the source is used for the filtering sample or not.
  late bool isFilteringSample;

  /// Building DataGridRows.
  void buildDataGridRows() {
    dataGridRows = isWebOrDesktop
        ? orders.map<DataGridRow>((OrderInfo order) {
            return DataGridRow(cells: <DataGridCell>[
              DataGridCell<int>(
                  columnName: getColumnName('id'), value: order.id),
              DataGridCell<int>(
                  columnName: getColumnName('customerId'),
                  value: order.customerId),
              DataGridCell<int>(
                  columnName: getColumnName('age'), value: order.age),
              DataGridCell<String>(
                  columnName: getColumnName('name'), value: order.name),
              DataGridCell<String>(
                  columnName: getColumnName('productName'),
                  value: order.productName),
              DataGridCell<double>(
                  columnName: getColumnName('productPrice'),
                  value: order.productPrice),
              DataGridCell<int>(
                  columnName: getColumnName('order'), value: order.order),
              DataGridCell<double>(
                  columnName: getColumnName('price'),
                  value: order.totalEarnings),
            ]);
          }).toList()
        : orders.map<DataGridRow>((OrderInfo order) {
            return DataGridRow(cells: <DataGridCell>[
              DataGridCell<int>(
                  columnName: getColumnName('id'), value: order.id),
              DataGridCell<int>(
                  columnName: getColumnName('customerId'),
                  value: order.customerId),
              DataGridCell<int>(
                  columnName: getColumnName('age'), value: order.age),
              DataGridCell<String>(
                  columnName: getColumnName('name'), value: order.name),
              DataGridCell<String>(
                  columnName: getColumnName('productName'),
                  value: order.productName),
              DataGridCell<double>(
                  columnName: getColumnName('productPrice'),
                  value: order.productPrice),
              DataGridCell<int>(
                  columnName: getColumnName('order'), value: order.order),
            ]);
          }).toList();
  }

  // Overrides

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final int rowIndex = dataGridRows.indexOf(row);
    Color backgroundColor = Colors.transparent;

    if (isWebOrDesktop) {
      return DataGridRowAdapter(color: backgroundColor, cells: <Widget>[
        Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.centerLeft,
          child: Text(
            row.getCells()[0].value.toString(),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.centerLeft,
          child: Text(
            row.getCells()[1].value.toString(),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
            padding: const EdgeInsets.all(8),
            alignment: Alignment.centerLeft,
            child: getAgeWidget(row.getCells()[2].value.toDouble())),
        Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.centerLeft,
          child: Text(
            row.getCells()[3].value.toString(),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.centerLeft,
          child: Text(
            row.getCells()[4].value.toString(),
          ),
        ),
        Container(
            padding: const EdgeInsets.all(8),
            alignment: Alignment.centerLeft,
            // child: Text(
            //     // NumberFormat.currency(locale: 'en_US', symbol: currencySymbol)
            //     //     .format(row.getCells()[5].value)
            //     //make NumberFormat.currency in korean currency
            //     '${row.getCells()[4].value.toInt()}원'),
            child: getPriceWidget(row.getCells()[5].value)),
        Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.centerLeft,
          child: Text(
            row.getCells()[6].value.toString(),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.centerLeft,
          child: Text('${row.getCells()[7].value.toInt()}원'),
        ),
      ]);
    } else {
      Widget buildWidget({
        AlignmentGeometry alignment = Alignment.centerLeft,
        EdgeInsetsGeometry padding = const EdgeInsets.all(8.0),
        TextOverflow textOverflow = TextOverflow.ellipsis,
        required Object value,
      }) {
        return Container(
          padding: padding,
          alignment: alignment,
          child: Text(
            value.toString(),
            overflow: textOverflow,
          ),
        );
      }

      return DataGridRowAdapter(
          color: backgroundColor,
          cells: row.getCells().map<Widget>((DataGridCell dataCell) {
            // if (dataCell.columnName == getColumnName('id') ||
            //     dataCell.columnName == getColumnName('customerId')) {
            //   return buildWidget(
            //       alignment: Alignment.centerLeft, value: dataCell.value!);
            // } else {
            return buildWidget(value: dataCell.value!);
            //}
          }).toList(growable: true));
    }
  }

  /// Currency symbol
  String getCurrencySymbol() {
    if (culture != null) {
      final format = NumberFormat.compactSimpleCurrency();
      return format.currencySymbol;
    } else {
      final format = NumberFormat.simpleCurrency();
      return format.currencySymbol;
    }
  }

  @override
  Future<void> handleLoadMoreRows() async {
    await Future<void>.delayed(const Duration(seconds: 5));
    orders = getOrders(orders, 15);
    buildDataGridRows();
    notifyListeners();
  }

  @override
  Future<void> handleRefresh() async {
    await Future<void>.delayed(const Duration(seconds: 5));
    orders = getOrders(orders, 15);
    buildDataGridRows();
    notifyListeners();
  }

  @override
  Widget? buildTableSummaryCellWidget(
      GridTableSummaryRow summaryRow,
      GridSummaryColumn? summaryColumn,
      RowColumnIndex rowColumnIndex,
      String summaryValue) {
    Widget? widget;
    Widget buildCell(String value, EdgeInsets padding, Alignment alignment) {
      return Container(
        padding: padding,
        alignment: alignment,
        child: Text(value,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w500)),
      );
    }

    if (summaryRow.showSummaryInRow) {
      widget = buildCell(
          summaryValue, const EdgeInsets.all(16.0), Alignment.centerLeft);
    } else if (summaryValue.isNotEmpty) {
      if (summaryColumn!.columnName == 'productPrice') {
        summaryValue = double.parse(summaryValue).toStringAsFixed(2);
      }

      summaryValue = 'Sum: ' +
          NumberFormat.currency(locale: 'en_US', decimalDigits: 0, symbol: r'$')
              .format(double.parse(summaryValue));

      widget = buildCell(
          summaryValue, const EdgeInsets.all(8.0), Alignment.centerRight);
    }
    return widget;
  }

  /// Provides the column name.
  String getColumnName(String columnName) {
    if (isFilteringSample) {
      switch (columnName) {
        case 'id':
          return 'Order ID';
        case 'customerId':
          return 'Customer ID';
        case 'name':
          return 'Name';
        case 'productName':
          return 'productName';
        case 'productPrice':
          return 'productPrice';
        case 'order':
          return 'order';
        case 'price':
          return 'Price';
        default:
          return columnName;
      }
    }
    return columnName;
  }

  /// Update DataSource
  void updateDataSource() {
    notifyListeners();
  }

  //  Order Data's
  final List<String> _names = <String>[
    '김00',
    '박00',
    '최00',
    '이00',
    '정00',
    '강00',
    '조00',
    '윤00',
    '장00',
    '임00',
    '한00',
    '박00',
    '김00',
    '최00',
    '이00',
  ];

  //  Order Data's
  final List<String> _productNames = <String>[
    '블랙 가디건',
    '화이트 니트',
    '데님 치마',
    '블랙 가디건',
    '화이트 니트',
    '데님 치마',
    '스키니 청바지',
    '스키니 청바지',
    '화이트 니트',
    '데님 치마',
    '블랙 가디건',
    '화이트 니트',
    '데님 치마',
    '데님 치마',
    '블랙 가디건',
  ];

  final List<String> _frenchNames = <String>[
    'Crowley',
    'Blonp',
    'Folko',
    'Irvine',
    'Folig',
    'Pico',
    'François',
    'Warth',
    'Linod',
    'Simop',
    'Merep',
    'Riscu',
    'Sèves',
    'Vaffé',
    'Alfki',
  ];

  final List<String> _spanishNames = <String>[
    'Crowley',
    'Blonp',
    'Folko',
    'Irvine',
    'Folig',
    'Cima',
    'francés',
    'Warth',
    'lindod',
    'Simop',
    'Merep',
    'Riesgo',
    'Suyas',
    'Gofre',
    'Alfki',
  ];

  final List<String> _chineseNames = <String>[
    '克勞利',
    '布隆普',
    '民間',
    '爾灣',
    '佛利格',
    '頂峰',
    '法語',
    '沃思',
    '林諾德',
    '辛普',
    '梅雷普',
    '風險',
    '塞維斯',
    '胡扯',
    '阿里基',
  ];

  final List<String> _arabicNames = <String>[
    'كراولي',
    'بلونب',
    'فولكو',
    'ايرفين',
    'فوليج',
    'بيكو',
    'فرانس',
    'وارث',
    'لينود',
    'سيموب',
    'مرحى',
    'ريسكو',
    'السباعيات',
    'فافي',
    'الفكي',
  ];

  final List<String> _cities = <String>[
    'Bruxelles',
    'Rosario',
    'Recife',
    'Graz',
    'Montreal',
    'Tsawassen',
    'Campinas',
    'Resende',
  ];

  final List<String> _chineseCties = <String>[
    '布魯塞爾',
    '羅薩里奧',
    '累西腓',
    '格拉茨',
    '蒙特利爾',
    '薩瓦森',
    '坎皮納斯',
    '重新發送',
  ];

  final List<String> _frenchCties = <String>[
    'Bruxelles',
    'Rosario',
    'Récife',
    'Graz',
    'Montréal',
    'Tsawassen',
    'Campinas',
    'Renvoyez',
  ];

  final List<String> _spanishCties = <String>[
    'Bruselas',
    'Rosario',
    'Recife',
    'Graz',
    'Montréal',
    'Tsawassen',
    'Campiñas',
    'Reenviar',
  ];

  final List<String> _arabicCties = <String>[
    ' بروكسل',
    'روزاريو',
    'ريسيفي',
    'غراتس',
    'مونتريال',
    'تساواسن',
    'كامبيناس',
    'ريسيندي',
  ];

  /// Get orders collection
  List<OrderInfo> getOrders(List<OrderInfo> orderData, int count,
      {String? culture}) {
    final int startIndex = orderData.isNotEmpty ? orderData.length : 0,
        endIndex = startIndex + count;
    List<String> order;
    List<String> names;

    if (culture == 'Chinese') {
      order = _chineseCties;
      names = _chineseNames;
    } else if (culture == 'Arabic') {
      order = _arabicCties;
      names = _arabicNames;
    } else if (culture == 'French') {
      order = _frenchCties;
      names = _frenchNames;
    } else if (culture == 'Spanish') {
      order = _spanishCties;
      names = _spanishNames;
    } else {
      order = _cities;
      names = _names;
    }

    for (int i = startIndex; i < endIndex; i++) {
      orderData.add(OrderInfo(
        1000 + i,
        1700 + i,
        _random.nextInt(70) + 10,
        names[i < names.length ? i : _random.nextInt(names.length - 1)],
        _productNames[i < _productNames.length
            ? i
            : _random.nextInt(_productNames.length - 1)],
        _random.nextInt(7) * 1000 + 6000, //+ _random.nextDouble(),
        _random.nextInt(2) + 1,
        (_random.nextInt(7) * 1000 + 6000) * (_random.nextInt(2) + 1),
      ));
    }
    return orderData;
  }

  Widget getPriceWidget(double price) {
    Color color = Colors.orange;
    if (price < 5000) {
      color = Color(0xFFffe0b2);
    } else if (price < 6000) {
      color = Color(0xFFffcc80);
    } else if (price < 7000) {
      color = Color(0xFFffb74d);
    } else if (price < 8000) {
      color = Color(0xFFffa726);
    } else if (price < 9000) {
      color = Color(0xFFff9800);
    } else if (price < 10000) {
      color = Color(0xFFfb8c00);
    } else if (price < 11000) {
      color = Color(0xFFf57c00);
    } else if (price < 12000) {
      color = Color(0xFFef6c00);
    } else if (price < 13000) {
      color = Color(0xFFe65100);
    } else if (price < 14000) {
      color = Color(0xFFd84315);
    }

    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(
              Radius.circular(4),
            ),
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(price.toInt().toString() + "원")
      ],
    );
  }

  Widget getAgeWidget(double age) {
    Color color = Colors.green;
    if (age < 20) {
      color = Color(0xFFe8f5e9);
    } else if (age < 25) {
      color = Color(0xFFc8e6c9);
    } else if (age < 30) {
      color = Color(0xFFa5d6a7);
    } else if (age < 35) {
      color = Color(0xFF81c784);
    } else if (age < 40) {
      color = Color(0xFF66bb6a);
    } else if (age < 45) {
      color = Color(0xFF4caf50);
    } else if (age < 50) {
      color = Color(0xFF43a047);
    } else if (age < 55) {
      color = Color(0xFf388e3c);
    } else if (age < 60) {
      color = Color(0xFF2e7d32);
    } else if (age < 65) {
      color = Color(0xFF1b5e20);
    } else {
      color = Color.fromARGB(255, 18, 77, 22);
    }

    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(
              Radius.circular(4),
            ),
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(age.toInt().toString() + "세")
      ],
    );
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the order which will be rendered in datagrid.
class OrderInfo {
  /// Creates the order class with required details.
  OrderInfo(this.id, this.customerId, this.age, this.name, this.productName,
      this.productPrice, this.order, this.totalEarnings);

  /// Id of an order.
  final int id;

  /// Customer Id of an order.
  final int customerId;

  /// Customer age of an order.
  final int age;

  /// Name of an order.
  final String name;

  /// Name of the product.
  final String productName;

  /// Number of an order.
  final int order;

  /// productPrice of an order.
  final double productPrice;

  /// Price of an order.
  final double totalEarnings;
}
