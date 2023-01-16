import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:healthreminder1/fuction/ChangeBurningCaloriesTarget.dart';
import 'package:healthreminder1/fuction/ChangeCaloriesTarget.dart';

import '../Screans/ChatBotSuggestion.dart';
import 'AddAmeal.dart';
import 'AddCalories.dart';
import 'ChangeStepsTarget.dart';

class TargetChanger extends StatelessWidget {
  const TargetChanger({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.35,
      color: Colors.teal[100],
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => SingleChildScrollView(
                      child: Container(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: ChangeCaloriesTarget())));
            },
            child: SingleChildScrollView(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      color: Colors.amber,
                      elevation: 4,
                      margin: EdgeInsets.only(
                          top: 8, left: 20, right: 20, bottom: 8),
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(top: 13.0),
                          child: Container(
                            child: Center(
                              child: Text(
                                "Change Calories Target",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                          ),
                        ),
                        subtitle: Container(
                          child: Text(''),
                        ),
                        trailing: Container(
                          child: Text(''),
                        ),
                      ),
                    )
                  ],
                )),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => SingleChildScrollView(
                      child: Container(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: ChangeStepsTarget())));
            },
            child: SingleChildScrollView(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      color: Colors.amber,
                      elevation: 4,
                      margin: EdgeInsets.only(
                          top: 8, left: 20, right: 20, bottom: 8),
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(top: 13.0),
                          child: Container(
                            child: Center(
                              child: Text(
                                "Change Steps Target",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                          ),
                        ),
                        subtitle: Container(
                          child: Text(''),
                        ),
                        trailing: Container(
                          child: Text(''),
                        ),
                      ),
                    )
                  ],
                )),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => SingleChildScrollView(
                      child: Container(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: ChangeBurningCaloriesTarget())));
            },
            child: SingleChildScrollView(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      color: Colors.amber,
                      elevation: 4,
                      margin: EdgeInsets.only(
                          top: 8, left: 20, right: 20, bottom: 8),
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(top: 13.0),
                          child: Container(
                            child: Center(
                              child: Text(
                                "Change CaloriesBurning Target",
                                style: TextStyle(fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                          ),
                        ),
                        subtitle: Container(
                          child: Text(''),
                        ),
                        trailing: Container(
                          child: Text(''),
                        ),
                      ),
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
