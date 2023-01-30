import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthreminder1/ClassDiagram/SleepSection.dart';
import 'package:healthreminder1/ClassDiagram/WaterSection.dart';
import 'package:healthreminder1/Screans/Welcome_Screan.dart';
import 'package:healthreminder1/SleepSection/model/SleepRecord.dart';
import 'package:healthreminder1/WaterSection/models/Water.dart';
import 'package:healthreminder1/models/Meals.dart';

import '../ClassDiagram/CaloriesSection.dart';

class Data extends ChangeNotifier {
  CaloriesSection CaloriesSectionData = CaloriesSection();
  //Water Section Methods ////////////////////////////////////////////////////////
  WaterSection WaterSectionData = WaterSection();

  SleepSection sleepsection = SleepSection();
//Calorie Section Methods ////////////////////////////////////////////////////////
  void addcalo(int newcal) {
    CaloriesSectionData.setTotalCalories =
        CaloriesSectionData.getTotalCalories + newcal;
    notifyListeners();
  }

  void addDates(String date) {
    CaloriesSectionData.getUserMealsDates.add(date);
    notifyListeners();
  }

  void addUserMealsList(Meals newMeal) {
    CaloriesSectionData.getUserMeals.add(newMeal);
    CaloriesSectionData.getUserMealsNames.add(newMeal.name);
    CaloriesSectionData.getUserMealsCalories.add(newMeal.calories);
    notifyListeners();
  }

  void changeListDate(DateTime newListDate) {
    CaloriesSectionData.setListDate = newListDate;
    notifyListeners();
  }

  void ChartKepUpDate() {
    int tempTotalCalories = 0;
    for (var i = 0; i < CaloriesSectionData.getUserMealsCalories.length; i++) {
      if (CaloriesSectionData.getListDate.day <=
          DateTime.parse(CaloriesSectionData.getUserMealsDates[i]).day) {
        tempTotalCalories = tempTotalCalories +
            CaloriesSectionData.getUserMealsCalories[i] as int;
      }
    }

    newCaloChart(tempTotalCalories);
  }

  void AddWater(Water newWater) {
    WaterSectionData.AddWater(
        newWater, CaloriesSectionData.getSingedInUser.currentUser!.email!);
    notifyListeners();
  }

  void ChartKepUpDateAtFirst() async {
    await Future.delayed(const Duration(milliseconds: 1000));

    int tempTotalCalories = 0;
    for (var i = 0; i < CaloriesSectionData.getUserMealsCalories.length; i++) {
      if (CaloriesSectionData.getListDate.day <=
          DateTime.parse(CaloriesSectionData.getUserMealsDates[i]).day) {
        tempTotalCalories = tempTotalCalories +
            CaloriesSectionData.getUserMealsCalories[i] as int;
      }
    }

    newCaloChart(tempTotalCalories);
  }

  void deletecalo(int newcal) {
    CaloriesSectionData.setTotalCalories =
        CaloriesSectionData.getTotalCalories - newcal;
    CaloriesSectionData.getCaloriesChart[0].type =
        CaloriesSectionData.getTotalCalories;
    notifyListeners();
  }

  void deleteDate(String date) {
    CaloriesSectionData.getUserMealsDates.remove(date);
    notifyListeners();
  }

  void DeleteUserMealsList(Meals newMeal) {
    CaloriesSectionData.getUserMeals.remove(newMeal);
    CaloriesSectionData.getUserMealsNames.remove(newMeal.name);
    CaloriesSectionData.getUserMealsCalories.remove(newMeal.calories);
    notifyListeners();
  }

  void ListAtFirst() {
    changeListDate(DateTime.now());

    ChartKepUpDate();
    CaloriesSectionData.setDayTargetMultiplyer = 1;

    CaloriesSectionData.setChartTargetCalories =
        CaloriesSectionData.getTargetCalories;

    CaloriesSectionData.setDayTargetMultiplyer = 1;

    CaloriesSectionData.setChartTargetSteps =
        CaloriesSectionData.getTargetSteps;

    CaloriesSectionData.setChartTargetCaloriesBurning =
        CaloriesSectionData.getTargetCaloriesBurning;
  }

  void newCaloChart(int newCaloChart) {
    CaloriesSectionData.getCaloriesChart[0].type = newCaloChart;
    notifyListeners();
  }

