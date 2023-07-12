import 'package:healthreminder1/ClassDiagram/Adxl335.dart';
import 'package:healthreminder1/models/Meals.dart';
import 'package:healthreminder1/models/chartData.dart';

class CaloriesSection extends Adxl335 {
  dynamic _totalCalories = 0;
  var _TargetCalories = 2000;
  dynamic _chartTargetCalories =
      2000; //this used to present the calories in the chart and seoritae the acculy target to mange target in diffrent form
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

  void addcalo(int newcal) {
    setTotalCalories = getTotalCalories + newcal;
  }

  void addDates(String date) {
    getUserMealsDates.add(date);
  }

  void addUserMealsList(Meals newMeal) {
    getUserMeals.add(newMeal);
    getUserMealsNames.add(newMeal.getName);
    getUserMealsCalories.add(newMeal.getCalories);
  }

  void changeListDate(DateTime newListDate) {
    setListDate = newListDate;
  }

  void ChartKepUpDate() {
    int tempTotalCalories = 0;
    for (var i = 0; i < getUserMealsCalories.length; i++) {
      if (DateTime.parse(getUserMealsDates[i]).isAfter(getListDate) ||
          getListDate.day == DateTime.parse(getUserMealsDates[i]).day) {
        tempTotalCalories = tempTotalCalories + getUserMealsCalories[i] as int;
      }
    }

    newCaloChart(tempTotalCalories);
  }

  void ChartKepUpDateAtFirst() async {
    await Future.delayed(const Duration(milliseconds: 1000));

    int tempTotalCalories = 0;
    for (var i = 0; i < getUserMealsCalories.length; i++) {
      if (getListDate.day <= DateTime.parse(getUserMealsDates[i]).day) {
        tempTotalCalories = tempTotalCalories + getUserMealsCalories[i] as int;
      }
    }

    newCaloChart(tempTotalCalories);
  }

  void deletecalo(int newcal) {
    setTotalCalories = getTotalCalories - newcal;
  }

  void deleteDate(String date) {
    getUserMealsDates.remove(date);
  }

  void DeleteUserMealsList(Meals newMeal) {
    getUserMeals.remove(newMeal);
    getUserMealsNames.remove(newMeal.getName);
    getUserMealsCalories.remove(newMeal.getCalories);
  }

  void ListAtFirst() {
    changeListDate(DateTime.now());

    ChartKepUpDate();
    setDayTargetMultiplyer = 1;

    setChartTargetCalories = getTargetCalories;

    setDayTargetMultiplyer = 1;

    setChartTargetSteps = getTargetSteps;

    setChartTargetCaloriesBurning = getTargetCaloriesBurning;
  }

  void newCaloChart(int newCaloChart) {
    getCaloriesChart[0].setValue = newCaloChart;
  }

  void updateCaloBurningTarget(var newTarget) {
    setTargetCaloriesBurning = newTarget;
    setChartTargetCaloriesBurning =
        getTargetCaloriesBurning * getDayTargetMultiplyer;
  }

  void updateCaloTarget(var newTarget) {
    setTargetCalories = newTarget;
    setChartTargetCalories = getTargetCalories * getDayTargetMultiplyer;
  }

  void updateSteps(dynamic newSteps) async {
    if (newSteps != getSteps) {
      setSteps = newSteps;
      getStepsChart[0].setValue = getSteps;
      await Future.delayed(const Duration(microseconds: 150));
    }
  }

  void updateStepsTarget(var newTarget) {
    setTargetSteps = newTarget;
    setChartTargetSteps = getTargetSteps * getDayTargetMultiplyer;
  }

  void CalculateCaloriesBurnt(dynamic Height, dynamic Weight) {
    if (Height > 180) {
      setCaloriesBurnt = ((Weight / 1666) * getSteps).floor();
      getCaloriesBurntChart[0].setValue = ((Weight / 1666) * getSteps).floor();
    } else if (Height > 167 && Height < 188) {
      setCaloriesBurnt = (((Weight / 1666) * 0.914) * getSteps).floor();
      getCaloriesBurntChart[0].setValue =
          (((Weight / 1666) * 0.914) * getSteps).floor();
    } else {
      setCaloriesBurnt = (((Weight / 1666) * 0.837) * getSteps).floor();
      getCaloriesBurntChart[0].setValue =
          (((Weight / 1666) * 0.837) * getSteps).floor();
    }
  }

  // String AddCalories(String NewTarget) {
  //   try {
  //     if (NewTarget.isEmpty) {
  //       throw NullThrownError();
  //     }
  //     if (int.tryParse(NewTarget) == null) {
  //       throw const FormatException();
  //     }
  //     if (int.parse(NewTarget) <= 0) {
  //       throw const FormatException();
  //     }

  //     // Provider.of<Data>(context, listen: false)
  //     //     .updateCaloTarget(int.parse(NewTarget));
  //     // updateCaloriesTarget();
  //   } on NullThrownError {
  //     // ShowErrorMessage(context, 'Error', 'Please Make Sure Enter a Number', 90);
  //     return 'Please Make Sure Enter a Number';
  //   } on FormatException {
  //     // ShowErrorMessage(context, 'Wrong Calories Target Input',
  //     //     'Please Enter Your Calories Target as positive Numbers', 90);
  //     return "Please Enter Your Calories Target as positive Numbers";
  //   } catch (e) {
  //     // ShowErrorMessage(context, 'Error',
  //     //     'Make Sure To Fill The Field With Positve Number', 90);
  //     return 'Make Sure To Fill The Field With Positve Number';
  //   }
  //   return "Complete";
  // }

  // int CalculatesCaloriesBurnt(dynamic Height, dynamic Weight) {
  //   if (Height > 180) {
  //     setCaloriesBurnt = ((Weight / 1666) * getSteps).floor();
  //     getCaloriesBurntChart[0].setValue = ((Weight / 1666) * getSteps).floor();
  //     return ((Weight / 1666) * getSteps).floor();
  //   } else if (Height > 167 && Height < 188) {
  //     setCaloriesBurnt = (((Weight / 1666) * 0.914) * getSteps).floor();
  //     getCaloriesBurntChart[0].setValue =
  //         (((Weight / 1666) * 0.914) * getSteps).floor();
  //     return (((Weight / 1666) * 0.914) * getSteps).floor();
  //   } else {
  //     setCaloriesBurnt = (((Weight / 1666) * 0.837) * getSteps).floor();
  //     getCaloriesBurntChart[0].setValue =
  //         (((Weight / 1666) * 0.837) * getSteps).floor();
  //     return (((Weight / 1666) * 0.837) * getSteps).floor();
  //   }
  // }

  // void UpdateWeightAndHeight() {
  //   final docUser = FirebaseFirestore.instance
  //       .collection('Users')
  //       .doc(User.getSingedInUser.currentUser!.email)
  //       .collection("Data");
  //   docUser.doc('CaloriesData').update({
  //     'Weight': getWeight,
  //     'Height': getHeight,
  //   });
  // }
}
