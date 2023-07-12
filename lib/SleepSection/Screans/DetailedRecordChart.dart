import 'package:flutter/material.dart';
import 'package:healthreminder1/SleepSection/model/RecordChartData.dart';
import 'package:healthreminder1/userData/Data.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DetailedRecord extends StatefulWidget {
  static const String ScreanRoute = 'DetailedRecord';
  const DetailedRecord({Key? key}) : super(key: key);

  @override
  State<DetailedRecord> createState() => _DetailedRecord();
}

class _DetailedRecord extends State<DetailedRecord> {
  @override
  Widget build(BuildContext context) {
    List<RecordChartData> _RecordChartData =
        Provider.of<Data>(context).User.sleepsection.getChartData;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text('Sleep Record'),
      ),
      backgroundColor: Colors.grey[300],
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Container(
              child: SfCartesianChart(
                title: ChartTitle(
                    text:
                        'Sleep Record ${Provider.of<Data>(context).getDateFormatedDay()}'),
                series: <ChartSeries>[
                  BarSeries<RecordChartData, String>(
                    color: Colors.blueGrey,
                    dataSource: _RecordChartData,
                    xValueMapper: (RecordChartData marks, _) => marks.getName,
                    yValueMapper: (RecordChartData marks, _) =>
                        marks.getDuration,
                  )
                ],
                primaryXAxis: CategoryAxis(
                    title: AxisTitle(
                      text: 'Indecator With Target Sleep',
                      textStyle: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    borderWidth: 1,
                    labelStyle: TextStyle(fontSize: 15)),
                primaryYAxis: CategoryAxis(
                    title: AxisTitle(
                        text: 'Number Of Hours',
                        textStyle: TextStyle(fontWeight: FontWeight.bold)),
                    labelStyle: TextStyle(fontSize: 12),
                    tickPosition: TickPosition.inside,
                    minimum: 0),
                // primaryXAxis: CategoryAxis(minimum: 0)
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.blueGrey,
              ),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Description',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.025 +
                              (0.5 *
                                  MediaQuery.of(context).size.height *
                                  0.025)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Bed Time: ${Provider.of<Data>(context).getDateFormatedhours()} ',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.013 +
                                      (0.5 *
                                          MediaQuery.of(context).size.height *
                                          0.013)),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          ' Duration Of The Sleep: ${Duration(seconds: Provider.of<Data>(context).User.sleepsection.getSleepRecordsInUse.getSleepDuration).toString().substring(0, 4)} Hours ',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.013 +
                                      (0.5 *
                                          MediaQuery.of(context).size.height *
                                          0.013)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          Provider.of<Data>(context).BedTimeAnalysis(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.02 +
                                      (0.5 *
                                          MediaQuery.of(context).size.height *
                                          0.015)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          Provider.of<Data>(context).SleepDurationAnalysis(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.02 +
                                      (0.5 *
                                          MediaQuery.of(context).size.height *
                                          0.015)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'This Description Based On Tow Factor\n• Amount of the Sleep\n• Time Went To Bed',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.01 +
                                      (0.5 *
                                          MediaQuery.of(context).size.height *
                                          0.01)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
