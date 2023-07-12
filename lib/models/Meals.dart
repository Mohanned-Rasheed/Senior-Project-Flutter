class Meals {
  Meals(this._name, this._calories);

  String _name = '';
  int _calories = 0;
  late DateTime _date;

  MealsWithDate(String name, int calories, DateTime date) {
    this._name = name;
    this._calories = calories;
    this._date = date;
  }

  String get getName => this._name;
  set setName(String name) => this._name = name;

  int get getCalories => this._calories;
  set setCalories(int calories) => this._calories = calories;

  get getDate => this._date;
  set setDate(date) => this._date = date;
}
