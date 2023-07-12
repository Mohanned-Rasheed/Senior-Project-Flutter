class chartData {
  chartData(this._name, this._vaue);
  String _name;
  dynamic _vaue;

  String get getName => this._name;
  set setName(String value) => this._name = value;

  dynamic get getValue => this._vaue;
  set setValue(dynamic value) => this._vaue = value;
}
