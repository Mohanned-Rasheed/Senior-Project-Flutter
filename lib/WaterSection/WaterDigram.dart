import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../Screans/AfterRegester_Screan.dart';
import '../models/chartData.dart';
import '../userData/Data.dart';

class WaterDigram extends StatefulWidget {
  const WaterDigram({Key? key}) : super(key: key);

  @override
  State<WaterDigram> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<WaterDigram> {
  late List<chartData> _chartData = Provider.of<Data>(context).WaterChart;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Color(0xff7B8FA1)),
      child: SfCircularChart(
        title: ChartTitle(
            text:
                'Water Target ${Provider.of<Data>(context, listen: false).WaterTarget}ml'),
        legend:
            Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
        margin: EdgeInsets.all(0),
        series: <CircularSeries>[
          RadialBarSeries<chartData, String>(
            cornerStyle: CornerStyle.bothCurve,
            trackColor: Colors.transparent,
            legendIconType: LegendIconType.circle,
            pointColorMapper: (datum, index) => Color(0xff567189),
            dataSource: _chartData,
            xValueMapper: (chartData data, _) => data.name,
            yValueMapper: (chartData data, _) => data.type,
            dataLabelSettings: DataLabelSettings(isVisible: true),
            maximumValue: double.parse(Provider.of<Data>(context, listen: false)
                .WaterTarget
                .toString()),
          )
        ],
      ),
    );
  }
}
