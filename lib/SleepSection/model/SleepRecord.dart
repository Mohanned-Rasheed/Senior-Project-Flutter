class SleepRecord {
  SleepRecord(this._SleepDuration, this._SleepDate, this._TargetOfDay);
  dynamic _SleepDuration;
  String _SleepDate;
  double _TargetOfDay;

  dynamic get getSleepDuration => this._SleepDuration;
  set setSleepDuration(dynamic value) => this._SleepDuration = value;

  get getSleepDate => this._SleepDate;
  set setSleepDate(value) => this._SleepDate = value;

  get getTargetOfDay => this._TargetOfDay;
  set setTargetOfDay(value) => this._TargetOfDay = value;
}
