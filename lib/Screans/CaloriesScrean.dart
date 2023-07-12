import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:healthreminder1/Screans/BurntCaloriesChart.dart';
import 'package:healthreminder1/Screans/UserMealsList.dart';
import 'package:healthreminder1/Screans/CaloriesChart.dart';
import 'package:healthreminder1/Screans/StepsChart.dart';
import 'package:healthreminder1/fuction/notification_service.dart';
import 'package:healthreminder1/models/Meals.dart';
import 'package:provider/provider.dart';
import '../userData/Data.dart';

class CaloriesSection extends StatefulWidget {
  static const String ScreanRoute = 'CaloriesSection';
  @override
  State<CaloriesSection> createState() {
    return _CaloriesSectionState();
  }
}

class _CaloriesSectionState extends State<CaloriesSection> {
  notification Notification = notification();
  final ref = FirebaseDatabase.instance.ref('stepsoutput');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          elevation: 5,
          width: MediaQuery.of(context).size.width * 0.64,
          backgroundColor: Color(0xff7B8FA1),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text("Hi"),
                accountEmail: Text(
                  '${Provider.of<Data>(context).User.getSingedInUser.currentUser!.email}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                ),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Sgin out'),
                onTap: () => Provider.of<Data>(context, listen: false)
                    .userLogout(context),
              )
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: const Color(0xff7B8FA1),
          title: Row(
            children: [
              const SizedBox(
                width: 15,
              ),
              Icon(Icons.fastfood_rounded),
              const SizedBox(
                width: 15,
              ),
              const Text(
                'Calories Section',
                style: TextStyle(color: Colors.white70),
              )
            ],
          ),
        ),
        backgroundColor: Colors.blueGrey,
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.87,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(top: 10, bottom: 20),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.26,
                  width: MediaQuery.of(context).size.width,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Container(
                        child: Row(
                          children: const [
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
                Flexible(
                  child: SizedBox(
                    width: 0,
                    height: 0,
                    child: FirebaseAnimatedList(
                      query: ref,
                      itemBuilder: (context, snapshot, animation, index) {
                        if (Provider.of<Data>(context, listen: false)
                                .User
                                .CaloriesSectionData
                                .getSteps !=
                            snapshot.value) {
                          Provider.of<Data>(context, listen: false)
                              .CalculateCaloriesBurnt(
                                  Provider.of<Data>(context, listen: false)
                                      .User
                                      .getHeight,
                                  Provider.of<Data>(context, listen: false)
                                      .User
                                      .getWeight);
                        }
                        Provider.of<Data>(context, listen: false)
                            .updateSteps(snapshot.value);
                        updateSteps();

                        return const Text('');
                      },
                    ),
                  ),
                ),
                const MealsList(),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: const [],
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ));
  }

  Future getDataAtFirst() async {
    CollectionReference userref = FirebaseFirestore.instance
        .collection('Users')
        .doc(Provider.of<Data>(context, listen: false)
            .User
            .getSingedInUser
            .currentUser!
            .email)
        .collection("Data");
    await userref.doc('CaloriesData').get().then((element) => {
          setState(() {
            Provider.of<Data>(context, listen: false)
                .User
                .CaloriesSectionData
                .getStepsChart[0]
                .setValue = element.get("steps");

            Provider.of<Data>(context, listen: false)
                .User
                .CaloriesSectionData
                .getCaloriesBurntChart[0]
                .setValue = element.get("caloriesBurnt");

            Provider.of<Data>(context, listen: false)
                .User
                .CaloriesSectionData
                .setTotalCalories = element.get("calories");

            Provider.of<Data>(context, listen: false)
                .User
                .CaloriesSectionData
                .setTargetCalories = element.get("caloriesTarget");

            Provider.of<Data>(context, listen: false)
                .User
                .CaloriesSectionData
                .setSteps = element.get("steps");

            Provider.of<Data>(context, listen: false)
                .User
                .CaloriesSectionData
                .setTargetSteps = element.get("TargetSteps");

            Provider.of<Data>(context, listen: false)
                .User
                .CaloriesSectionData
                .setCaloriesBurnt = element.get("caloriesBurnt");

            Provider.of<Data>(context, listen: false)
                    .User
                    .CaloriesSectionData
                    .setTargetCaloriesBurning =
                element.get("TargetCaloriesBurning");

            Provider.of<Data>(context, listen: false)
                .User
                .CaloriesSectionData
                .setUserMealsNames = element.get("mealsName");

            Provider.of<Data>(context, listen: false)
                .User
                .CaloriesSectionData
                .setUserMealsCalories = element.get("mealsCalories");

            Provider.of<Data>(context, listen: false)
                .User
                .CaloriesSectionData
                .setUserMealsDates = element.get("dateOfTheDay");
            Provider.of<Data>(context, listen: false).User.setHeight =
                element.get("Height");
            Provider.of<Data>(context, listen: false).User.setWeight =
                element.get("Weight");
            // if (true) {
            // Notification.sendNotification('this is title', 'this is body');
            //   }
            if (Provider.of<Data>(context, listen: false)
                    .User
                    .CaloriesSectionData
                    .getUserMealsNames
                    .length !=
                Provider.of<Data>(context, listen: false)
                    .User
                    .CaloriesSectionData
                    .getUserMeals
                    .length) {
              Provider.of<Data>(context, listen: false)
                  .User
                  .CaloriesSectionData
                  .getUserMeals
                  .clear();
              for (var i = 0;
                  i <
                      Provider.of<Data>(context, listen: false)
                          .User
                          .CaloriesSectionData
                          .getUserMealsNames
                          .length;
                  i++) {
                Meals meal = Meals(
                    Provider.of<Data>(context, listen: false)
                        .User
                        .CaloriesSectionData
                        .getUserMealsNames[i],
                    Provider.of<Data>(context, listen: false)
                        .User
                        .CaloriesSectionData
                        .getUserMealsCalories[i]);
                Provider.of<Data>(context, listen: false)
                    .User
                    .CaloriesSectionData
                    .getUserMeals
                    .add(meal);
              }
            }
          })
        });

    Provider.of<Data>(context, listen: false).ChartKepUpDateAtFirst();
    Provider.of<Data>(context, listen: false).ListAtFirst();
  }

  @override
  void initState() {
    Provider.of<Data>(context, listen: false).getCurrentUser();
    getDataAtFirst();
    _loadCSV();
    CheckNotifcation();
  }

  void CheckNotifcation() {
    Notification.initialiseNotifications();
    Notification.sendNotification(
        'YourReminig Calories is: ${Provider.of<Data>(context, listen: false).User.CaloriesSectionData.getTargetCalories - Provider.of<Data>(context, listen: false).User.CaloriesSectionData.getCaloriesChart[0].getValue}',
        'Dont Forget To Eat To reach your Target',
        0);
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.

    if (!mounted) return;
// _scanBarcode.substring(4)
    List<String> Value = barcodeScanRes.split(" ");
    Meals newMeal = Meals(Value[0], int.parse(Value[1]));
    Provider.of<Data>(context, listen: false).addUserMealsList(newMeal);
    Provider.of<Data>(context, listen: false).addcalo(int.parse(Value[1]));
    Provider.of<Data>(context, listen: false)
        .addDates(DateTime.now().toString());
    Provider.of<Data>(context, listen: false).ChartKepUpDate();
    updateUserMeals();
  }

  void updateSteps() {
    final docUser = FirebaseFirestore.instance
        .collection('Users')
        .doc(Provider.of<Data>(context, listen: false)
            .User
            .getSingedInUser
            .currentUser!
            .email)
        .collection("Data");
    docUser.doc('CaloriesData').update({
      'steps': Provider.of<Data>(context, listen: false)
          .User
          .CaloriesSectionData
          .getSteps,
      'caloriesBurnt': Provider.of<Data>(context, listen: false)
          .User
          .CaloriesSectionData
          .getCaloriesBurnt,
    });
  }

  void updateUserMeals() {
    final docUser = FirebaseFirestore.instance
        .collection('Users')
        .doc(Provider.of<Data>(context, listen: false)
            .User
            .getSingedInUser
            .currentUser!
            .email)
        .collection("Data");
    docUser.doc('CaloriesData').update({
      'calories': Provider.of<Data>(context, listen: false)
          .User
          .CaloriesSectionData
          .getTotalCalories,
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
    });
  }

  void _loadCSV() async {
    if (Provider.of<Data>(context, listen: false)
        .User
        .CaloriesSectionData
        .meals
        .isEmpty) {
      final rawData =
          await rootBundle.loadString("assets/Food_and_Calories_-_Sheet1.csv");
      List<List<dynamic>> listData =
          const CsvToListConverter().convert(rawData);

      for (var i = 1; i < listData.length; i++) {
        Provider.of<Data>(context, listen: false)
            .User
            .CaloriesSectionData
            .meals
            .add(Meals(listData[i][0].toString(),
                int.parse(listData[i][1].toString())));

        Provider.of<Data>(context, listen: false)
            .User
            .CaloriesSectionData
            .Searchmeals
            .add(Meals(listData[i][0].toString(),
                int.parse(listData[i][1].toString())));
      }
    }
  }
}
