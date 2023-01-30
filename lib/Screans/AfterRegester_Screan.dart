import 'package:flutter/material.dart';
import 'package:healthreminder1/models/ShowErrorMessage.dart';
import 'package:healthreminder1/userData/Data.dart';
import 'package:provider/provider.dart';

late String Height;
late String Weight;

class AfterRegester_Screan extends StatefulWidget {
  static const String ScreanRoute = 'AfterRegester_Screan';
  const AfterRegester_Screan({Key? key}) : super(key: key);

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
                weight_input(),
                const SizedBox(
                  height: 40,
                ),
                height_input(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Material(
                    elevation: 5,
                    color: Colors.white60,
                    borderRadius: BorderRadius.circular(10),
                    child: MaterialButton(
                      onPressed: () {
                        try {
                          if (Height.isEmpty || Weight.isEmpty) {
                            throw NullThrownError();
                          }
                          if (double.tryParse(Height) == null ||
                              double.tryParse(Weight) == null) {
                            throw FormatException;
                          }
                          if (double.parse(Height) < 0 ||
                              double.parse(Weight) < 0) {
                            throw FormatException;
                          }

                          Provider.of<Data>(context, listen: false)
                              .CaloriesSectionData
                              .setWeight = double.parse(Weight);
                          Provider.of<Data>(context, listen: false)
                              .CaloriesSectionData
                              .setHeight = double.parse(Height);
                          Provider.of<Data>(context, listen: false)
                              .UpdateWeightAndHeight();

                          Navigator.pushNamed(context, 'AllThree');
                          Height = "";
                          Weight = "";
                        } on NullThrownError {
                          ShowErrorMessage(
                              context,
                              'Error',
                              'Please Enter Your Weight or Height\n make sure it\'s Positve Value',
                              90);
                        } on FormatException {
                          ShowErrorMessage(
                              context,
                              'Wrong Height Or Weight Input',
                              'Please make sure the Height or Weight Positve Value',
                              90);
                        } catch (e) {
                          ShowErrorMessage(
                              context,
                              'Wrong Height and Weight Input',
                              'Please Enter Your Weight and Height as Positve Value',
                              90);
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

class weight_input extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      style: const TextStyle(color: Colors.white, fontSize: 18),
      onChanged: (value) {
        Weight = value;
      },
      decoration: const InputDecoration(
        fillColor: Colors.black,
        hintText: 'Enter Your Weight',
        hintStyle: TextStyle(color: Colors.white, fontSize: 18),
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
    );
  }
}

class height_input extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      style: const TextStyle(color: Colors.white, fontSize: 18),
      onChanged: (value) {
        Height = value;
      },
      decoration: const InputDecoration(
        fillColor: Colors.black,
        hintText: 'Enter Your Height',
        hintStyle: TextStyle(color: Colors.white),
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
    );
  }
}
