import 'package:flutter/material.dart';
import 'package:healthreminder1/models/chartData.dart';
import 'package:healthreminder1/userData/Data.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class stepsChart extends StatefulWidget {
  const stepsChart({Key? key}) : super(key: key);

  @override
  State<stepsChart> createState() => _ChartState();
}

class _ChartState extends State<stepsChart> {
  late final List<chartData> _chartData =
      Provider.of<Data>(context).CaloriesSectionData.getStepsChart;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: Colors.white12),
      child: SfCircularChart(
        title: ChartTitle(
            text:
                'Target Steps ${Provider.of<Data>(context, listen: false).CaloriesSectionData.getChartTargetSteps}'),
        legend:
            Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
        margin: const EdgeInsets.all(0),
        series: <CircularSeries>[
          RadialBarSeries<chartData, String>(
              trackColor: Colors.transparent,
              legendIconType: LegendIconType.circle,
              pointColorMapper: (datum, index) => Colors.lightBlue,
              dataSource: _chartData,
              xValueMapper: (chartData data, _) => data.name,
              yValueMapper: (chartData data, _) => data.type,
              dataLabelSettings: const DataLabelSettings(isVisible: true),
              maximumValue: double.parse(
                  Provider.of<Data>(context, listen: false)
                      .CaloriesSectionData
                      .getChartTargetSteps
                      .toString()))
        ],
      ),
    );
  }
}
