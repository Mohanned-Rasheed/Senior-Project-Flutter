import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:healthreminder1/Screans/ChatBotSuggestion.dart';
import 'package:healthreminder1/fuction/AddAmeal.dart';
import 'package:healthreminder1/fuction/AddCalories.dart';
import 'package:healthreminder1/models/Meals.dart';
import 'package:healthreminder1/models/ShowErrorMessage.dart';
import 'package:provider/provider.dart';
import '../fuction/TargetChanger.dart';
import '../fuction/notification_service.dart';
import '../userData/Data.dart';

notification Notification = notification();

class MealsList extends StatefulWidget {
  const MealsList({Key? key}) : super(key: key);

  @override
  State<MealsList> createState() => UserMealsList();
}

class UserMealsList extends State<MealsList> {
  List<String> itemList = ['today', 'last 3 days', 'last week'];
  String selectedItem = 'today';

  void CheckNotifcation() {
    Notification.initialiseNotifications();
    Notification.sendNotification(
        'YourReminig Calories is: ${Provider.of<Data>(context, listen: false).User.CaloriesSectionData.getTargetCalories - Provider.of<Data>(context, listen: false).User.CaloriesSectionData.getCaloriesChart[0].getValue}',
        'Dont Forget To Eat To reach your Target',
        0);
  }

