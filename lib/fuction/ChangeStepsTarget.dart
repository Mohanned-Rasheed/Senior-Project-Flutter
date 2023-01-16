import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../userData/Data.dart';
import 'package:provider/provider.dart';

class ChangeStepsTarget extends StatefulWidget {
  @override
  State<ChangeStepsTarget> createState() => _ChangeCaloriesTarget();
}

class _ChangeCaloriesTarget extends State<ChangeStepsTarget> {
  int NewTarget = 0;

  void updateStepsTarget() {
    setState(() {
      final docUser = FirebaseFirestore.instance
          .collection('Users')
          .doc(Provider.of<Data>(context, listen: false)
              .CaloriesSectionData
              .singedInUser
              .email)
          .collection("Data");
      docUser.doc('CaloriesData').update({
        'TargetSteps': Provider.of<Data>(context, listen: false)
            .CaloriesSectionData
            .TargetSteps,
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
                    .updateStepsTarget(NewTarget);
                updateStepsTarget();
              } catch (e) {
                print(e);
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