  void updateCaloBurningTarget(var newTarget) {
    CaloriesSectionData.setTargetCaloriesBurning = newTarget;
    CaloriesSectionData.setChartTargetCaloriesBurning =
        CaloriesSectionData.getTargetCaloriesBurning *
            CaloriesSectionData.getDayTargetMultiplyer;
    notifyListeners();
  }

  void updateCaloTarget(var newTarget) {
    CaloriesSectionData.setTargetCalories = newTarget;
    CaloriesSectionData.setChartTargetCalories =
        CaloriesSectionData.getTargetCalories *
            CaloriesSectionData.getDayTargetMultiplyer;
    notifyListeners();
  }

  void updateSteps(dynamic newSteps) async {
    if (newSteps != CaloriesSectionData.getSteps) {
      CaloriesSectionData.setSteps = newSteps;
      CaloriesSectionData.getStepsChart[0].type = CaloriesSectionData.getSteps;
      await Future.delayed(const Duration(microseconds: 150));
      // ChartData[1].type = steps;
      notifyListeners();
    }
  }

  void updateStepsTarget(var newTarget) {
    CaloriesSectionData.setTargetSteps = newTarget;
    CaloriesSectionData.setChartTargetSteps =
        CaloriesSectionData.getTargetSteps *
            CaloriesSectionData.getDayTargetMultiplyer;
    notifyListeners();
  }

  void updateUser() {
    final docUser = FirebaseFirestore.instance
        .collection('Users')
        .doc(CaloriesSectionData.getSingedInUser.currentUser!.email)
        .collection("Data");
    docUser.doc('CaloriesData').update({
      'calories': CaloriesSectionData.getTotalCalories,
      'mealsName': CaloriesSectionData.getUserMealsNames,
      'mealsCalories': CaloriesSectionData.getUserMealsCalories,
      'dateOfTheDay': CaloriesSectionData.getUserMealsDates,
    });
  }

  void UpdateWeightAndHeight() {
    final docUser = FirebaseFirestore.instance
        .collection('Users')
        .doc(CaloriesSectionData.getSingedInUser.currentUser!.email)
        .collection("Data");
    docUser.doc('CaloriesData').update({
      'Weight': CaloriesSectionData.getWeight,
      'Height': CaloriesSectionData.getHeight,
    });
  }

  //Sleep Section Methods ////////////////////////////////////////////////////////

  String BedTimeAnalysis() {
    String text = '';
    if (DateTime.parse(sleepsection.getSleepRecordsInUse.SleepDate)
                .subtract(Duration(
                    seconds: sleepsection.getSleepRecordsInUse.SleepDuration))
                .hour >=
            18 &&
        DateTime.parse(sleepsection.getSleepRecordsInUse.SleepDate)
                .subtract(Duration(
                    seconds: sleepsection.getSleepRecordsInUse.SleepDuration))
                .hour <=
            20) {
      text =
          '•You went to bed between 6pm and 8pm\n it affects the bodys internal clock\n or what is known as circadian rhythm.';
    }
    if (DateTime.parse(sleepsection.getSleepRecordsInUse.SleepDate)
                .subtract(Duration(
                    seconds: sleepsection.getSleepRecordsInUse.SleepDuration))
                .hour >=
            20 &&
        DateTime.parse(sleepsection.getSleepRecordsInUse.SleepDate)
                .subtract(Duration(
                    seconds: sleepsection.getSleepRecordsInUse.SleepDuration))
                .hour <=
            23) {
      text =
          '•You went to bed between 8pm and 11pm\n and that is the Sweet Spot for Bedtime.';
    }
    if (DateTime.parse(sleepsection.getSleepRecordsInUse.SleepDate)
                .subtract(Duration(
                    seconds: sleepsection.getSleepRecordsInUse.SleepDuration))
                .hour >=
            23 &&
        DateTime.parse(sleepsection.getSleepRecordsInUse.SleepDate)
                .subtract(Duration(
                    seconds: sleepsection.getSleepRecordsInUse.SleepDuration))
                .hour <=
            01) {
      text =
          '•You went to bed between 11pm and 1am\n try getting to bed early so you can sleep before midnight because it affect your overall wellness when awake .';
    }
    if (DateTime.parse(sleepsection.getSleepRecordsInUse.SleepDate)
                .subtract(Duration(
                    seconds: sleepsection.getSleepRecordsInUse.SleepDuration))
                .hour >=
            01 &&
        DateTime.parse(sleepsection.getSleepRecordsInUse.SleepDate)
                .subtract(Duration(
                    seconds: sleepsection.getSleepRecordsInUse.SleepDuration))
                .hour <=
            05) {
      text =
          '•You went to bed between 1am and 5am its\n really unhealthy to sleep really late at night because\n you deprive yourself of some of the rejuvenating\n functions that occur during non-REM sleep.';
    }
    if (DateTime.parse(sleepsection.getSleepRecordsInUse.SleepDate)
                .subtract(Duration(
                    seconds: sleepsection.getSleepRecordsInUse.SleepDuration))
                .hour >=
            05 &&
        DateTime.parse(sleepsection.getSleepRecordsInUse.SleepDate)
                .subtract(Duration(
                    seconds: sleepsection.getSleepRecordsInUse.SleepDuration))
                .hour <=
            17) {
      text =
          '•You went to bed between 5am and 5pm,\n it affects the bodys internal clock\n or what is known as circadian rhythm.';
    }

    return text;
  }

