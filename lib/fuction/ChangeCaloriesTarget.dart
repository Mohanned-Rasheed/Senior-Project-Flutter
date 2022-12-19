import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthreminder1/models/Meals.dart';
import '../userData/Data.dart';
import 'package:provider/provider.dart';

class ChangeCaloriesTarget extends StatefulWidget {
  @override
  State<ChangeCaloriesTarget> createState() => _ChangeCaloriesTarget();
}

class _ChangeCaloriesTarget extends State<ChangeCaloriesTarget> {
  int NewTarget = 0;

  void updateCaloriesTarget() {
    setState(() {
      final docUser = FirebaseFirestore.instance
          .collection('Users')
          .doc(Provider.of<Data>(context, listen: false).singedInUser.email);
      docUser.update({
        'caloriesTarget':
            Provider.of<Data>(context, listen: false).TargetCalories,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
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
              NewTarget = int.parse(newTarget);
            },
          ),
          SizedBox(
            height: 30,
          ),
          TextButton(
            onPressed: () {
              try {
                Provider.of<Data>(context, listen: false)
                    .updateCaloTarget(NewTarget);
                updateCaloriesTarget();
              } catch (e) {
                print(e);
              }

              Navigator.pop(context);
            },
            child: Text('Add'),
            style: TextButton.styleFrom(
                backgroundColor: Colors.teal[300], primary: Colors.white),
          )
        ],
      ),
    );
  }
}
