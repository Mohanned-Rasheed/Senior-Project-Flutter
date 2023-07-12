import 'package:flutter/material.dart';
import 'package:healthreminder1/models/chartData.dart';
import 'package:healthreminder1/userData/Data.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class WaterDigram extends StatefulWidget {
  const WaterDigram({Key? key}) : super(key: key);

  @override
  State<WaterDigram> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<WaterDigram> {
  late final List<chartData> _chartData =
      Provider.of<Data>(context).User.WaterSectionData.getWaterChart;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Color(0xff7B8FA1)),
      child: SfCircularChart(
        title: ChartTitle(
            text:
                'Water Target ${Provider.of<Data>(context, listen: false).User.WaterSectionData.getChartWaterTarget}ml'),
        legend:
            Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
        margin: const EdgeInsets.all(0),
        series: <CircularSeries>[
          RadialBarSeries<chartData, String>(
            cornerStyle: CornerStyle.bothCurve,
            trackColor: Colors.transparent,
            legendIconType: LegendIconType.circle,
            pointColorMapper: (datum, index) => const Color(0xff567189),
            dataSource: _chartData,
            xValueMapper: (chartData data, _) => data.getName,
            yValueMapper: (chartData data, _) => data.getValue,
            dataLabelSettings: const DataLabelSettings(isVisible: true),
            maximumValue: double.parse(Provider.of<Data>(context, listen: false)
                .User
                .WaterSectionData
                .getChartWaterTarget
                .toString()),
          )
        ],
      ),
    );
  }
}
