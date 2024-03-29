import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthreminder1/models/ShowErrorMessage.dart';
import 'package:healthreminder1/userData/Data.dart';
import 'package:provider/provider.dart';

class ChangeCaloriesTarget extends StatefulWidget {
  @override
  State<ChangeCaloriesTarget> createState() => _ChangeCaloriesTarget();
}

class _ChangeCaloriesTarget extends State<ChangeCaloriesTarget> {
  late String NewTarget;

  void updateCaloriesTarget() {
    setState(() {
      final docUser = FirebaseFirestore.instance
          .collection('Users')
          .doc(Provider.of<Data>(context, listen: false)
              .User
              .getSingedInUser
              .currentUser!
              .email)
          .collection("Data");
      docUser.doc('CaloriesData').update({
        'caloriesTarget': Provider.of<Data>(context, listen: false)
            .User
            .CaloriesSectionData
            .getTargetCalories,
      });
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
            'Enter the New Target',
            style: TextStyle(
                fontSize: 25,
                color: Colors.indigo[400],
                fontWeight: FontWeight.bold),
          ),
          TextField(
            keyboardType: TextInputType.number,
            autofocus: true,
            textAlign: TextAlign.center,
            onChanged: (newTarget) {
              NewTarget = newTarget;
            },
          ),
          const SizedBox(
            height: 30,
          ),
          TextButton(
            onPressed: () {
              try {
                if (NewTarget.isEmpty) {
                  throw NullThrownError();
                }
                if (int.tryParse(NewTarget) == null) {
                  throw const FormatException();
                }
                if (int.parse(NewTarget) <= 0) {
                  throw const FormatException();
                }

                Provider.of<Data>(context, listen: false)
                    .updateCaloTarget(int.parse(NewTarget));
                updateCaloriesTarget();
              } on NullThrownError {
                ShowErrorMessage(
                    context, 'Error', 'Please Make Sure Enter a Number', 90);
              } on FormatException {
                ShowErrorMessage(
                    context,
                    'Wrong Calories Target Input',
                    'Please Enter Your Calories Target as positive Numbers',
                    90);
              } catch (e) {
                ShowErrorMessage(context, 'Error',
                    'Make Sure To Fill The Field With Positve Number', 90);
              }
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(
                backgroundColor: Colors.teal[300], primary: Colors.white),
            child: const Text('Change'),
          )
        ],
      ),
    );
  }
}
