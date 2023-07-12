class RecordChartData {
  RecordChartData(this._name, this._Duration);
  dynamic _name;
  dynamic _Duration;

  dynamic get getName => this._name;
  set setName(dynamic value) => this._name = value;

  dynamic get getDuration => this._Duration;
  set setDuration(dynamic value) => this._Duration = value;
}
