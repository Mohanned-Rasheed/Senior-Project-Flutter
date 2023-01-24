import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthreminder1/models/ShowErrorMessage.dart';
import '../userData/Data.dart';
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
              .CaloriesSectionData
              .singedInUser
              .email)
          .collection("Data");
      docUser.doc('CaloriesData').update({
        'caloriesTarget': Provider.of<Data>(context, listen: false)
            .CaloriesSectionData
            .TargetCalories,
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
              this.NewTarget = newTarget;
            },
          ),
          SizedBox(
            height: 30,
          ),
          TextButton(
            onPressed: () {
              if (int.tryParse(NewTarget) != null) {
                Provider.of<Data>(context, listen: false)
                    .updateCaloTarget(NewTarget);
                updateCaloriesTarget();
              } else {
                ShowErrorMessage(context, 'Wrong Calories Target Input',
                    'Please Enter Your Calories Target as Numbers', 75);
              }

              Navigator.pop(context);
            },
            child: Text('Change'),
            style: TextButton.styleFrom(
                backgroundColor: Colors.teal[300], primary: Colors.white),
          )
        ],
      ),
    );
  }
}
