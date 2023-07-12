import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthreminder1/models/Meals.dart';
import 'package:healthreminder1/userData/Data.dart';
import 'package:provider/provider.dart';

class Addcalories extends StatefulWidget {
  @override
  State<Addcalories> createState() => _AddcaloriesState();
}

class _AddcaloriesState extends State<Addcalories> {
  int addedcalories = 0;

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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            textAlign: TextAlign.center,
            'Enter Amount Of Calories',
            style: TextStyle(
                fontSize: 25,
                color: Colors.indigo[400],
                fontWeight: FontWeight.bold),
          ),
          TextField(
            keyboardType: TextInputType.number,
            autofocus: true,
            textAlign: TextAlign.center,
            onChanged: (newcal) {
              addedcalories = int.parse(newcal);
            },
          ),
          const SizedBox(
            height: 30,
          ),
          TextButton(
            onPressed: () {
              try {
                Meals newMeal = Meals('Added Calories', addedcalories);
                newMeal.MealsWithDate(
                    'Added Calories', addedcalories, DateTime.now());
                Provider.of<Data>(context, listen: false)
                    .addUserMealsList(newMeal);
                Provider.of<Data>(context, listen: false)
                    .addcalo(addedcalories);
                Provider.of<Data>(context, listen: false)
                    .addDates(DateTime.now().toString());
                Provider.of<Data>(context, listen: false).ChartKepUpDate();
                updateUserMeals();
              } catch (e) {
                print(e);
              }

              Navigator.pop(context);
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.teal[300],
            ),
            // primary: Colors.white
            child: const Text('Add'),
          )
        ],
      ),
    );
  }
}
