import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthreminder1/models/Meals.dart';
import 'package:healthreminder1/models/chartData.dart';

class Data extends ChangeNotifier {
  int totalCalories = 0;
  List<dynamic> UserMealsDates = [];
  List<dynamic> UserMealsNames = [];
  List<dynamic> UserMealsCalories = [];
  List<Meals> UserMeals = [];
  DateTime ListDate = DateTime.now();
  List<chartData> CaloriesChart = [
    chartData('totalCalories', 0),
  ];
  List<chartData> StepsChart = [
    chartData('steps', 0),
  ];
  late User singedInUser;
  dynamic steps = 0;
  var TargetCalories = 2000;

  List<Meals> meals = [
    Meals('chiken', 300),
    Meals('beef', 400),
    Meals('beef', 400),
    Meals('beef', 400),
    Meals('beef', 400),
    Meals('beef', 400),
    Meals('beef', 400),
    Meals('beef', 400)
  ];
  void addcalo(int newcal) {
    totalCalories = totalCalories + newcal;
    CaloriesChart[0].type = totalCalories;
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
}
