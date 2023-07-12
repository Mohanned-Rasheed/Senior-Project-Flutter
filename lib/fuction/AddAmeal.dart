import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:healthreminder1/userData/Data.dart';
import 'notification_service.dart';

notification Notification = notification();

class AddAmeal extends StatefulWidget {
  @override
  State<AddAmeal> createState() => _AddAmealState();
}

class _AddAmealState extends State<AddAmeal> {
  get i => null;
  String search = '';

  void CheckNotifcation() {
    Notification.initialiseNotifications();
    Notification.sendNotification(
        'YourReminig Calories is: ${Provider.of<Data>(context, listen: false).User.CaloriesSectionData.getTargetCalories - Provider.of<Data>(context, listen: false).User.CaloriesSectionData.getCaloriesChart[0].getValue}',
        'Dont Forget To Eat To reach your Target',
        0);
  }

  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.teal[100],
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Search',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  )),
                ),
                style: const TextStyle(fontSize: 18),
                onChanged: (value) {
                  search = value;
                  Provider.of<Data>(context, listen: false)
                      .User
                      .CaloriesSectionData
                      .Searchmeals
                      .clear();
                  for (var i = 0;
                      i <
                          Provider.of<Data>(context, listen: false)
                              .User
                              .CaloriesSectionData
                              .meals
                              .length;
                      i++) {
                    if (Provider.of<Data>(context, listen: false)
                        .User
                        .CaloriesSectionData
                        .meals[i]
                        .getName
                        .toLowerCase()
                        .contains(search.toLowerCase())) {
                      Provider.of<Data>(context, listen: false)
                          .User
                          .CaloriesSectionData
                          .Searchmeals
                          .add(Provider.of<Data>(context, listen: false)
                              .User
                              .CaloriesSectionData
                              .meals[i]);
                    }
                  }
                },
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.teal[100],
              child: ListView.builder(
                itemCount: Provider.of<Data>(context)
                    .User
                    .CaloriesSectionData
                    .Searchmeals
                    .length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    color: Colors.amber,
                    elevation: 4,
                    margin: const EdgeInsets.only(
                        top: 8, left: 12, right: 12, bottom: 8),
                    child: ListTile(
                      title: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(Provider.of<Data>(context)
                            .User
                            .CaloriesSectionData
                            .Searchmeals[index]
                            .getName),
                      ),
                      subtitle: Container(
                        child: Text(
                            ' calories: ${Provider.of<Data>(context).User.CaloriesSectionData.Searchmeals[index].getCalories}'),
                      ),
                      trailing: ElevatedButton(
                        // color: Colors.teal[200],
                        // shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(12)),
                        onPressed: (() {
                          Provider.of<Data>(context, listen: false).addcalo(
                              Provider.of<Data>(context, listen: false)
                                  .User
                                  .CaloriesSectionData
                                  .Searchmeals[index]
                                  .getCalories);

                          Provider.of<Data>(context, listen: false)
                              .addUserMealsList(
                                  Provider.of<Data>(context, listen: false)
                                      .User
                                      .CaloriesSectionData
                                      .Searchmeals[index]);
                          Provider.of<Data>(context, listen: false)
                              .addDates(DateTime.now().toString());
                          Provider.of<Data>(context, listen: false)
                              .ChartKepUpDate();
                          updateUserMeals();
                          CheckNotifcation();
                        }),
                        child: const Text('Add',
                            style: TextStyle(color: Colors.black54)),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