  @override
  Widget build(BuildContext context) {
    void updateUser() {
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

    return Container(
        margin: const EdgeInsets.only(top: 15),
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width * 0.94,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: Colors.white60,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  child: const Icon(Icons.add_circle),
                  onTap: () => showModalBottomSheet(
                    backgroundColor: Colors.teal[100],
                    context: context,
                    builder: (context) {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) => Container(
                                          child: SingleChildScrollView(
                                              child: SizedBox(
                                            height: 500,
                                            child: AddAmeal(),
                                          )),
                                        ));
                              },
                              child: SingleChildScrollView(
                                  padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                  child: Column(
                                    children: [
                                      Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        color: Colors.amber,
                                        elevation: 4,
                                        margin: const EdgeInsets.only(
                                            top: 8,
                                            left: 20,
                                            right: 20,
                                            bottom: 8),
                                        child: ListTile(
                                          title: Padding(
                                            padding: const EdgeInsets.only(
                                              top: 13.0,
                                            ),
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Center(
                                                child: Text(
                                                  "Add Meal",
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                              ),
                                            ),
                                          ),
                                          subtitle: Container(
                                            child: const Text(''),
                                          ),
                                          trailing: Container(
                                            child: const Text(''),
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) => Container(
                                          padding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom),
                                          child: SingleChildScrollView(
                                              child: SizedBox(
                                            height: 350,
                                            child: Addcalories(),
                                          )),
                                        ));
                              },
                              child: SingleChildScrollView(
                                  padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                  child: Column(
                                    children: [
                                      Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        color: Colors.amber,
                                        elevation: 4,
                                        margin: const EdgeInsets.only(
                                            top: 8,
                                            left: 20,
                                            right: 20,
                                            bottom: 8),
                                        child: ListTile(
                                          title: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 13.0),
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Center(
                                                child: Text(
                                                  "Add Calories",
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                              ),
                                            ),
                                          ),
                                          subtitle: Container(
                                            child: const Text(''),
                                          ),
                                          trailing: Container(
                                            child: const Text(''),
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                scanQR();
                              },
                              child: SingleChildScrollView(
                                  padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                  child: Column(
                                    children: [
                                      Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        color: Colors.amber,
                                        elevation: 4,
                                        margin: const EdgeInsets.only(
                                            top: 8,
                                            left: 20,
                                            right: 20,
                                            bottom: 8),
                                        child: ListTile(
                                          title: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 13.0),
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Center(
                                                child: Text(
                                                  "ScanQrCode",
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                              ),
                                            ),
                                          ),
                                          subtitle: Container(
                                            child: const Text(''),
                                          ),
                                          trailing: Container(
                                            child: const Text(''),
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.pushNamed(
                                    context, ChatSuggetion.ScreanRoute);
                              },
                              child: SingleChildScrollView(
                                  padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                  child: Column(
                                    children: [
                                      Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        color: Colors.amber,
                                        elevation: 4,
                                        margin: const EdgeInsets.only(
                                            top: 8,
                                            left: 20,
                                            right: 20,
                                            bottom: 8),
                                        child: ListTile(
                                          title: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 13.0),
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Center(
                                                child: Text(
                                                  "ChatBotSuggetion",
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                              ),
                                            ),
                                          ),
                                          subtitle: Container(
                                            child: const Text(''),
                                          ),
                                          trailing: Container(
                                            child: const Text(''),
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (context) => SingleChildScrollView(
                                        child: Container(
                                            padding: EdgeInsets.only(
                                                bottom: MediaQuery.of(context)
                                                    .viewInsets
                                                    .bottom),
                                            child: const TargetChanger())));
                              },
                              child: SingleChildScrollView(
                                  padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                  child: Column(
                                    children: [
                                      Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        color: Colors.amber,
                                        elevation: 4,
                                        margin: const EdgeInsets.only(
                                            top: 8,
                                            left: 20,
                                            right: 20,
                                            bottom: 8),
                                        child: ListTile(
                                          title: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 13.0),
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Center(
                                                child: Text(
                                                  "Change Targets",
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                              ),
                                            ),
                                          ),
                                          subtitle: Container(
                                            child: const Text(''),
                                          ),
                                          trailing: Container(
                                            child: const Text(''),
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Container(
                    child: DropdownButton<String>(
                      value: selectedItem,
                      items: itemList
                          .map((item) => DropdownMenuItem<String>(
                              value: item, child: Text(item)))
                          .toList(),
                      onChanged: (item) => setState(() {
                        selectedItem = item!;
                        if (selectedItem == 'today') {
                          Provider.of<Data>(context, listen: false)
                              .changeListDate(DateTime.now());

                          Provider.of<Data>(context, listen: false)
                              .ChartKepUpDate();
                          Provider.of<Data>(context, listen: false)
                              .User
                              .CaloriesSectionData
                              .setDayTargetMultiplyer = 1;

                          Provider.of<Data>(context, listen: false)
                                  .User
                                  .CaloriesSectionData
                                  .setChartTargetCalories =
                              Provider.of<Data>(context, listen: false)
                                  .User
                                  .CaloriesSectionData
                                  .getTargetCalories;

                          Provider.of<Data>(context, listen: false)
                              .User
                              .CaloriesSectionData
                              .setDayTargetMultiplyer = 1;

                          Provider.of<Data>(context, listen: false)
                                  .User
                                  .CaloriesSectionData
                                  .setChartTargetSteps =
                              Provider.of<Data>(context, listen: false)
                                  .User
                                  .CaloriesSectionData
                                  .getTargetSteps;

                          Provider.of<Data>(context, listen: false)
                                  .User
                                  .CaloriesSectionData
                                  .setChartTargetCaloriesBurning =
                              Provider.of<Data>(context, listen: false)
                                  .User
                                  .CaloriesSectionData
                                  .getTargetCaloriesBurning;
                        } else if (selectedItem == 'last 3 days') {
                          Provider.of<Data>(context, listen: false)
                              .changeListDate(DateTime.now()
                                  .subtract(const Duration(days: 3)));

                          Provider.of<Data>(context, listen: false)
                              .ChartKepUpDate();

                          Provider.of<Data>(context, listen: false)
                              .User
                              .CaloriesSectionData
                              .setDayTargetMultiplyer = 3;

                          Provider.of<Data>(context, listen: false)
                                  .User
                                  .CaloriesSectionData
                                  .setChartTargetCalories =
                              Provider.of<Data>(context, listen: false)
                                      .User
                                      .CaloriesSectionData
                                      .getTargetCalories *
                                  Provider.of<Data>(context, listen: false)
                                      .User
                                      .CaloriesSectionData
                                      .getDayTargetMultiplyer;

                          Provider.of<Data>(context, listen: false)
                                  .User
                                  .CaloriesSectionData
                                  .setChartTargetSteps =
                              Provider.of<Data>(context, listen: false)
                                      .User
                                      .CaloriesSectionData
                                      .getTargetSteps *
                                  Provider.of<Data>(context, listen: false)
                                      .User
                                      .CaloriesSectionData
                                      .getDayTargetMultiplyer;

                          Provider.of<Data>(context, listen: false)
                                  .User
                                  .CaloriesSectionData
                                  .setChartTargetCaloriesBurning =
                              Provider.of<Data>(context, listen: false)
                                      .User
                                      .CaloriesSectionData
                                      .getTargetCaloriesBurning *
                                  Provider.of<Data>(context, listen: false)
                                      .User
                                      .CaloriesSectionData
                                      .getDayTargetMultiplyer;
                        } else if (selectedItem == 'last week') {
                          Provider.of<Data>(context, listen: false)
                              .changeListDate(DateTime.now()
                                  .subtract(const Duration(days: 7)));

                          Provider.of<Data>(context, listen: false)
                              .ChartKepUpDate();

                          Provider.of<Data>(context, listen: false)
                              .User
                              .CaloriesSectionData
                              .setDayTargetMultiplyer = 7;

                          Provider.of<Data>(context, listen: false)
                                  .User
                                  .CaloriesSectionData
                                  .setChartTargetCalories =
                              Provider.of<Data>(context, listen: false)
                                      .User
                                      .CaloriesSectionData
                                      .getTargetCalories *
                                  Provider.of<Data>(context, listen: false)
                                      .User
                                      .CaloriesSectionData
                                      .getDayTargetMultiplyer;

                          Provider.of<Data>(context, listen: false)
                                  .User
                                  .CaloriesSectionData
                                  .setChartTargetSteps =
                              Provider.of<Data>(context, listen: false)
                                      .User
                                      .CaloriesSectionData
                                      .getTargetSteps *
                                  Provider.of<Data>(context, listen: false)
                                      .User
                                      .CaloriesSectionData
                                      .getDayTargetMultiplyer;

                          Provider.of<Data>(context, listen: false)
                                  .User
                                  .CaloriesSectionData
                                  .setChartTargetCaloriesBurning =
                              Provider.of<Data>(context, listen: false)
                                      .User
                                      .CaloriesSectionData
                                      .getTargetCaloriesBurning *
                                  Provider.of<Data>(context, listen: false)
                                      .User
                                      .CaloriesSectionData
                                      .getDayTargetMultiplyer;
                        }
                      }),
                    ),
                  ),
                ),
              ],
            ),
            Flexible(
              child: ListView.builder(
                itemCount: Provider.of<Data>(context)
                    .User
                    .CaloriesSectionData
                    .getUserMeals
                    .length,
                itemBuilder: (BuildContext context, int index) {
                  return DateTime.parse(Provider.of<Data>(context)
                                  .User
                                  .CaloriesSectionData
                                  .getUserMealsDates[index])
                              .isAfter(Provider.of<Data>(context)
                                  .User
                                  .CaloriesSectionData
                                  .getListDate) ||
                          Provider.of<Data>(context)
                                  .User
                                  .CaloriesSectionData
                                  .getListDate
                                  .day ==
                              DateTime.parse(Provider.of<Data>(context)
                                      .User
                                      .CaloriesSectionData
                                      .getUserMealsDates[index])
                                  .day
                      ? Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          color: Colors.teal[100],
                          elevation: 4,
                          margin: const EdgeInsets.only(
                              top: 8, left: 20, right: 20, bottom: 8),
                          child: ListTile(
                            title: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(Provider.of<Data>(context)
                                  .User
                                  .CaloriesSectionData
                                  .getUserMeals[index]
                                  .getName),
                            ),
                            subtitle: FittedBox(
                              alignment: Alignment.centerLeft,
                              fit: BoxFit.scaleDown,
                              child: Text(
                                ' calories: ${Provider.of<Data>(context).User.CaloriesSectionData.getUserMeals[index].getCalories} \t\t\t\t\t\t\t\t\t\t\t\t\t\t At ${Provider.of<Data>(context).User.CaloriesSectionData.getUserMealsDates[index].toString().substring(0, 10)} ',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            trailing: Container(
                              child: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: (() {
                                  Provider.of<Data>(context, listen: false)
                                      .deletecalo(Provider.of<Data>(context,
                                              listen: false)
                                          .User
                                          .CaloriesSectionData
                                          .getUserMeals[index]
                                          .getCalories);
                                  Provider.of<Data>(context, listen: false)
                                      .DeleteUserMealsList(Provider.of<Data>(
                                              context,
                                              listen: false)
                                          .User
                                          .CaloriesSectionData
                                          .getUserMeals[index]);
                                  Provider.of<Data>(context, listen: false)
                                      .deleteDate(Provider.of<Data>(context,
                                              listen: false)
                                          .User
                                          .CaloriesSectionData
                                          .getUserMealsDates[index]);
                                  Provider.of<Data>(context, listen: false)
                                      .ChartKepUpDate();
                                  updateUser();
                                  CheckNotifcation();
                                }),
                              ),
                            ),
                          ),
                        )
                      : Container();
                },
              ),
            ),
          ],
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
    try {
      List<String> Value = barcodeScanRes.split(" ");
      Meals newMeal = Meals(Value[0], int.parse(Value[1]));
      Provider.of<Data>(context, listen: false).addcalo(int.parse(Value[1]));
      Provider.of<Data>(context, listen: false).addUserMealsList(newMeal);
      Provider.of<Data>(context, listen: false)
          .addDates(DateTime.now().toString());
      Provider.of<Data>(context, listen: false).ChartKepUpDate();
      updateUserMeals();
    } catch (e) {
      ShowErrorMessage(context, 'Error', 'Wrong QR Code', 75);
    }
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
}
