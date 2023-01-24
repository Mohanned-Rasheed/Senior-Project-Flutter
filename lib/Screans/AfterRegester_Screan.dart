import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:healthreminder1/models/ShowErrorMessage.dart';
import 'package:healthreminder1/userData/Data.dart';
import 'package:provider/provider.dart';

import 'Calories.dart';

double Weight = 0;
double Height = 0;

class AfterRegester_Screan extends StatefulWidget {
  const AfterRegester_Screan({Key? key}) : super(key: key);
  static const String ScreanRoute = 'AfterRegester_Screan';

  @override
  State<AfterRegester_Screan> createState() => _AfterRegester_ScreanState();
}

class _AfterRegester_ScreanState extends State<AfterRegester_Screan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[800],
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.11,
                ),
                Text(
                  "Before We Countine Last Step",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.033,
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  onChanged: (value) {
                    if (value == '' || value == null) {
                      Weight = 0;
                    }
                    if (double.tryParse(value) != null) {
                      Weight = double.parse(value);
                    }
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.black,
                    hintText: 'Enter Your Weight',
                    hintStyle: TextStyle(color: Colors.white, fontSize: 18),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    )),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.orange,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  onChanged: (value) {
                    if (value == '' || value == null) {
                      Height = 0;
                    }
                    if (double.tryParse(value) != null) {
                      Height = double.parse(value);
                    }
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.black,
                    hintText: 'Enter Your Height',
                    hintStyle: TextStyle(color: Colors.white),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    )),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.orange,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Material(
                    elevation: 5,
                    color: Colors.white60,
                    borderRadius: BorderRadius.circular(10),
                    child: MaterialButton(
                      onPressed: () {
                        try {
                          if (Weight == null || Weight <= 0) {
                            ShowErrorMessage(
                                context,
                                'Wrong Weight Input',
                                'Please Enter Your Weight make sure it\'s Positve Value',
                                75);
                            return;
                          } else if (Height == null || Height <= 0) {
                            ShowErrorMessage(
                                context,
                                'Wrong Height Input',
                                'Please Enter Your Height make sure it\'s Positve Value',
                                75);
                            return;
                          }

                          Provider.of<Data>(context, listen: false)
                              .CaloriesSectionData
                              .Weight = Weight;
                          Provider.of<Data>(context, listen: false)
                              .CaloriesSectionData
                              .Height = Height;
                          Provider.of<Data>(context, listen: false)
                              .UpdateWeightAndHeight();
                          Navigator.pushNamed(context, 'AllThree');
                        } catch (e) {
                          ShowErrorMessage(
                              context,
                              'Wrong Height and Weight Input',
                              'Please Enter Your Weight and Height as Numbers',
                              75);
                        }
                      },
                      minWidth: 200,
                      height: 42,
                      child: Text(
                        "Continue",
                        style: TextStyle(fontSize: 16, color: Colors.teal[900]),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
