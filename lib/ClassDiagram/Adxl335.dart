import 'package:healthreminder1/models/chartData.dart';

class Adxl335 {
  dynamic _steps = 0;
  var _TargetSteps = 5000;
  var _chartTargetSteps = 5000;
  dynamic _caloriesBurnt = 0;
  var _TargetCaloriesBurning = 500;
  var _chartTargetCaloriesBurning = 500;
  List<chartData> _StepsChart = [
    chartData('steps', 0),
  ];
  List<chartData> _CaloriesBurntChart = [
    chartData('CaloriesBurnt', 0),
  ];

  void SginOut() {
    _steps = 0;
    _TargetSteps = 5000;
    _chartTargetSteps = 5000;
    _caloriesBurnt = 0;
    _TargetCaloriesBurning = 500;
    _chartTargetCaloriesBurning = 500;
    List<chartData> _StepsChart = [
      chartData('steps', 0),
    ];
    List<chartData> _CaloriesBurntChart = [
      chartData('CaloriesBurnt', 0),
    ];
  }

  dynamic get getSteps => _steps;

  set setSteps(dynamic steps) => _steps = steps;

  get getTargetSteps => _TargetSteps;

  set setTargetSteps(TargetSteps) => _TargetSteps = TargetSteps;

  get getChartTargetSteps => _chartTargetSteps;

  set setChartTargetSteps(chartTargetSteps) =>
      _chartTargetSteps = chartTargetSteps;

  dynamic get getCaloriesBurnt => _caloriesBurnt;

  set setCaloriesBurnt(dynamic caloriesBurnt) => _caloriesBurnt = caloriesBurnt;

  get getTargetCaloriesBurning => _TargetCaloriesBurning;

  set setTargetCaloriesBurning(TargetCaloriesBurning) =>
      _TargetCaloriesBurning = TargetCaloriesBurning;

  get getChartTargetCaloriesBurning => _chartTargetCaloriesBurning;

  set setChartTargetCaloriesBurning(chartTargetCaloriesBurning) =>
      _chartTargetCaloriesBurning = chartTargetCaloriesBurning;

  List<chartData> get getStepsChart => _StepsChart;

  set setStepsChart(List<chartData> StepsChart) => _StepsChart = StepsChart;

  List<chartData> get getCaloriesBurntChart => _CaloriesBurntChart;

  set setCaloriesBurntChart(List<chartData> CaloriesBurntChart) =>
      _CaloriesBurntChart = CaloriesBurntChart;
}
