import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../userData/Data.dart';
import 'package:provider/provider.dart';

class Addcalories extends StatefulWidget {
  @override
  State<Addcalories> createState() => _AddcaloriesState();
}

class _AddcaloriesState extends State<Addcalories> {
  int addedcalories = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
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
            autofocus: true,
            textAlign: TextAlign.center,
            onChanged: (newcal) {
              addedcalories = int.parse(newcal);
            },
          ),
          SizedBox(
            height: 30,
          ),
          TextButton(
            onPressed: () {
              Provider.of<Data>(context, listen: false).addcalo(addedcalories);
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
