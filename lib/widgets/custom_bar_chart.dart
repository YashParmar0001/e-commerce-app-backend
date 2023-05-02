import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';

import '../model/models.dart';

class CustomBarChart extends StatelessWidget {
  const CustomBarChart({Key? key, required this.orderStats}) : super(key: key);

  final List<OrderStats> orderStats;

  @override
  Widget build(BuildContext context) {
    List<charts.Series<OrderStats, String>> series = [
      charts.Series(
          id: 'orders',
          data: orderStats,
          domainFn: (series, _) => DateFormat.d().format(series.dateTime).toString(),
          measureFn: (series, _) => series.orders,
          colorFn: (series, _) => series.barColor!)
    ];
    return charts.BarChart(
      series,
      animate: true,
    );
  }
}
