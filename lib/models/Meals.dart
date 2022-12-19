class Meals {
  String name = '';
  int calories = 0;
  late DateTime date;
  Meals(this.name, this.calories);

  MealsWithDate(String name, int calories, DateTime date) {
    this.name = name;
    this.calories = calories;
    this.date = date;
  }
}
