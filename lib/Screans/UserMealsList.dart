import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:healthreminder1/Screans/ChatBotSuggestion.dart';
import 'package:healthreminder1/fuction/AddAmeal.dart';
import 'package:healthreminder1/fuction/AddCalories.dart';
import 'package:healthreminder1/fuction/ChangeBurningCaloriesTarget.dart';
import 'package:healthreminder1/fuction/ChangeCaloriesTarget.dart';
import 'package:healthreminder1/fuction/ChangeStepsTarget.dart';
import 'package:healthreminder1/models/Meals.dart';
import 'package:provider/provider.dart';
import '../fuction/TargetChanger.dart';
import '../userData/Data.dart';

class MealsList extends StatefulWidget {
  const MealsList({Key? key}) : super(key: key);

  @override
  State<MealsList> createState() => UserMealsList();
}

class UserMealsList extends State<MealsList> {
  List<String> itemList = ['today', 'last 3 days', 'last week'];
  String selectedItem = 'today';

  @override
  Widget build(BuildContext context) {
    void updateUser() {
      final docUser = FirebaseFirestore.instance
          .collection('Users')
          .doc(Provider.of<Data>(context, listen: false)
              .CaloriesSectionData
              .singedInUser
              .email)
          .collection("Data");
      docUser.doc('CaloriesData').update({
        'calories': Provider.of<Data>(context, listen: false)
            .CaloriesSectionData
            .totalCalories,
        'mealsName': Provider.of<Data>(context, listen: false)
            .CaloriesSectionData
            .UserMealsNames,
        'mealsCalories': Provider.of<Data>(context, listen: false)
            .CaloriesSectionData
            .UserMealsCalories,
        'dateOfTheDay': Provider.of<Data>(context, listen: false)
            .CaloriesSectionData
            .UserMealsDates,
      });
    }

    return Container(
        margin: EdgeInsets.only(top: 15),
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width * 0.94,
        decoration: new BoxDecoration(
          borderRadius: new BorderRadius.circular(16.0),
          color: Colors.white60,
        ),
        child: Column(
          children: [
            // ClipRRect(
            //   borderRadius: BorderRadius.circular(200),
            //   child: SizedBox(
            //     height: 200,
            //     width: 200,
            //     child: Stack(children: [
            //       Container(
            //         color: Colors.black,
            //       ),
            //       Align(
            //         alignment: Alignment.bottomCenter,
            //         child: Container(
            //           height: 200 * (3 / 8),
            //           color: Colors.white,
            //         ),
            //       )
            //     ]),
            //   ),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // RaisedButton(
                //   onPressed: () {
                //     Navigator.pushNamed(context, ChatSuggetion.ScreanRoute);
                //   },
                //   child: Text("ChatBot"),
                // ),
                GestureDetector(
                  child: Icon(Icons.add_circle),
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
                                              child: Container(
                                            child: AddAmeal(),
                                            height: 500,
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
                                        margin: EdgeInsets.only(
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
                                              child: Center(
                                                child: Text(
                                                  "Add Meal",
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                            ),
                                          ),
                                          subtitle: Container(
                                            child: Text(''),
                                          ),
                                          trailing: Container(
                                            child: Text(''),
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
                                          child: SingleChildScrollView(
                                              child: Container(
                                            child: Addcalories(),
                                            height: 350,
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
                                        margin: EdgeInsets.only(
                                            top: 8,
                                            left: 20,
                                            right: 20,
                                            bottom: 8),
                                        child: ListTile(
                                          title: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 13.0),
                                            child: Container(
                                              child: Center(
                                                child: Text(
                                                  "Add Calories",
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                            ),
                                          ),
                                          subtitle: Container(
                                            child: Text(''),
                                          ),
                                          trailing: Container(
                                            child: Text(''),
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
                                        margin: EdgeInsets.only(
                                            top: 8,
                                            left: 20,
                                            right: 20,
                                            bottom: 8),
                                        child: ListTile(
                                          title: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 13.0),
                                            child: Container(
                                              child: Center(
                                                child: Text(
                                                  "ScanQrCode",
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                            ),
                                          ),
                                          subtitle: Container(
                                            child: Text(''),
                                          ),
                                          trailing: Container(
                                            child: Text(''),
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
                                        margin: EdgeInsets.only(
                                            top: 8,
                                            left: 20,
                                            right: 20,
                                            bottom: 8),
                                        child: ListTile(
                                          title: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 13.0),
                                            child: Container(
                                              child: Center(
                                                child: Text(
                                                  "ChatBotSuggetion",
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                            ),
                                          ),
                                          subtitle: Container(
                                            child: Text(''),
                                          ),
                                          trailing: Container(
                                            child: Text(''),
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
                                            child: TargetChanger())));
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
                                        margin: EdgeInsets.only(
                                            top: 8,
                                            left: 20,
                                            right: 20,
                                            bottom: 8),
                                        child: ListTile(
                                          title: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 13.0),
                                            child: Container(
                                              child: Center(
                                                child: Text(
                                                  "Change Targets",
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                            ),
                                          ),
                                          subtitle: Container(
                                            child: Text(''),
                                          ),
                                          trailing: Container(
                                            child: Text(''),
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
                              .CaloriesSectionData
                              .dayTargetMultiplyer = 1;

                          Provider.of<Data>(context, listen: false)
                                  .CaloriesSectionData
                                  .chartTargetCalories =
                              Provider.of<Data>(context, listen: false)
                                  .CaloriesSectionData
                                  .TargetCalories;

                          Provider.of<Data>(context, listen: false)
                              .CaloriesSectionData
                              .dayTargetMultiplyer = 1;

                          Provider.of<Data>(context, listen: false)
                                  .CaloriesSectionData
                                  .chartTargetSteps =
                              Provider.of<Data>(context, listen: false)
                                  .CaloriesSectionData
                                  .TargetSteps;

                          Provider.of<Data>(context, listen: false)
                                  .CaloriesSectionData
                                  .chartTargetCaloriesBurning =
                              Provider.of<Data>(context, listen: false)
                                  .CaloriesSectionData
                                  .TargetCaloriesBurning;
                        } else if (selectedItem == 'last 3 days') {
                          Provider.of<Data>(context, listen: false)
                              .changeListDate(
                                  DateTime.now().subtract(Duration(days: 3)));

                          Provider.of<Data>(context, listen: false)
                              .ChartKepUpDate();

                          Provider.of<Data>(context, listen: false)
                              .CaloriesSectionData
                              .dayTargetMultiplyer = 3;

                          Provider.of<Data>(context, listen: false)
                                  .CaloriesSectionData
                                  .chartTargetCalories =
                              Provider.of<Data>(context, listen: false)
                                      .CaloriesSectionData
                                      .TargetCalories *
                                  Provider.of<Data>(context, listen: false)
                                      .CaloriesSectionData
                                      .dayTargetMultiplyer;

                          Provider.of<Data>(context, listen: false)
                                  .CaloriesSectionData
                                  .chartTargetSteps =
                              Provider.of<Data>(context, listen: false)
                                      .CaloriesSectionData
                                      .TargetSteps *
                                  Provider.of<Data>(context, listen: false)
                                      .CaloriesSectionData
                                      .dayTargetMultiplyer;

                          Provider.of<Data>(context, listen: false)
                                  .CaloriesSectionData
                                  .chartTargetCaloriesBurning =
                              Provider.of<Data>(context, listen: false)
                                      .CaloriesSectionData
                                      .TargetCaloriesBurning *
                                  Provider.of<Data>(context, listen: false)
                                      .CaloriesSectionData
                                      .dayTargetMultiplyer;
                        } else if (selectedItem == 'last week') {
                          Provider.of<Data>(context, listen: false)
                              .changeListDate(
                                  DateTime.now().subtract(Duration(days: 7)));

                          Provider.of<Data>(context, listen: false)
                              .ChartKepUpDate();

                          Provider.of<Data>(context, listen: false)
                              .CaloriesSectionData
                              .dayTargetMultiplyer = 7;

                          Provider.of<Data>(context, listen: false)
                                  .CaloriesSectionData
                                  .chartTargetCalories =
                              Provider.of<Data>(context, listen: false)
                                      .CaloriesSectionData
                                      .TargetCalories *
                                  Provider.of<Data>(context, listen: false)
                                      .CaloriesSectionData
                                      .dayTargetMultiplyer;

                          Provider.of<Data>(context, listen: false)
                                  .CaloriesSectionData
                                  .chartTargetSteps =
                              Provider.of<Data>(context, listen: false)
                                      .CaloriesSectionData
                                      .TargetSteps *
                                  Provider.of<Data>(context, listen: false)
                                      .CaloriesSectionData
                                      .dayTargetMultiplyer;

                          Provider.of<Data>(context, listen: false)
                                  .CaloriesSectionData
                                  .chartTargetCaloriesBurning =
                              Provider.of<Data>(context, listen: false)
                                      .CaloriesSectionData
                                      .TargetCaloriesBurning *
                                  Provider.of<Data>(context, listen: false)
                                      .CaloriesSectionData
                                      .dayTargetMultiplyer;
                        }
                      }),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                // Container(
                //   height: MediaQuery.of(context).size.height * 0.07,
                //   width: MediaQuery.of(context).size.width * 0.32,
                //   padding: EdgeInsets.only(left: 10),
                //   alignment: Alignment.centerLeft,
                //   child: RaisedButton(
                //       elevation: 4,
                //       shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.all(Radius.circular(12))),
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
                //   height: MediaQuery.of(context).size.height * 0.07,
                //   width: MediaQuery.of(context).size.width * 0.28,
                //   padding: EdgeInsets.only(left: 10),
                //   alignment: Alignment.centerLeft,
                //   child: RaisedButton(
                //     elevation: 4,
                //     shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.all(Radius.circular(12))),
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
                //   height: MediaQuery.of(context).size.height * 0.07,
                //   width: MediaQuery.of(context).size.width * 0.34,
                //   padding: EdgeInsets.only(left: 5),
                //   alignment: Alignment.centerLeft,
                //   child: RaisedButton(
                //     elevation: 4,
                //     shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.all(Radius.circular(12))),
                //     child: Text('Scan QRCode'),
                //     onPressed: (() {
                //       scanQR();
                //     }),
                //   ),
                // ),
              ],
            ),
            Flexible(
              child: ListView.builder(
                itemCount: Provider.of<Data>(context)
                    .CaloriesSectionData
                    .UserMeals
                    .length,
                itemBuilder: (BuildContext context, int index) {
                  return Provider.of<Data>(context)
                              .CaloriesSectionData
                              .ListDate
                              .day <=
                          DateTime.parse(Provider.of<Data>(context)
                                  .CaloriesSectionData
                                  .UserMealsDates[index])
                              .day
                      ? Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          color: Colors.teal[100],
                          elevation: 4,
                          margin: EdgeInsets.only(
                              top: 8, left: 20, right: 20, bottom: 8),
                          child: ListTile(
                            title: Container(
                              child: Text(Provider.of<Data>(context)
                                  .CaloriesSectionData
                                  .UserMeals[index]
                                  .name),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                            ),
                            subtitle: Container(
                              child: Text(
                                  ' calories: ${Provider.of<Data>(context).CaloriesSectionData.UserMeals[index].calories} \t\t\t\t\t\t\t\t\t\t\t\t\t\t At ${Provider.of<Data>(context).CaloriesSectionData.UserMealsDates[index].toString().substring(0, 10)} '),
                            ),
                            trailing: Container(
                              child: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: (() {
                                  Provider.of<Data>(context, listen: false)
                                      .deletecalo(Provider.of<Data>(context,
                                              listen: false)
                                          .CaloriesSectionData
                                          .UserMeals[index]
                                          .calories);
                                  Provider.of<Data>(context, listen: false)
                                      .DeleteUserMealsList(Provider.of<Data>(
                                              context,
                                              listen: false)
                                          .CaloriesSectionData
                                          .UserMeals[index]);
                                  Provider.of<Data>(context, listen: false)
                                      .deleteDate(Provider.of<Data>(context,
                                              listen: false)
                                          .CaloriesSectionData
                                          .UserMealsDates[index]);
                                  Provider.of<Data>(context, listen: false)
                                      .ChartKepUpDate();
                                  updateUser();
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
    List<String> Value = barcodeScanRes.split(" ");
    Meals newMeal = new Meals(Value[0], int.parse(Value[1]));
    Provider.of<Data>(context, listen: false).addUserMealsList(newMeal);
    Provider.of<Data>(context, listen: false).addcalo(int.parse(Value[1]));
    Provider.of<Data>(context, listen: false)
        .addDates(DateTime.now().toString());
    Provider.of<Data>(context, listen: false).ChartKepUpDate();
    updateUserMeals();
  }

  void updateUserMeals() {
    final docUser = FirebaseFirestore.instance
        .collection('Users')
        .doc(Provider.of<Data>(context, listen: false)
            .CaloriesSectionData
            .singedInUser
            .email)
        .collection("Data");
    docUser.doc('CaloriesData').update({
      'calories': Provider.of<Data>(context, listen: false)
          .CaloriesSectionData
          .totalCalories,
      'mealsName': Provider.of<Data>(context, listen: false)
          .CaloriesSectionData
          .UserMealsNames,
      'mealsCalories': Provider.of<Data>(context, listen: false)
          .CaloriesSectionData
          .UserMealsCalories,
    });
  }
}
