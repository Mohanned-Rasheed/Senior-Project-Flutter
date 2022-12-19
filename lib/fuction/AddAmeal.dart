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

  @override
  Widget build(BuildContext context) {
    void updateUserMeals() {
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

    return Scaffold(
      body: ListView.builder(
        itemCount: Provider.of<Data>(context).meals.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: Colors.amber,
            elevation: 4,
            margin: EdgeInsets.only(top: 8, left: 12, right: 12, bottom: 8),
            child: ListTile(
              title: Container(
                child: Text(Provider.of<Data>(context).meals[index].name),
                padding: EdgeInsets.symmetric(horizontal: 10),
              ),
              subtitle: Container(
                child: Text(
                    ' calories: ${Provider.of<Data>(context).meals[index].calories}'),
              ),
              trailing: Container(
                child: RaisedButton(
                  onPressed: (() {
                    Provider.of<Data>(context, listen: false).addcalo(
                        Provider.of<Data>(context, listen: false)
                            .meals[index]
                            .calories);

                    Provider.of<Data>(context, listen: false).addUserMealsList(
                        Provider.of<Data>(context, listen: false).meals[index]);
                    Provider.of<Data>(context, listen: false)
                        .addDates(DateTime.now().toString());
                    updateUserMeals();
                  }),
                  child: Text('Add'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
