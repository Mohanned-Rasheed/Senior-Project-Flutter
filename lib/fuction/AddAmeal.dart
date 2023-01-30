import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:healthreminder1/userData/Data.dart';

class AddAmeal extends StatefulWidget {
  @override
  State<AddAmeal> createState() => _AddAmealState();
}

class _AddAmealState extends State<AddAmeal> {
  get i => null;
  String search = '';

  @override
  Widget build(BuildContext context) {
    void updateUserMeals() {
      final docUser = FirebaseFirestore.instance
          .collection('Users')
          .doc(Provider.of<Data>(context, listen: false)
              .CaloriesSectionData
              .getSingedInUser
              .currentUser!
              .email)
          .collection("Data");
      docUser.doc('CaloriesData').update({
        'calories': Provider.of<Data>(context, listen: false)
            .CaloriesSectionData
            .getTotalCalories,
        'mealsName': Provider.of<Data>(context, listen: false)
            .CaloriesSectionData
            .getUserMealsNames,
        'mealsCalories': Provider.of<Data>(context, listen: false)
            .CaloriesSectionData
            .getUserMealsCalories,
        'dateOfTheDay': Provider.of<Data>(context, listen: false)
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
                      .CaloriesSectionData
                      .Searchmeals
                      .clear();
                  for (var i = 0;
                      i <
                          Provider.of<Data>(context, listen: false)
                              .CaloriesSectionData
                              .meals
                              .length;
                      i++) {
                    if (Provider.of<Data>(context, listen: false)
                        .CaloriesSectionData
                        .meals[i]
                        .name
                        .toLowerCase()
                        .contains(search.toLowerCase())) {
                      Provider.of<Data>(context, listen: false)
                          .CaloriesSectionData
                          .Searchmeals
                          .add(Provider.of<Data>(context, listen: false)
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
                            .CaloriesSectionData
                            .Searchmeals[index]
                            .name),
                      ),
                      subtitle: Container(
                        child: Text(
                            ' calories: ${Provider.of<Data>(context).CaloriesSectionData.Searchmeals[index].calories}'),
                      ),
                      trailing: ElevatedButton(
                        // color: Colors.teal[200],
                        // shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(12)),
                        onPressed: (() {
                          Provider.of<Data>(context, listen: false).addcalo(
                              Provider.of<Data>(context, listen: false)
                                  .CaloriesSectionData
                                  .Searchmeals[index]
                                  .calories);

                          Provider.of<Data>(context, listen: false)
                              .addUserMealsList(
                                  Provider.of<Data>(context, listen: false)
                                      .CaloriesSectionData
                                      .Searchmeals[index]);
                          Provider.of<Data>(context, listen: false)
                              .addDates(DateTime.now().toString());
                          Provider.of<Data>(context, listen: false)
                              .ChartKepUpDate();
                          updateUserMeals();
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
