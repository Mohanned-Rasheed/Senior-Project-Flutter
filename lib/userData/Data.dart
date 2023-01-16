import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthreminder1/WaterSection/models/Water.dart';
import 'package:healthreminder1/models/Meals.dart';
import 'package:healthreminder1/models/chartData.dart';

import '../ClassDiagram/CaloriesSection.dart';

class Data extends ChangeNotifier {
  dynamic TotalWaterPortion = 0;
  dynamic WaterTarget = 1500;
  List<Water> UserWaterList = [];
  DateTime ListDate = DateTime.now();
  List<Water> WaterList = [Water(330, DateTime.now().toString())];
  List<chartData> WaterChart = [
    chartData(' Total Water\n Consumpstion', 0),
  ];
  //Water Section Methods ////////////////////////////////////////////////////////
  void AddWater(Water newWater) {
    TotalWaterPortion = TotalWaterPortion + newWater.amount;
    UserWaterList.add(newWater);
    WaterChart[0].type = TotalWaterPortion;
    notifyListeners();
  }

  void DeleteWater(Water newWater) {
    TotalWaterPortion = TotalWaterPortion - newWater.amount;
    UserWaterList.remove(newWater);
    WaterChart[0].type = TotalWaterPortion;
    notifyListeners();
  }

  void UpdateWaterTarget(dynamic NewTarget) {
    WaterTarget = NewTarget;
    notifyListeners();
  }

  void UpdateWaterData() {
    final docUser = FirebaseFirestore.instance
        .collection('Users')
        .doc(CaloriesSectionData.singedInUser.email)
        .collection("Data");
    docUser.doc('WaterData').update({
      'Weight': CaloriesSectionData.Weight,
      'Height': CaloriesSectionData.Height,
    });
  }

  //Calorie Section Methods ////////////////////////////////////////////////////////
  CaloriesSection CaloriesSectionData = CaloriesSection();
  void addcalo(int newcal) {
    CaloriesSectionData.totalCalories =
        CaloriesSectionData.totalCalories + newcal;
    notifyListeners();
  }

  void newCaloChart(int newCaloChart) {
    CaloriesSectionData.CaloriesChart[0].type = newCaloChart;
    notifyListeners();
  }

  void deletecalo(int newcal) {
    CaloriesSectionData.totalCalories =
        CaloriesSectionData.totalCalories - newcal;
    CaloriesSectionData.CaloriesChart[0].type =
        CaloriesSectionData.totalCalories;
    notifyListeners();
  }

  void updateSteps(dynamic newSteps) async {
    if (newSteps != CaloriesSectionData.steps) {
      CaloriesSectionData.steps = newSteps;
      CaloriesSectionData.StepsChart[0].type = CaloriesSectionData.steps;
      await Future.delayed(Duration(microseconds: 150));
      // ChartData[1].type = steps;
      notifyListeners();
    }
  }

  void addUserMealsList(Meals newMeal) {
    CaloriesSectionData.UserMeals.add(newMeal);
    CaloriesSectionData.UserMealsNames.add(newMeal.name);
    CaloriesSectionData.UserMealsCalories.add(newMeal.calories);
    notifyListeners();
  }

  void DeleteUserMealsList(Meals newMeal) {
    CaloriesSectionData.UserMeals.remove(newMeal);
    CaloriesSectionData.UserMealsNames.remove(newMeal.name);
    CaloriesSectionData.UserMealsCalories.remove(newMeal.calories);
    notifyListeners();
  }

  void updateCaloTarget(var newTarget) {
    CaloriesSectionData.TargetCalories = newTarget;
    CaloriesSectionData.chartTargetCalories =
        CaloriesSectionData.TargetCalories *
            CaloriesSectionData.dayTargetMultiplyer;
    notifyListeners();
  }

  void updateStepsTarget(var newTarget) {
    CaloriesSectionData.TargetSteps = newTarget;
    CaloriesSectionData.chartTargetSteps = CaloriesSectionData.TargetSteps *
        CaloriesSectionData.dayTargetMultiplyer;
    notifyListeners();
  }

  void updateCaloBurningTarget(var newTarget) {
    CaloriesSectionData.TargetCaloriesBurning = newTarget;
    CaloriesSectionData.chartTargetCaloriesBurning =
        CaloriesSectionData.TargetCaloriesBurning *
            CaloriesSectionData.dayTargetMultiplyer;
    notifyListeners();
  }

  void addDates(String date) {
    CaloriesSectionData.UserMealsDates.add(date);
    notifyListeners();
  }

  void deleteDate(String date) {
    CaloriesSectionData.UserMealsDates.remove(date);
    notifyListeners();
  }

  void updateUser() {
    final docUser = FirebaseFirestore.instance
        .collection('Users')
        .doc(CaloriesSectionData.singedInUser.email)
        .collection("Data");
    docUser.doc('CaloriesData').update({
      'calories': CaloriesSectionData.totalCalories,
      'mealsName': CaloriesSectionData.UserMealsNames,
      'mealsCalories': CaloriesSectionData.UserMealsCalories,
      'dateOfTheDay': CaloriesSectionData.UserMealsDates,
    });
  }

  void changeListDate(DateTime newListDate) {
    CaloriesSectionData.ListDate = newListDate;
    notifyListeners();
  }

  void ChartKepUpDateAtFirst() async {
    await Future.delayed(Duration(milliseconds: 1000));

    int tempTotalCalories = 0;
    for (var i = 0; i < CaloriesSectionData.UserMealsCalories.length; i++) {
      if (CaloriesSectionData.ListDate.day <=
          DateTime.parse(CaloriesSectionData.UserMealsDates[i]).day) {
        tempTotalCalories =
            tempTotalCalories + CaloriesSectionData.UserMealsCalories[i] as int;
      }
    }

    newCaloChart(tempTotalCalories);
  }

  void ChartKepUpDate() {
    int tempTotalCalories = 0;
    for (var i = 0; i < CaloriesSectionData.UserMealsCalories.length; i++) {
      if (CaloriesSectionData.ListDate.day <=
          DateTime.parse(CaloriesSectionData.UserMealsDates[i]).day) {
        tempTotalCalories =
            tempTotalCalories + CaloriesSectionData.UserMealsCalories[i] as int;
      }
    }

    newCaloChart(tempTotalCalories);
  }

  void UpdateWeightAndHeight() {
    final docUser = FirebaseFirestore.instance
        .collection('Users')
        .doc(CaloriesSectionData.singedInUser.email)
        .collection("Data");
    docUser.doc('CaloriesData').update({
      'Weight': CaloriesSectionData.Weight,
      'Height': CaloriesSectionData.Height,
    });
  }
}