  String getDateFormated(int index) {
    return DateTime.parse(sleepsection.getSleepRecords[index].SleepDate)
        .subtract(Duration(
            seconds: sleepsection.getSleepRecords[index].SleepDuration))
        .toString()
        .substring(0, 16);
  }

  String getDateFormatedDay() {
    return DateTime.parse(sleepsection.getSleepRecordsInUse.SleepDate)
        .subtract(
            Duration(seconds: sleepsection.getSleepRecordsInUse.SleepDuration))
        .toString()
        .substring(0, 10);
  }

  String getDateFormatedhours() {
    return DateTime.parse(sleepsection.getSleepRecordsInUse.SleepDate)
        .subtract(
            Duration(seconds: sleepsection.getSleepRecordsInUse.SleepDuration))
        .toString()
        .substring(11, 16);
  }

  String SleepDurationAnalysis() {
    String text = '';
    if (sleepsection.getSleepRecordsInUse.SleepDuration / 60 / 60 >= 7 &&
        sleepsection.getSleepRecordsInUse.SleepDuration / 60 / 60 <= 10) {
      text =
          '• Your Sleep Duration Was Great its between 7 and 10\n Hours and That The Optimal Sleep Duration';
    }
    if (sleepsection.getSleepRecordsInUse.SleepDuration / 60 / 60 >= 5 &&
        sleepsection.getSleepRecordsInUse.SleepDuration / 60 / 60 <= 7) {
      text =
          '• Your Sleep Duration Was 4 to 6 hours, it is close\n to optimal but you can make up for it during nap time. ';
    }
    if (sleepsection.getSleepRecordsInUse.SleepDuration / 60 / 60 >= 3 &&
        sleepsection.getSleepRecordsInUse.SleepDuration / 60 / 60 <= 5) {
      text =
          '• Your Sleep Duration Was 3 to 5 hours, Sleeping\n 5 hours or fewer every night could put you\n at risk of multiple chronic diseases.';
    }
    if (sleepsection.getSleepRecordsInUse.SleepDuration / 60 / 60 >= 11 &&
        sleepsection.getSleepRecordsInUse.SleepDuration / 60 / 60 <= 20) {
      text =
          '• Your Sleep Duration was more than 10 hours,\n Too much sleep on a regular basis can increase \nthe risk of diabetes, heart disease, stroke, and death.';
    }

    return text;
  }

  void UpdateSleepData() {
    final docUser = FirebaseFirestore.instance
        .collection('Users')
        .doc(CaloriesSectionData.getSingedInUser.currentUser!.email)
        .collection("Data");
    docUser.doc('SleepData').update({
      'SleepDurationList': sleepsection.getSleepDurationList,
      'SleepDateList': sleepsection.getSleepDateList,
      'TargetOfDayList': sleepsection.getTargetOfDayList,
      'TargetOfDay': sleepsection.getTargetOfDay,
    });
  }

