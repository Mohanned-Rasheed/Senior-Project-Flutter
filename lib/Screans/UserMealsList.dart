import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:healthreminder1/Screans/ChatBotSuggestion.dart';
import 'package:healthreminder1/fuction/AddAmeal.dart';
import 'package:healthreminder1/fuction/AddCalories.dart';
import 'package:healthreminder1/models/Meals.dart';
import 'package:provider/provider.dart';
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
          .doc(Provider.of<Data>(context, listen: false).singedInUser.email);
      docUser.update({
        'calories': Provider.of<Data>(context, listen: false).totalCalories,
        'mealsName': Provider.of<Data>(context, listen: false).UserMealsNames,
        'mealsCalories':
            Provider.of<Data>(context, listen: false).UserMealsCalories,
        'dateOfTheDay':
            Provider.of<Data>(context, listen: false).UserMealsDates,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RaisedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, ChatSuggetion.ScreanRoute);
                  },
                  child: Text("ChatBot"),
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
                          Provider.of<Data>(context, listen: false).ListDate =
                              DateTime.now();
                        } else if (selectedItem == 'last 3 days') {
                          Provider.of<Data>(context, listen: false).ListDate =
                              DateTime.now().subtract(Duration(days: 3));
                        } else if (selectedItem == 'last week') {
                          Provider.of<Data>(context, listen: false).ListDate =
                              DateTime.now().subtract(Duration(days: 7));
                        }
                      }),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.32,
                  padding: EdgeInsets.only(left: 10),
                  alignment: Alignment.centerLeft,
                  child: RaisedButton(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: Text('add calories'),
                      onPressed: () {
                        showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (context) => SingleChildScrollView(
                                child: Container(
                                    padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom),
                                    child: Addcalories())));
                      }),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.28,
                  padding: EdgeInsets.only(left: 10),
                  alignment: Alignment.centerLeft,
                  child: RaisedButton(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    child: Text('add meal'),
                    onPressed: (() {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) => Container(
                                child: SingleChildScrollView(
                                    child: Container(
                                  child: AddAmeal(),
                                  height: 350,
                                )),
                              ));
                    }),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.34,
                  padding: EdgeInsets.only(left: 5),
                  alignment: Alignment.centerLeft,
                  child: RaisedButton(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    child: Text('Scan QRCode'),
                    onPressed: (() {
                      scanQR();
                    }),
                  ),
                ),
              ],
            ),
            Flexible(
              child: ListView.builder(
                itemCount: Provider.of<Data>(context).UserMeals.length,
                itemBuilder: (BuildContext context, int index) {
                  return Provider.of<Data>(context).ListDate.day <=
                          DateTime.parse(Provider.of<Data>(context)
                                  .UserMealsDates[index])
                              .day
                      ? Card(
                          color: Colors.amber,
                          elevation: 4,
                          margin: EdgeInsets.only(
                              top: 8, left: 20, right: 20, bottom: 8),
                          child: ListTile(
                            title: Container(
                              child: Text(Provider.of<Data>(context)
                                  .UserMeals[index]
                                  .name),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                            ),
                            subtitle: Container(
                              child: Text(
                                  ' calories: ${Provider.of<Data>(context).UserMeals[index].calories} \t\t\t\t\t\t\t\t\t\t\t\t\t\t At ${Provider.of<Data>(context).UserMealsDates[index].toString().substring(0, 10)} '),
                            ),
                            trailing: Container(
                              child: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: (() {
                                  Provider.of<Data>(context, listen: false)
                                      .deletecalo(Provider.of<Data>(context,
                                              listen: false)
                                          .UserMeals[index]
                                          .calories);
                                  Provider.of<Data>(context, listen: false)
                                      .DeleteUserMealsList(Provider.of<Data>(
                                              context,
                                              listen: false)
                                          .UserMeals[index]);
                                  Provider.of<Data>(context, listen: false)
                                      .deleteDate(Provider.of<Data>(context,
                                              listen: false)
                                          .UserMealsDates[index]);
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
    updateUserMeals();
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
    });
  }
}
