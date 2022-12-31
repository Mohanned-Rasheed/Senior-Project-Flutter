import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:healthreminder1/userData/Data.dart';
import 'package:provider/provider.dart';

class AfterRegester_Screan extends StatefulWidget {
  const AfterRegester_Screan({Key? key}) : super(key: key);
  static const String ScreanRoute = 'AfterRegester_Screan';

  @override
  State<AfterRegester_Screan> createState() => _AfterRegester_ScreanState();
}

class _AfterRegester_ScreanState extends State<AfterRegester_Screan> {
  @override
  Widget build(BuildContext context) {
    double Weight = 0;
    double Height = 0;
    bool WeightFlag = false;
    bool HeightFlag = false;
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
                    try {
                      if (value != "") {
                        Weight = double.parse(value);
                      }
                      if (value == "") {
                        Weight = 0;
                      }
                    } catch (e) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Error'),
                              content:
                                  Text('Please Enter Your Weight as Numbers'),
                            );
                          });
                      print("Please Enter Only Numbers");
                    }
                  },
                  decoration: InputDecoration(
                    errorText: WeightFlag ? "Must be Filled" : null,
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
                    try {
                      if (value != "") {
                        Height = double.parse(value);
                      }
                    } catch (e) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Error'),
                              content:
                                  Text('Please Enter Your Height as Numbers'),
                            );
                          });
                      print("Please Enter Only Numbers");
                    }
                  },
                  decoration: InputDecoration(
                    errorText: HeightFlag ? "Must be Filled" : null,
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
                          if (Weight == 0) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Error'),
                                    content: Text('Please Enter Your Weight'),
                                  );
                                });
                          } else if (Height == 0) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Error'),
                                    content: Text('Please Enter Your Height'),
                                  );
                                });
                          }
                          Provider.of<Data>(context, listen: false).Weight =
                              Weight;
                          Provider.of<Data>(context, listen: false).Height =
                              Height;
                        } catch (e) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Error'),
                                  content: Text(
                                      'Please Enter Your Weight and Height as Numbers'),
                                );
                              });
                          print("Sorry Only Number");
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
