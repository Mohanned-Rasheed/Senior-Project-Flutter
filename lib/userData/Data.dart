import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthreminder1/ClassDiagram/WaterSection.dart';
import 'package:healthreminder1/WaterSection/models/Water.dart';
import 'package:healthreminder1/models/Meals.dart';
import 'package:healthreminder1/models/chartData.dart';

import '../ClassDiagram/CaloriesSection.dart';

class Data extends ChangeNotifier {
  WaterSection WaterSectionData = new WaterSection();
  //Water Section Methods ////////////////////////////////////////////////////////
  void AddWater(Water newWater) {
    WaterSectionData.TotalWaterPortion =
        WaterSectionData.TotalWaterPortion + newWater.amount;
    WaterSectionData.UserWaterList.add(newWater);
    WaterSectionData.WaterChart[0].type = WaterSectionData.TotalWaterPortion;
    WaterSectionData.UserWaterListDates.add(newWater.date);
    WaterSectionData.UserWaterListAmount.add(newWater.amount);
    UpdateWaterData();
    WaterChartKepUpDate();
    notifyListeners();
  }

  void DeleteWater(Water newWater) {
    WaterSectionData.TotalWaterPortion =
        WaterSectionData.TotalWaterPortion - newWater.amount;
    WaterSectionData.UserWaterList.remove(newWater);
    WaterSectionData.WaterChart[0].type = WaterSectionData.TotalWaterPortion;
    WaterSectionData.UserWaterListDates.remove(newWater.date);
    WaterSectionData.UserWaterListAmount.remove(newWater.amount);
    UpdateWaterData();
    WaterChartKepUpDate();
    notifyListeners();
  }

  void UpdateWaterTarget(dynamic NewTarget) {
    WaterSectionData.WaterTarget = NewTarget;
    WaterSectionData.chartWaterTarget = WaterSectionData.WaterTarget;
    UpdateWaterData();
    notifyListeners();
  }

  void UpdateWaterData() {
    final docUser = FirebaseFirestore.instance
        .collection('Users')
        .doc(CaloriesSectionData.singedInUser.email)
        .collection("Data");
    docUser.doc('WaterData').update({
      'TotalWaterPortion': WaterSectionData.TotalWaterPortion,
      'WaterTarget': WaterSectionData.WaterTarget,
      'DatesUserWaterList': WaterSectionData.UserWaterListDates,
      'UserWaterListAmount': WaterSectionData.UserWaterListAmount,
    });
  }

  void SelectWaterDay(DateTime newDate, int newDayMultiplier) {
    changeWaterListDate(newDate);
    WaterSectionData.WaterdayTargetMultiplyer = newDayMultiplier;
    WaterSectionData.chartWaterTarget = WaterSectionData.WaterTarget *
        WaterSectionData.WaterdayTargetMultiplyer;
    WaterChartKepUpDate();
    notifyListeners();
  }

  void WaterChartKepUpDateAtFirst() async {
    await Future.delayed(Duration(milliseconds: 400));

    int tempTotalWater = 0;
    for (var i = 0; i < WaterSectionData.UserWaterList.length; i++) {
      if (WaterSectionData.WaterListDate.day <=
          DateTime.parse(WaterSectionData.UserWaterList[i].date).day) {
        tempTotalWater =
            tempTotalWater + WaterSectionData.UserWaterList[i].amount as int;
      }
    }

    newWaterChart(tempTotalWater);
    notifyListeners();
  }

  void WaterChartKepUpDate() {
    int tempTotalWater = 0;
    for (var i = 0; i < WaterSectionData.UserWaterList.length; i++) {
      if (WaterSectionData.WaterListDate.day <=
          DateTime.parse(WaterSectionData.UserWaterList[i].date).day) {
        tempTotalWater =
            tempTotalWater + WaterSectionData.UserWaterList[i].amount as int;
      }
    }

    newWaterChart(tempTotalWater);
  }

  void newWaterChart(int newWaterChart) {
    WaterSectionData.WaterChart[0].type = newWaterChart;
    notifyListeners();
  }

  void changeWaterListDate(DateTime newListDate) {
    WaterSectionData.WaterListDate = newListDate;
    notifyListeners();
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

  void ListAtFirst() {
    changeListDate(DateTime.now());

    ChartKepUpDate();
    CaloriesSectionData.dayTargetMultiplyer = 1;

    CaloriesSectionData.chartTargetCalories =
        CaloriesSectionData.TargetCalories;

    CaloriesSectionData.dayTargetMultiplyer = 1;

    CaloriesSectionData.chartTargetSteps = CaloriesSectionData.TargetSteps;

    CaloriesSectionData.chartTargetCaloriesBurning =
        CaloriesSectionData.TargetCaloriesBurning;
  }
}
