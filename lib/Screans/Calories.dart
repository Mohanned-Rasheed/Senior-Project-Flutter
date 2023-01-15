import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthreminder1/Screans/ChatBotSuggestion.dart';
import 'package:healthreminder1/Screans/caloriesChart.dart';
import 'package:healthreminder1/Screans/Welcome_Screan.dart';
import 'package:healthreminder1/Screans/stepsChart.dart';
import 'package:healthreminder1/fuction/AddAmeal.dart';
import 'package:healthreminder1/fuction/AddCalories.dart';
import 'package:healthreminder1/Screans/UserMealsList.dart';
import 'package:healthreminder1/fuction/changeCaloriesTarget.dart';
import 'package:healthreminder1/fuction/notification_service.dart';
import 'package:healthreminder1/models/Meals.dart';
import 'package:provider/provider.dart';
import '../userData/Data.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:fling_pickle/fling_pickle.dart';
import 'package:http/http.dart' as http;

import 'BurntCaloriesChart.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:excel/excel.dart' as exele;

String _scanBarcode = 'Unknown';
var IsCreated = true;

class CaloriesSection extends StatefulWidget {
  static const String ScreanRoute = 'CaloriesSection';
  @override
  State<CaloriesSection> createState() {
    return _CaloriesSectionState();
  }
}

class _CaloriesSectionState extends State<CaloriesSection> {
  String name = '';
  String final_respnes = '';
  final _formkey = GlobalKey<FormState>();

  Future<void> _savingData() async {
    final vladiation = _formkey.currentState?.validate();

    if (!vladiation!) {
      return;
    }

    _formkey.currentState?.save();
  }

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  notification Notification = notification();
  final ref = FirebaseDatabase.instance.ref('stepsoutput');

  // void getCC() {
  //   for (var i = 0; i < MealsCSV().getCsv().length; i++) {
  //     Provider.of<Data>(context).UserMeals[i] = Meals(MealsCSV().getCsv().);
  //   }
  //   Provider.of<Data>(context).UserMeals =
  //       MealsCSV().getCsv().length as List<Meals>;
  // }

  @override
  void initState() {
    super.initState();
    Notification.initialiseNotifications();
    getCurrentUser();
    getDataAtFirst();
    _loadCSV();
    //DateTime.parse();
  }

  void _loadCSV() async {
    final _rawData =
        await rootBundle.loadString("assets/Food_and_Calories_-_Sheet1.csv");
    List<List<dynamic>> _listData = CsvToListConverter().convert(_rawData);

    for (var i = 1; i < _listData.length; i++) {
      Provider.of<Data>(context, listen: false).meals.add(Meals(
          _listData[i][0].toString(), int.parse(_listData[i][1].toString())));

      Provider.of<Data>(context, listen: false).Searchmeals.add(Meals(
          _listData[i][0].toString(), int.parse(_listData[i][1].toString())));
    }
  }

  void updateSteps() {
    final docUser = FirebaseFirestore.instance
        .collection('Users')
        .doc(Provider.of<Data>(context, listen: false).singedInUser.email);
    docUser.update({
      'steps': Provider.of<Data>(context, listen: false).steps,
    });
  }

