import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:healthreminder1/userData/Data.dart';
import 'package:provider/provider.dart';

class ChangeWaterTarget extends StatefulWidget {
  const ChangeWaterTarget({Key? key}) : super(key: key);

  @override
  State<ChangeWaterTarget> createState() => _ChangeWaterTargetState();
}

class _ChangeWaterTargetState extends State<ChangeWaterTarget> {
  late var NewTarget;
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
                    .UpdateWaterTarget(NewTarget);
                //updateCaloriesTarget();
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
