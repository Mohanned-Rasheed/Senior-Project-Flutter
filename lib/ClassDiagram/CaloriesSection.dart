import 'package:firebase_auth/firebase_auth.dart';
import 'package:healthreminder1/ClassDiagram/Adxl335.dart';
import 'package:healthreminder1/models/Meals.dart';
import 'package:healthreminder1/models/chartData.dart';

class CaloriesSection extends Adxl335 {
  late FirebaseAuth _singedInUser;

  dynamic _totalCalories = 0;
  var _TargetCalories = 2000;
  dynamic _chartTargetCalories =
      2000; //this used to present the calories in the chart and seoritae the acculy target to mange target in diffrent form
  dynamic _Weight = 0;
  dynamic _Height = 0;
  int _dayTargetMultiplyer =
      1; //this is used to change target calories in the chart dynmic when the user change the days in the list it changes to the day its selected
  DateTime _ListDate = DateTime.now();
  List<dynamic> _UserMealsDates = [];
  List<dynamic> _UserMealsNames = [];
  List<dynamic> _UserMealsCalories = [];
  List<Meals> _UserMeals = [];
  List<chartData> _CaloriesChart = [
    chartData('totalCalories', 0),
  ];

  List<Meals> _meals = [];
  List<Meals> _Searchmeals = [];

  void sginOut() {
    super.SginOut();
    _totalCalories = 0;
    _TargetCalories = 2000;
    _chartTargetCalories = 2000;
    _Height = 0;
    _dayTargetMultiplyer = 1;
    _UserMealsDates = [];
    _UserMealsNames = [];
    _UserMealsCalories = [];
    _UserMeals = [];
    _CaloriesChart = [
      chartData('totalCalories', 0),
    ];
    List<Meals> _meals = [];
    List<Meals> _Searchmeals = [];
  }

  dynamic get getTotalCalories => _totalCalories;

  set setTotalCalories(dynamic totalCalories) => _totalCalories = totalCalories;

  get getTargetCalories => _TargetCalories;

  set setTargetCalories(TargetCalories) => _TargetCalories = TargetCalories;

  dynamic get getChartTargetCalories => _chartTargetCalories;

  set setChartTargetCalories(var chartTargetCalories) =>
      _chartTargetCalories = chartTargetCalories;

  get getWeight => _Weight;

  set setWeight(Weight) => _Weight = Weight;

  get getHeight => _Height;

  set setHeight(Height) => _Height = Height;

  FirebaseAuth get getSingedInUser => this._singedInUser;

  set setSingedInUser(FirebaseAuth value) => this._singedInUser = value;

  int get getDayTargetMultiplyer => _dayTargetMultiplyer;

  set setDayTargetMultiplyer(int dayTargetMultiplyer) =>
      _dayTargetMultiplyer = dayTargetMultiplyer;

  DateTime get getListDate => _ListDate;

  set setListDate(DateTime ListDate) => _ListDate = ListDate;

  List<dynamic> get getUserMealsDates => _UserMealsDates;

  set setUserMealsDates(List<dynamic> UserMealsDates) =>
      _UserMealsDates = UserMealsDates;

  get getUserMealsNames => _UserMealsNames;

  set setUserMealsNames(UserMealsNames) => _UserMealsNames = UserMealsNames;

  get getUserMealsCalories => _UserMealsCalories;

  set setUserMealsCalories(UserMealsCalories) =>
      _UserMealsCalories = UserMealsCalories;

  get getUserMeals => _UserMeals;

  set setUserMeals(UserMeals) => _UserMeals = UserMeals;

  List<Meals> get meals => _meals;

  set meals(List<Meals> value) => _meals = value;

  get Searchmeals => _Searchmeals;

  set Searchmeals(value) => _Searchmeals = value;

  List<chartData> get getCaloriesChart => _CaloriesChart;

  set setCaloriesChart(List<chartData> CaloriesChart) =>
      _CaloriesChart = CaloriesChart;
}