  void getDataAtFirst() async {
    CollectionReference userref =
        FirebaseFirestore.instance.collection('Users');
    await userref.get().then((value) {
      value.docs.forEach((element) {
        if (element.get("email") ==
            Provider.of<Data>(context, listen: false).singedInUser.email) {
          setState(() {
            Provider.of<Data>(context, listen: false).CaloriesChart[0].type =
                element.get("calories");

            Provider.of<Data>(context, listen: false).StepsChart[0].type =
                element.get("steps");

            Provider.of<Data>(context, listen: false)
                .CaloriesBurntChart[0]
                .type = element.get("caloriesBurnt");

            Provider.of<Data>(context, listen: false).totalCalories =
                element.get("calories");

            Provider.of<Data>(context, listen: false).TargetCalories =
                element.get("caloriesTarget");

            Provider.of<Data>(context, listen: false).steps =
                element.get("steps");

            Provider.of<Data>(context, listen: false).TargetSteps =
                element.get("TargetSteps");

            Provider.of<Data>(context, listen: false).caloriesBurnt =
                element.get("caloriesBurnt");

            Provider.of<Data>(context, listen: false).TargetCaloriesBurning =
                element.get("TargetCaloriesBurning");

            Provider.of<Data>(context, listen: false).UserMealsNames =
                element.get("mealsName");

            Provider.of<Data>(context, listen: false).UserMealsCalories =
                element.get("mealsCalories");

            Provider.of<Data>(context, listen: false).UserMealsDates =
                element.get("dateOfTheDay");

            // if (true) {
            // Notification.sendNotification('this is title', 'this is body');
            //   }
          });
          if (Provider.of<Data>(context, listen: false).UserMealsNames.length !=
              Provider.of<Data>(context, listen: false).UserMeals.length) {
            Provider.of<Data>(context, listen: false).UserMeals.clear();
            for (var i = 0;
                i <
                    Provider.of<Data>(context, listen: false)
                        .UserMealsNames
                        .length;
                i++) {
              Meals meal = Meals(
                  Provider.of<Data>(context, listen: false).UserMealsNames[i],
                  Provider.of<Data>(context, listen: false)
                      .UserMealsCalories[i]);
              Provider.of<Data>(context, listen: false).UserMeals.add(meal);
            }
          }
        }
      });
    });
    Provider.of<Data>(context, listen: false).ChartKepUpDateAtFirst();
  }

  void updateUserMeals() {
    final docUser = FirebaseFirestore.instance
        .collection('Users')
        .doc(Provider.of<Data>(context, listen: false).singedInUser.email);
    docUser.update({
      'calories': Provider.of<Data>(context, listen: false).totalCalories,
      'mealsName': Provider.of<Data>(context, listen: false).UserMealsNames,
      'mealsCalories':
          Provider.of<Data>(context, listen: false).UserMealsCalories,
      'dateOfTheDay': Provider.of<Data>(context, listen: false).UserMealsDates,
    });
  }

  /*void checkUser() async {
    CollectionReference userref =
        FirebaseFirestore.instance.collection('Users');
    userref.get().then((value) {
      value.docs.forEach((element) {
        if (element.get("email") ==
            Provider.of<Data>(context, listen: false).singedInUser.email) {
          getDataAtFirst();
        }
      });
    });
  }*/

  // void date() {
  //   final docUser =
  //       FirebaseFirestore.instance.collection('Users').doc('newOne');

  //   final json = {
  //     'email': Provider.of<Data>(context, listen: false).singedInUser.email,
  //     'calories': Provider.of<Data>(context, listen: false).totalCalories,
  //     'steps': Provider.of<Data>(context, listen: false).steps,
  //     'mealsName': Provider.of<Data>(context, listen: false).UserMealsNames,
  //     'mealsCalories':
  //         Provider.of<Data>(context, listen: false).UserMealsCalories,
  //     'dateOfTheDay': DateTime.now().subtract(Duration(days: 7)),
  //   };

  //   docUser.set(json);
  // }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        Provider.of<Data>(context, listen: false).singedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  void userLogout() {
    Provider.of<Data>(context, listen: false).UserMealsNames = [];
    Provider.of<Data>(context, listen: false).UserMealsCalories = [];
    Provider.of<Data>(context, listen: false).UserMeals = [];
    Provider.of<Data>(context, listen: false).UserMealsDates = [];
    Provider.of<Data>(context, listen: false).totalCalories = 0;
    Provider.of<Data>(context, listen: false).steps = 0;
    Provider.of<Data>(context, listen: false).TargetCalories = 2000;
    Provider.of<Data>(context, listen: false).TargetSteps = 5000;
    Provider.of<Data>(context, listen: false).TargetCaloriesBurning = 100;

