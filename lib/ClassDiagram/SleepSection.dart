import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthreminder1/ClassDiagram/PulseSensor.dart';
import 'package:healthreminder1/SleepSection/model/RecordChartData.dart';
import 'package:healthreminder1/SleepSection/model/SleepRecord.dart';

class SleepSection extends PulseSensor {
  late SleepRecord _SleepRecordsInUse;
  dynamic _LastTimeHasBeenChanged = 0;
  List<RecordChartData> _ChartData = [
    RecordChartData('Your Record', 0.0),
    RecordChartData('Your Target', 8.0),
  ];
  void sginOut() {
    super.sginOut();
    _LastTimeHasBeenChanged = 0;
    List<RecordChartData> _ChartData = [
      RecordChartData('Your Record', 0.0),
      RecordChartData('Your Target', 8.0),
    ];
  }

  get getSleepRecordsInUse => _SleepRecordsInUse;

  set setSleepRecordsInUse(SleepRecordsInUse) =>
      _SleepRecordsInUse = SleepRecordsInUse;

  get getLastTimeHasBeenChanged => _LastTimeHasBeenChanged;

  set setLastTimeHasBeenChanged(LastTimeHasBeenChanged) =>
      _LastTimeHasBeenChanged = LastTimeHasBeenChanged;

  List<RecordChartData> get getChartData => _ChartData;

  set setChartData(List<RecordChartData> ChartData) => _ChartData = ChartData;
}
