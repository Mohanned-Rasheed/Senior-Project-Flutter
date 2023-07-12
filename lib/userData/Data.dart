import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthreminder1/Screans/Welcome_Screan.dart';
import 'package:healthreminder1/SleepSection/model/SleepRecord.dart';
import 'package:healthreminder1/WaterSection/models/Water.dart';
import 'package:healthreminder1/models/Meals.dart';
import '../ClassDiagram/User.dart';

class Data extends ChangeNotifier {
  user User = user();

//Calorie Section Methods ////////////////////////////////////////////////////////
  void addcalo(int newcal) {
    User.CaloriesSectionData.addcalo(newcal);
    notifyListeners();
  }

  void addDates(String date) {
    User.CaloriesSectionData.getUserMealsDates.add(date);
    notifyListeners();
  }

  void addUserMealsList(Meals newMeal) {
    User.CaloriesSectionData.addUserMealsList(newMeal);
    notifyListeners();
  }

  void changeListDate(DateTime newListDate) {
    User.CaloriesSectionData.changeListDate(newListDate);
    notifyListeners();
  }

  void ChartKepUpDate() {
    User.CaloriesSectionData.ChartKepUpDate();
    notifyListeners();
  }

  void ChartKepUpDateAtFirst() {
    User.CaloriesSectionData.ChartKepUpDateAtFirst();
    notifyListeners();
  }

  void deletecalo(int newcal) {
    User.CaloriesSectionData.deletecalo(newcal);
    notifyListeners();
  }

  void deleteDate(String date) {
    User.CaloriesSectionData.deleteDate(date);
    notifyListeners();
  }

  void DeleteUserMealsList(Meals newMeal) {
    User.CaloriesSectionData.DeleteUserMealsList(newMeal);
    notifyListeners();
  }

  void ListAtFirst() {
    User.CaloriesSectionData.ListAtFirst();
    notifyListeners();
  }

  void newCaloChart(int newCaloChart) {
    User.CaloriesSectionData.newCaloChart(newCaloChart);
    notifyListeners();
  }

  void updateCaloBurningTarget(var newTarget) {
    User.CaloriesSectionData.updateCaloBurningTarget(newTarget);
    notifyListeners();
  }

  void updateCaloTarget(var newTarget) {
    User.CaloriesSectionData.updateCaloTarget(newTarget);
    notifyListeners();
  }

  void updateSteps(dynamic newSteps) async {
    if (newSteps != User.CaloriesSectionData.getSteps) {
      User.CaloriesSectionData.setSteps = newSteps;
      User.CaloriesSectionData.getStepsChart[0].setValue =
          User.CaloriesSectionData.getSteps;
      await Future.delayed(const Duration(microseconds: 150));
      // ChartData[1].type = steps;
      notifyListeners();
    }
  }

  void updateStepsTarget(var newTarget) {
    User.CaloriesSectionData.updateStepsTarget(newTarget);
    notifyListeners();
  }

  void UpdateWeightAndHeight() {
    final docUser = FirebaseFirestore.instance
        .collection('Users')
        .doc(User.getSingedInUser.currentUser!.email)
        .collection("Data");
    docUser.doc('CaloriesData').update({
      'Weight': User.getWeight,
      'Height': User.getHeight,
    });
  }

  void CalculateCaloriesBurnt(dynamic Height, dynamic Weight) async {
    await Future.delayed(Duration(milliseconds: 1));
    User.CaloriesSectionData.CalculateCaloriesBurnt(Height, Weight);
    notifyListeners();
  }

  //Sleep Section Methods ////////////////////////////////////////////////////////

  String BedTimeAnalysis() {
    return User.sleepsection.BedTimeAnalysis();
  }

  String getDateFormated(int index) {
    return User.sleepsection.getDateFormated(index);
  }

  String getDateFormatedDay() {
    return User.sleepsection.getDateFormatedDay();
  }

