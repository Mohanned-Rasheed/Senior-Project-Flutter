import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:healthreminder1/models/Meals.dart';
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
  late List<chartData> _chartData = Provider.of<Data>(context).StepsChart;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.teal[100]),
      child: SfCircularChart(
        title: ChartTitle(
            text: 'Target Steps ${Provider.of<Data>(context).TargetCalories}'),
        legend:
            Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
        margin: EdgeInsets.all(0),
        series: <CircularSeries>[
          RadialBarSeries<chartData, String>(
              trackColor: Colors.transparent,
              legendIconType: LegendIconType.circle,
              pointColorMapper: (datum, index) => Colors.lightBlue,
              dataSource: _chartData,
              xValueMapper: (chartData data, _) => data.name,
              yValueMapper: (chartData data, _) => data.type,
              dataLabelSettings: DataLabelSettings(isVisible: true),
              maximumValue: 1000)
        ],
      ),
    );
  }
}
