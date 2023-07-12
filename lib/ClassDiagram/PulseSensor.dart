import 'package:healthreminder1/SleepSection/model/SleepRecord.dart';

class PulseSensor {
  List<dynamic> _SleepDurationList = [];
  List<dynamic> _SleepDateList = [];
  List<dynamic> _TargetOfDayList = [];
  List<SleepRecord> _SleepRecords = [];
  double _TargetOfDay = 8;

  void sginOut() {
    _SleepDurationList.clear();
    _SleepDateList.clear();
    _TargetOfDayList.clear();
    _SleepRecords.clear();
    _TargetOfDay = 8;
  }

  get getSleepDateList => _SleepDateList;

  set setSleepDateList(SleepDateList) => _SleepDateList = SleepDateList;

  get getTargetOfDayList => _TargetOfDayList;

  set setTargetOfDayList(TargetOfDayList) => _TargetOfDayList = TargetOfDayList;

  List<SleepRecord> get getSleepRecords => this._SleepRecords;

  set setSleepRecords(List<SleepRecord> value) => this._SleepRecords = value;

  List<dynamic> get getSleepDurationList => _SleepDurationList;

  set setSleepDurationList(List<dynamic> SleepDurationList) =>
      _SleepDurationList = SleepDurationList;

  get getTargetOfDay => _TargetOfDay;

  set setTargetOfDay(TargetOfDay) => _TargetOfDay = TargetOfDay;
}