    _auth.signOut();
    Navigator.pushNamed(context, WelcomeScrean.ScreanRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan[100],
          leading: IconButton(
              onPressed: () {
                // date();
              },
              icon: Icon(Icons.arrow_back)),
          title: Row(
            children: [
              Image.asset(
                'images/HealthyreminderLogo.png',
                height: 45,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                'Healthy Reminder',
                style: TextStyle(color: Colors.black54),
              )
            ],
          ),
          actions: [
            IconButton(
                onPressed: () {
                  userLogout();
                },
                icon: Icon(
                  Icons.close,
                  color: Colors.black,
                ))
          ],
        ),
        backgroundColor: Colors.teal[200],
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 1.3,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(top: 25, bottom: 20),
            child: Column(
              children: <Widget>[
                // RaisedButton(
                //   onPressed: () async {
                //     _savingData();

                //     Uri url = Uri.base;

                //     final response =
                //         await http.post(url, body: json.encode({'name': name}));
                //   },
                //   key: _formkey,
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('CaloriesSection',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22)),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.26,
                  width: MediaQuery.of(context).size.width,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            SizedBox(
                              width: 50,
                            ),
                            CaloriesChart(),
                            SizedBox(
                              width: 45,
                            ),
                            stepsChart(),
                            SizedBox(
                              width: 50,
                            ),
                            BurntCaloriesChart(),
                            SizedBox(
                              width: 50,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                /* StreamBuilder<QuerySnapshot>(
                  stream: _firestore.collection('Users').snapshots(),
                  builder: (context, snapshot) {
                    var flag = true;
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.blue,
                        ),
                      );
                    }

                    if (snapshot.hasData) {
                      final users = snapshot.data!.docs;

                      for (var user in users) {
                        final usersteps = user.get('steps');
                        final email = user.get('email');
                        final calories = user.get('calories');
                        if (email ==
                            Provider.of<Data>(context, listen: false)
                                .singedInUser
                                .email) {
                          // Notification.sendNotification(
                          //   'this is title', 'this is body');
                        }
                      }
                    }

                    return Container(
                      width: 0,
                      height: 0,
                    );
                  },
                ),*/

                /*Container(
                  height: 300,
                  width: 400,
                  child: SfCartesianChart(
                    series: <RadialBarSeries>[
                      PieSeries<GDPData, String>(
                          dataSource: _chartData,
                          xValueMapper: (GDPData data, _) => data.c,
                          yValueMapper: (GDPData data, _) => data.a)
                    ],
                  ),
                ),*/
                Flexible(
                  child: Container(
                    width: 0,
                    height: 0,
                    child: FirebaseAnimatedList(
                      query: ref,
                      itemBuilder: (context, snapshot, animation, index) {
                        Provider.of<Data>(context, listen: false)
                            .updateSteps(snapshot.value);
                        updateSteps();

                        if (Provider.of<Data>(context, listen: false).Height >
                            180) {
                          Provider.of<Data>(context, listen: false)
                                  .CaloriesBurntChart[0]
                                  .type =
                              ((Provider.of<Data>(context, listen: false)
                                              .Weight /
                                          1666) *
                                      Provider.of<Data>(context, listen: false)
                                          .steps)
                                  .floor();
                        } else if (Provider.of<Data>(context, listen: false)
                                    .Height >
                                167 &&
                            Provider.of<Data>(context, listen: false).Height <
                                188) {
                          Provider.of<Data>(context, listen: false)
                                  .CaloriesBurntChart[0]
                                  .type =
                              (((Provider.of<Data>(context, listen: false)
                                                  .Weight /
                                              1666) *
                                          0.914) *
                                      Provider.of<Data>(context, listen: false)
                                          .steps)
                                  .floor();
                        } else {
                          Provider.of<Data>(context, listen: false)
                                  .CaloriesBurntChart[0]
                                  .type =
                              (((Provider.of<Data>(context, listen: false)
                                                  .Weight /
                                              1666) *
                                          0.837) *
                                      Provider.of<Data>(context, listen: false)
                                          .steps)
                                  .floor();
                        }

                        return Text('');
                      },
                    ),
                  ),
                ),
                /*Container(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'Total Calories: ${Provider.of<Data>(context).totalCalories} \n Total steps: ${Provider.of<Data>(context, listen: false).steps} \n Calories Target: ${Provider.of<Data>(context, listen: false).TargetCalories}',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  height: 100,
                  width: MediaQuery.of(context).size.width * 0.65,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                ),*/
                MealsList(),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    // Container(
                    //   padding: EdgeInsets.only(left: 15),
                    //   alignment: Alignment.centerLeft,
                    //   child: RaisedButton(
                    //       elevation: 4,
                    //       shape: RoundedRectangleBorder(
                    //           borderRadius:
                    //               BorderRadius.all(Radius.circular(12))),
                    //       child: Text('add calories'),
                    //       onPressed: () {
                    //         showModalBottomSheet(
                    //             isScrollControlled: true,
                    //             context: context,
                    //             builder: (context) => SingleChildScrollView(
                    //                 child: Container(
                    //                     padding: EdgeInsets.only(
                    //                         bottom: MediaQuery.of(context)
                    //                             .viewInsets
                    //                             .bottom),
                    //                     child: Addcalories())));
                    //       }),
                    // ),
                    // Container(
                    //   padding: EdgeInsets.only(left: 15),
                    //   alignment: Alignment.centerLeft,
                    //   child: RaisedButton(
                    //     elevation: 4,
                    //     shape: RoundedRectangleBorder(
                    //         borderRadius:
                    //             BorderRadius.all(Radius.circular(12))),
                    //     child: Text('add meal'),
                    //     onPressed: (() {
                    //       showModalBottomSheet(
                    //           context: context,
                    //           builder: (context) => Container(
                    //                 child: SingleChildScrollView(
                    //                     child: Container(
                    //                   child: AddAmeal(),
                    //                   height: 350,
                    //                 )),
                    //               ));
                    //     }),
                    //   ),
                    // ),
                    // Container(
                    //   padding: EdgeInsets.only(left: 15),
                    //   alignment: Alignment.centerLeft,
                    //   child: RaisedButton(
                    //     elevation: 4,
                    //     shape: RoundedRectangleBorder(
                    //         borderRadius:
                    //             BorderRadius.all(Radius.circular(12))),
                    //     child: Text('Scan QRCode'),
                    //     onPressed: (() {
                    //       scanQR();
                    //     }),
                    //   ),
                    // ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                // Container(
                //   padding: EdgeInsets.only(left: 15),
                //   alignment: Alignment.centerLeft,
                //   child: RaisedButton(
                //       elevation: 4,
                //       shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.all(Radius.circular(12))),
                //       child: Text('Change Calories Target'),
                //       onPressed: () {
                //         showModalBottomSheet(
                //             isScrollControlled: true,
                //             context: context,
                //             builder: (context) => SingleChildScrollView(
                //                 child: Container(
                //                     padding: EdgeInsets.only(
                //                         bottom: MediaQuery.of(context)
                //                             .viewInsets
                //                             .bottom),
                //                     child: ChangeCaloriesTarget())));
                //       }),
                // ),
              ],
            ),
          ),
        ));
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      //print(_scanBarcode.substring(5) + "aaaaaaaaaaaaaaaaaaaa");
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.

    if (!mounted) return;
// _scanBarcode.substring(4)
    List<String> Value = barcodeScanRes.split(" ");
    Meals newMeal = new Meals(Value[0], int.parse(Value[1]));
    Provider.of<Data>(context, listen: false).addUserMealsList(newMeal);
    Provider.of<Data>(context, listen: false).addcalo(int.parse(Value[1]));
    Provider.of<Data>(context, listen: false)
        .addDates(DateTime.now().toString());
    Provider.of<Data>(context, listen: false).ChartKepUpDate();
    updateUserMeals();
  }
}
