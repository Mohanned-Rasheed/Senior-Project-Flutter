import 'package:flutter/material.dart';
import 'package:healthreminder1/Screans/AfterRegester_Screan.dart';
import 'package:healthreminder1/models/chartData.dart';
import 'package:healthreminder1/userData/Data.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CaloriesChart extends StatefulWidget {
  const CaloriesChart({Key? key}) : super(key: key);

  @override
  State<CaloriesChart> createState() => _ChartState();
}

class _ChartState extends State<CaloriesChart> {
  late final List<chartData> _chartData =
      Provider.of<Data>(context).CaloriesSectionData.getCaloriesChart;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.white12),
      child: SfCircularChart(
        title: ChartTitle(
            text:
                'Target Calories ${Provider.of<Data>(context, listen: false).CaloriesSectionData.getChartTargetCalories}'),
        legend:
            Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
        margin: const EdgeInsets.all(0),
        series: <CircularSeries>[
          RadialBarSeries<chartData, String>(
            cornerStyle: CornerStyle.bothCurve,
            trackColor: Colors.transparent,
            legendIconType: LegendIconType.circle,
            pointColorMapper: (datum, index) => Colors.lightGreenAccent,
            dataSource: _chartData,
            xValueMapper: (chartData data, _) => data.name,
            yValueMapper: (chartData data, _) => data.type,
            dataLabelSettings: const DataLabelSettings(isVisible: true),
            maximumValue: double.parse(Provider.of<Data>(context, listen: false)
                .CaloriesSectionData
                .getChartTargetCalories
                .toString()),
          )
        ],
      ),
    );
  }
}
