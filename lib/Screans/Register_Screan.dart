import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:healthreminder1/Screans/AfterRegester_Screan.dart';
import 'package:healthreminder1/Screans/Sginin_Screan.dart';
import 'package:healthreminder1/models/ShowErrorMessage.dart';
import 'package:healthreminder1/userData/Data.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';

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

  void createUser() {
    final docUser = FirebaseFirestore.instance
        .collection('Users')
        .doc(Provider.of<Data>(context, listen: false)
            .CaloriesSectionData
            .singedInUser
            .email)
        .collection('Data');
    FirebaseFirestore.instance
        .collection('Users')
        .doc(Provider.of<Data>(context, listen: false)
            .CaloriesSectionData
            .singedInUser
            .email)
        .collection('Data')
        .doc("WaterData")
        .set({
      'TotalWaterPortion': 0,
      'WaterTarget': 1500,
      'DatesUserWaterList': Provider.of<Data>(context, listen: false)
          .WaterSectionData
          .UserWaterListDates,
      'UserWaterListAmount': Provider.of<Data>(context, listen: false)
          .WaterSectionData
          .UserWaterListAmount,
    });

    FirebaseFirestore.instance
        .collection('Users')
        .doc(Provider.of<Data>(context, listen: false)
            .CaloriesSectionData
            .singedInUser
            .email)
        .collection('Data')
        .doc("SleepData")
        .set({});
    final json = {
      'email': Provider.of<Data>(context, listen: false)
          .CaloriesSectionData
          .singedInUser
          .email,
      'calories': Provider.of<Data>(context, listen: false)
          .CaloriesSectionData
          .totalCalories,
      'caloriesTarget': Provider.of<Data>(context, listen: false)
          .CaloriesSectionData
          .TargetCalories,
      'steps':
          Provider.of<Data>(context, listen: false).CaloriesSectionData.steps,
      'TargetSteps': Provider.of<Data>(context, listen: false)
          .CaloriesSectionData
          .TargetSteps,
      'caloriesBurnt': Provider.of<Data>(context, listen: false)
          .CaloriesSectionData
          .caloriesBurnt,
      'TargetCaloriesBurning': Provider.of<Data>(context, listen: false)
          .CaloriesSectionData
          .TargetCaloriesBurning,
      'mealsName': Provider.of<Data>(context, listen: false)
          .CaloriesSectionData
          .UserMealsNames,
      'mealsCalories': Provider.of<Data>(context, listen: false)
          .CaloriesSectionData
          .UserMealsCalories,
      'dateOfTheDay': Provider.of<Data>(context, listen: false)
          .CaloriesSectionData
          .UserMealsDates,
      'Weight':
          Provider.of<Data>(context, listen: false).CaloriesSectionData.Weight,
      'Height':
          Provider.of<Data>(context, listen: false).CaloriesSectionData.Height,
      //.subtract(Duration(days: 7))
    };

    docUser.doc('CaloriesData').set(json);
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        Provider.of<Data>(context, listen: false)
            .CaloriesSectionData
            .singedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[600],
        title: Text(
          'Register Page',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Column(
                  children: [
                    Container(
                        height: 180,
                        child: Image.asset('images/HealthyreminderLogo.png')),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: InputDecoration(
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
                SizedBox(
                  height: 8,
                ),
                TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: InputDecoration(
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
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Material(
                    elevation: 5,
                    color: Colors.blue[600],
                    borderRadius: BorderRadius.circular(10),
                    child: MaterialButton(
                      onPressed: () async {
                        setState(() {
                          showSpinner = true;
                        });

                        try {
                          final newUser =
                              await _auth.createUserWithEmailAndPassword(
                                  email: email, password: password);

                          getCurrentUser();
                          createUser();
                          Navigator.pushNamed(
                              context, AfterRegester_Screan.ScreanRoute);

                          setState(() {
                            showSpinner = false;
                          });
                        } catch (e) {
                          ShowErrorMessage(context, 'Error', e.toString(), 90);
                          setState(() {
                            showSpinner = false;
                          });
                        }
                      },
                      minWidth: 200,
                      height: 42,
                      child: Text(
                        "Register",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?'),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(
                              context, Sginin_Screan.ScreeanRoute);
                        },
                        child: Text("Sgin in")),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
