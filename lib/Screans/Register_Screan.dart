import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthreminder1/Screans/AfterRegester_Screan.dart';
import 'package:healthreminder1/Screans/Sginin_Screan.dart';
import 'package:healthreminder1/models/ShowErrorMessage.dart';
import 'package:healthreminder1/userData/Data.dart';
import 'package:provider/provider.dart';

class Register_Screan extends StatefulWidget {
  static const String ScreanRoute = 'Register_Screan';

  @override
  State<Register_Screan> createState() => _Register_ScreanState();
}

class _Register_ScreanState extends State<Register_Screan> {
  static const String ScreanRoute = 'Register_Screan';
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  late String userName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.amber[600],
        title: const Text(
          'Register Page',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(
                  height: 50,
                ),
                Column(
                  children: [
                    SizedBox(
                        height: 180,
                        child: Image.asset('images/HealthyreminderLogo.png')),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: const InputDecoration(
                    fillColor: Colors.black,
                    hintText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    )),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.orange,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.teal,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: const InputDecoration(
                    fillColor: Colors.black,
                    hintText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    )),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.orange,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.teal,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Material(
                    elevation: 5,
                    color: Colors.blue[600],
                    borderRadius: BorderRadius.circular(10),
                    child: MaterialButton(
                      onPressed: () async {
                        try {
                          if (email.isEmpty || password.isEmpty) {
                            throw NullThrownError;
                          }
                          final newUser =
                              await _auth.createUserWithEmailAndPassword(
                                  email: email, password: password);
                          getCurrentUser();
                          createUser();
                          Navigator.pushNamed(
                              context, AfterRegester_Screan.ScreanRoute);
                        } on FirebaseAuthException catch (Exception) {
                          ShowErrorMessage(
                              context, 'Error', Exception.toString(), 100);
                        } on NullThrownError catch (Exception) {
                          ShowErrorMessage(
                              context, 'Error', Exception.toString(), 100);
                        } catch (Exception) {
                          ShowErrorMessage(
                              context, 'Error', Exception.toString(), 100);
                        }
                      },
                      minWidth: 200,
                      height: 42,
                      child: const Text(
                        "Register",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account?'),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(
                              context, Sginin_Screan.ScreeanRoute);
                        },
                        child: const Text("Sgin in")),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool createUser() {
    final docUser = FirebaseFirestore.instance
        .collection('Users')
        .doc(Provider.of<Data>(context, listen: false)
            .User
            .getSingedInUser
            .currentUser!
            .email)
        .collection('Data');
    FirebaseFirestore.instance
        .collection('Users')
        .doc(Provider.of<Data>(context, listen: false)
            .User
            .getSingedInUser
            .currentUser!
            .email)
        .collection('Data')
        .doc("WaterData")
        .set({
      'TotalWaterPortion': 0,
      'WaterTarget': 1500,
      'DatesUserWaterList': Provider.of<Data>(context, listen: false)
          .User
          .WaterSectionData
          .getUserWaterListDates,
      'UserWaterListAmount': Provider.of<Data>(context, listen: false)
          .User
          .WaterSectionData
          .getUserWaterListAmount,
    });

    FirebaseFirestore.instance
        .collection('Users')
        .doc(Provider.of<Data>(context, listen: false)
            .User
            .getSingedInUser
            .currentUser!
            .email)
        .collection('Data')
        .doc("SleepData")
        .set({
      'SleepDurationList': Provider.of<Data>(context, listen: false)
          .User
          .sleepsection
          .getSleepDurationList,
      'SleepDateList': Provider.of<Data>(context, listen: false)
          .User
          .sleepsection
          .getSleepDateList,
      'TargetOfDayList': Provider.of<Data>(context, listen: false)
          .User
          .sleepsection
          .getTargetOfDayList,
      'TargetOfDay': Provider.of<Data>(context, listen: false)
          .User
          .sleepsection
          .getTargetOfDay,
      'LastTimeHasBeenChanged': Provider.of<Data>(context, listen: false)
          .User
          .sleepsection
          .getLastTimeHasBeenChanged,
    });
    final json = {
      'email': Provider.of<Data>(context, listen: false)
          .User
          .getSingedInUser
          .currentUser!
          .email,
      'calories': Provider.of<Data>(context, listen: false)
          .User
          .CaloriesSectionData
          .getTotalCalories,
      'caloriesTarget': Provider.of<Data>(context, listen: false)
          .User
          .CaloriesSectionData
          .getTargetCalories,
      'steps': Provider.of<Data>(context, listen: false)
          .User
          .CaloriesSectionData
          .getSteps,
      'TargetSteps': Provider.of<Data>(context, listen: false)
          .User
          .CaloriesSectionData
          .getTargetSteps,
      'caloriesBurnt': Provider.of<Data>(context, listen: false)
          .User
          .CaloriesSectionData
          .getCaloriesBurnt,
      'TargetCaloriesBurning': Provider.of<Data>(context, listen: false)
          .User
          .CaloriesSectionData
          .getTargetCaloriesBurning,
      'mealsName': Provider.of<Data>(context, listen: false)
          .User
          .CaloriesSectionData
          .getUserMealsNames,
      'mealsCalories': Provider.of<Data>(context, listen: false)
          .User
          .CaloriesSectionData
          .getUserMealsCalories,
      'dateOfTheDay': Provider.of<Data>(context, listen: false)
          .User
          .CaloriesSectionData
          .getUserMealsDates,
      'Weight': Provider.of<Data>(context, listen: false).User.getWeight,
      'Height': Provider.of<Data>(context, listen: false).User.getHeight,
    };

    docUser.doc('CaloriesData').set(json);
    return true;
  }

  void getCurrentUser() {
    try {
      if (_auth != null) {
        Provider.of<Data>(context, listen: false).User.setSingedInUser = _auth;
      }
    } catch (e) {
      print(e);
    }
  }
}