  Future AddSleepRecord(SleepRecord SleepRecord) async {
    await Future.delayed(const Duration(milliseconds: 200));
    sleepsection.getSleepRecords.add(SleepRecord);
    sleepsection.getSleepDurationList.add(SleepRecord.SleepDuration);
    sleepsection.getSleepDateList.add(SleepRecord.SleepDate);
    sleepsection.getTargetOfDayList.add(SleepRecord.TargetOfDay);
    UpdateSleepData();
    notifyListeners();
  }

  void changeWaterListDate(DateTime newListDate) {
    WaterSectionData.setWaterListDate = newListDate;
    notifyListeners();
  }

  void DeleteWater(Water newWater) {
    WaterSectionData.setTotalWaterPortion =
        WaterSectionData.getTotalWaterPortion - newWater.amount;
    WaterSectionData.getUserWaterList.remove(newWater);
    WaterSectionData.getWaterChart[0].type =
        WaterSectionData.getTotalWaterPortion;
    WaterSectionData.getUserWaterListDates.remove(newWater.date);
    WaterSectionData.getUserWaterListAmount.remove(newWater.amount);
    UpdateWaterData();
    WaterChartKepUpDate();
    notifyListeners();
  }

  void newWaterChart(int newWaterChart) {
    WaterSectionData.getWaterChart[0].type = newWaterChart;
    notifyListeners();
  }

  void SelectWaterDay(DateTime newDate, int newDayMultiplier) {
    changeWaterListDate(newDate);
    WaterSectionData.setWaterdayTargetMultiplyer = newDayMultiplier;
    WaterSectionData.setChartWaterTarget = WaterSectionData.getWaterTarget *
        WaterSectionData.getWaterdayTargetMultiplyer;
    WaterChartKepUpDate();
    notifyListeners();
  }

  void UpdateWaterData() {
    final docUser = FirebaseFirestore.instance
        .collection('Users')
        .doc(CaloriesSectionData.getSingedInUser.currentUser!.email)
        .collection("Data");
    docUser.doc('WaterData').update({
      'TotalWaterPortion': WaterSectionData.getTotalWaterPortion,
      'WaterTarget': WaterSectionData.getWaterTarget,
      'DatesUserWaterList': WaterSectionData.getUserWaterListDates,
      'UserWaterListAmount': WaterSectionData.getUserWaterListAmount,
    });
  }

  void UpdateWaterTarget(dynamic NewTarget) {
    WaterSectionData.setWaterTarget = NewTarget;
    WaterSectionData.setChartWaterTarget = WaterSectionData.getWaterTarget;
    UpdateWaterData();
    notifyListeners();
  }

  void WaterChartKepUpDate() {
    int tempTotalWater = 0;
    for (var i = 0; i < WaterSectionData.getUserWaterList.length; i++) {
      if (WaterSectionData.getWaterListDate.day <=
          DateTime.parse(WaterSectionData.getUserWaterList[i].date).day) {
        tempTotalWater =
            tempTotalWater + WaterSectionData.getUserWaterList[i].amount as int;
      }
    }

    newWaterChart(tempTotalWater);
  }

  void WaterChartKepUpDateAtFirst() async {
    await Future.delayed(const Duration(milliseconds: 10));

    int tempTotalWater = 0;
    for (var i = 0; i < WaterSectionData.getUserWaterList.length; i++) {
      if (WaterSectionData.getWaterListDate.day <=
          DateTime.parse(WaterSectionData.getUserWaterList[i].date).day) {
        tempTotalWater =
            tempTotalWater + WaterSectionData.getUserWaterList[i].amount as int;
      }
    }

    newWaterChart(tempTotalWater);
    notifyListeners();
  }

  //SginOut
  void userLogout(context) {
    FirebaseAuth sginout = FirebaseAuth.instance;

    CaloriesSectionData.sginOut();
    WaterSectionData.sginOut();
    sleepsection.sginOut();
    CaloriesSectionData.setSingedInUser = sginout;
    Navigator.pushNamed(context, WelcomeScrean.ScreanRoute);
  }

//Get User Data From FireBase Auth
  void getCurrentUser() {
    final _auth = FirebaseAuth.instance;

    if (_auth != null) {
      CaloriesSectionData.setSingedInUser = _auth;
    }
  }
}
