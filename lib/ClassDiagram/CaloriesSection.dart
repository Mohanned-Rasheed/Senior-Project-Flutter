import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthreminder1/models/Meals.dart';
import 'package:healthreminder1/models/chartData.dart';

class CaloriesSection {
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
}
