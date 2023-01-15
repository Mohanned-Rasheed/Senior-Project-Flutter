import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthreminder1/models/Meals.dart';
import 'package:healthreminder1/models/chartData.dart';

class Data extends ChangeNotifier {
  dynamic totalCalories = 0;
  var TargetCalories = 2000;
  var chartTargetCalories =
      2000; //this used to present the calories in the chart and seoritae the acculy target to mange target in diffrent form

  dynamic steps = 0;
  var TargetSteps = 5000;
  var chartTargetSteps = 5000;

  dynamic caloriesBurnt = 0;
  var TargetCaloriesBurning = 100;
  var chartTargetCaloriesBurning = 100;

  double Weight = 0;
  double Height = 0;

  late User singedInUser;

  int dayTargetMultiplyer =
      1; //this is used to change target calories in the chart dynmic when the user change the days in the list it changes to the day its selected
  DateTime ListDate = DateTime.now();

  List<dynamic> UserMealsDates = [];
  List<dynamic> UserMealsNames = [];
  List<dynamic> UserMealsCalories = [];
  List<Meals> UserMeals = [];

  List<chartData> CaloriesChart = [
    chartData('totalCalories', 0),
  ];
  List<chartData> StepsChart = [
    chartData('steps', 0),
  ];
  List<chartData> CaloriesBurntChart = [
    chartData('CaloriesBurnt', 0),
  ];

  List<Meals> meals = [];
  List<Meals> Searchmeals = [];
  void addcalo(int newcal) {
    totalCalories = totalCalories + newcal;
    notifyListeners();
  }

  void newCaloChart(int newCaloChart) {
    CaloriesChart[0].type = newCaloChart;
    notifyListeners();
  }

  void deletecalo(int newcal) {
    totalCalories = totalCalories - newcal;
    CaloriesChart[0].type = totalCalories;
    notifyListeners();
  }

  void updateSteps(dynamic newSteps) async {
    if (newSteps != steps) {
      steps = newSteps;
      StepsChart[0].type = steps;
      await Future.delayed(Duration(microseconds: 150));
      // ChartData[1].type = steps;
      notifyListeners();
    }
  }

  void addUserMealsList(Meals newMeal) {
    UserMeals.add(newMeal);
    UserMealsNames.add(newMeal.name);
    UserMealsCalories.add(newMeal.calories);
    notifyListeners();
  }

  void DeleteUserMealsList(Meals newMeal) {
    UserMeals.remove(newMeal);
    UserMealsNames.remove(newMeal.name);
    UserMealsCalories.remove(newMeal.calories);
    notifyListeners();
  }

  void updateCaloTarget(var newTarget) {
    TargetCalories = newTarget;
    chartTargetCalories = TargetCalories * dayTargetMultiplyer;
    notifyListeners();
  }

  void addDates(String date) {
    UserMealsDates.add(date);
    notifyListeners();
  }

  void deleteDate(String date) {
    UserMealsDates.remove(date);
    notifyListeners();
  }

  void updateUser() {
    final docUser =
        FirebaseFirestore.instance.collection('Users').doc(singedInUser.email);
    docUser.update({
      'calories': totalCalories,
      'mealsName': UserMealsNames,
      'mealsCalories': UserMealsCalories,
      'dateOfTheDay': UserMealsDates,
    });
  }

  void caloriesChartDate() {
    CaloriesChart[0].type = 0;
    notifyListeners();
  }

  void changeListDate(DateTime newListDate) {
    ListDate = newListDate;
    notifyListeners();
  }

  void ChartKepUpDateAtFirst() async {
    await Future.delayed(Duration(milliseconds: 1000));

    int tempTotalCalories = 0;
    for (var i = 0; i < UserMealsCalories.length; i++) {
      if (ListDate.day <= DateTime.parse(UserMealsDates[i]).day) {
        tempTotalCalories = tempTotalCalories + UserMealsCalories[i] as int;
      }
    }

    newCaloChart(tempTotalCalories);
  }

  void ChartKepUpDate() {
    int tempTotalCalories = 0;
    for (var i = 0; i < UserMealsCalories.length; i++) {
      if (ListDate.day <= DateTime.parse(UserMealsDates[i]).day) {
        tempTotalCalories = tempTotalCalories + UserMealsCalories[i] as int;
      }
    }

    newCaloChart(tempTotalCalories);
  }

  void UpdateWeightAndHeight() {
    final docUser =
        FirebaseFirestore.instance.collection('Users').doc(singedInUser.email);
    docUser.update({
      'Weight': Weight,
      'Height': Height,
    });
  }
}
