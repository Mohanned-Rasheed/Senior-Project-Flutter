import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class SleepSection extends StatelessWidget {
  const SleepSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.teal[200],
        body: Container(
          padding: EdgeInsets.only(top: 50, bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('SleepSection',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22))
            ],
          ),
        ));
  }
}