  String getDateFormatedhours() {
    return User.sleepsection.getDateFormatedhours();
  }

  String SleepDurationAnalysis() {
    return User.sleepsection.SleepDurationAnalysis();
  }

  void UpdateSleepData() {
    User.sleepsection.UpdateSleepData(User.getSingedInUser.currentUser!.email!);
  }

  Future AddSleepRecord(SleepRecord SleepRecord) async {
    await Future.delayed(const Duration(milliseconds: 200));
    User.sleepsection.getSleepRecords.add(SleepRecord);
    User.sleepsection.getSleepDurationList.add(SleepRecord.getSleepDuration);
    User.sleepsection.getSleepDateList.add(SleepRecord.getSleepDate);
    User.sleepsection.getTargetOfDayList.add(SleepRecord.getTargetOfDay);
    UpdateSleepData();
    notifyListeners();
  }

  //WaterSection Methods

  void AddWater(Water newWater) {
    User.WaterSectionData.AddWater(
        newWater, User.getSingedInUser.currentUser!.email!);
    notifyListeners();
  }

  void DeleteWater(Water newWater) {
    User.WaterSectionData.setTotalWaterPortion =
        User.WaterSectionData.getTotalWaterPortion - newWater.getAmount;
    User.WaterSectionData.getUserWaterList.remove(newWater);
    User.WaterSectionData.getWaterChart[0].setValue =
        User.WaterSectionData.getTotalWaterPortion;
    User.WaterSectionData.getUserWaterListDates.remove(newWater.getDate);
    User.WaterSectionData.getUserWaterListAmount.remove(newWater.getAmount);
    UpdateWaterData();
    WaterChartKepUpDate();
    notifyListeners();
  }

  void changeWaterListDate(DateTime newListDate) {
    User.WaterSectionData.changeWaterListDate(newListDate);
    notifyListeners();
  }

  void newWaterChart(int newWaterChart) {
    User.WaterSectionData.newWaterChart(newWaterChart);
    notifyListeners();
  }

  void SelectWaterDay(DateTime newDate, int newDayMultiplier) {
    User.WaterSectionData.SelectWaterDay(newDate, newDayMultiplier);
    notifyListeners();
  }

  void UpdateWaterData() {
    User.WaterSectionData.UpdateWaterData(
        User.getSingedInUser.currentUser!.email!);
  }

  void UpdateWaterTarget(dynamic NewTarget) {
    User.WaterSectionData.UpdateWaterTarget(
        NewTarget, User.getSingedInUser.currentUser!.email!);
    notifyListeners();
  }

  void WaterChartKepUpDate() {
    User.WaterSectionData.WaterChartKepUpDate();
  }

  void WaterChartKepUpDateAtFirst() async {
    await Future.delayed(const Duration(milliseconds: 10));

    int tempTotalWater = 0;
    for (var i = 0; i < User.WaterSectionData.getUserWaterList.length; i++) {
      if (User.WaterSectionData.getWaterListDate.day <=
          DateTime.parse(User.WaterSectionData.getUserWaterList[i].getDate)
              .day) {
        tempTotalWater = tempTotalWater +
            User.WaterSectionData.getUserWaterList[i].getAmount as int;
      }
    }
    newWaterChart(tempTotalWater);
    notifyListeners();
  }

  //SginOut
  void userLogout(context) {
    FirebaseAuth sginout = FirebaseAuth.instance;
    User.CaloriesSectionData.sginOut();
    User.WaterSectionData.sginOut();
    User.sleepsection.sginOut();
    User.setSingedInUser = sginout;
    Navigator.pushNamed(context, WelcomeScrean.ScreanRoute);
  }

  void notifyListener() {
    notifyListeners();
  }

//Get User Data From FireBaseAuth
  void getCurrentUser() {
    final _auth = FirebaseAuth.instance;

    if (_auth != null) {
      User.setSingedInUser = _auth;
    }
  }
}
