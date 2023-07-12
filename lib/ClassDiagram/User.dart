import 'package:firebase_auth/firebase_auth.dart';

import 'CaloriesSection.dart';
import 'SleepSection.dart';
import 'WaterSection.dart';

class user {
  late FirebaseAuth _singedInUser;
  CaloriesSection _CaloriesSectionData = CaloriesSection();
  WaterSection _WaterSectionData = WaterSection();
  SleepSection _sleepsection = SleepSection();
  dynamic _Weight = 0;
  dynamic _Height = 0;

  FirebaseAuth get getSingedInUser => this._singedInUser;
  set setSingedInUser(FirebaseAuth user) => this._singedInUser = user;

  CaloriesSection get CaloriesSectionData => this._CaloriesSectionData;
  set CaloriesSectionData(CaloriesSection value) =>
      this._CaloriesSectionData = value;

  WaterSection get WaterSectionData => this._WaterSectionData;
  set WaterSectionData(WaterSection watersection) =>
      this._WaterSectionData = watersection;

  SleepSection get sleepsection => this._sleepsection;
  set sleepsection(SleepSection value) => this._sleepsection = value;

  get getWeight => _Weight;
  set setWeight(Weight) => _Weight = Weight;

  get getHeight => _Height;
  set setHeight(Height) => _Height = Height;
}
