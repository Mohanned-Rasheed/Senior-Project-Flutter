import 'package:flutter/material.dart';
import 'package:healthreminder1/models/Meals.dart';

class Data extends ChangeNotifier {
  int totalCalories = 0;
  List<Meals> UserMeals = [];

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
    notifyListeners();
  }

  void deletecalo(int newcal) {
    totalCalories = totalCalories - newcal;
    notifyListeners();
  }

  void addUserMealsList(Meals newMeal) {
    UserMeals.add(newMeal);
    notifyListeners();
  }

  void DeleteUserMealsList(Meals newMeal) {
    UserMeals.remove(newMeal);

    notifyListeners();
  }
}
