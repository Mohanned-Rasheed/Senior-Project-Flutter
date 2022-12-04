import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthreminder1/fuction/AddAmeal.dart';
import 'package:healthreminder1/fuction/AddCalories.dart';
import 'package:healthreminder1/fuction/UserMealsList.dart';
import 'package:healthreminder1/models/Meals.dart';
import 'package:provider/provider.dart';
import '../userData/Data.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

String _scanBarcode = 'Unknown';
var steps = 0;

class CaloriesSection extends StatefulWidget {
  @override
  State<CaloriesSection> createState() {
    return _CaloriesSectionState();
  }
}

class _CaloriesSectionState extends State<CaloriesSection> {
  final ref = FirebaseDatabase.instance.ref('stepsoutput');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.teal[200],
        body: Container(
          padding: EdgeInsets.only(top: 50, bottom: 20),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('CaloriesSection',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Flexible(
                child: Container(
                  width: 0,
                  height: 0,
                  child: FirebaseAnimatedList(
                    query: ref,
                    itemBuilder: (context, snapshot, animation, index) {
                      steps = int.parse(snapshot.value.toString());
                      return Text('');
                    },
                  ),
                ),
              ),
              Container(
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'Total Calories: ${Provider.of<Data>(context).totalCalories} \n Total steps: $steps',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                height: 80,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
              MealsList(),
              SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 15),
                    alignment: Alignment.centerLeft,
                    child: RaisedButton(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        child: Text('add calories'),
                        onPressed: () {
                          showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (context) => SingleChildScrollView(
                                  child: Container(
                                      padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                              .viewInsets
                                              .bottom),
                                      child: Addcalories())));
                        }),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15),
                    alignment: Alignment.centerLeft,
                    child: RaisedButton(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: Text('add meal'),
                      onPressed: (() {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) => Container(
                                  child: SingleChildScrollView(
                                      child: Container(
                                    child: AddAmeal(),
                                    height: 350,
                                  )),
                                ));
                      }),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15),
                    alignment: Alignment.centerLeft,
                    child: RaisedButton(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: Text('Scan QRCode'),
                      onPressed: (() => scanQR()),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      //print(_scanBarcode.substring(5) + "aaaaaaaaaaaaaaaaaaaa");
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.

    if (!mounted) return;
// _scanBarcode.substring(4)
    List<String> Value = barcodeScanRes.split(" ");
    Meals newMeal = new Meals(Value[0], int.parse(Value[1]));
    Provider.of<Data>(context, listen: false).addUserMealsList(newMeal);
    Provider.of<Data>(context, listen: false).addcalo(int.parse(Value[1]));
  }
}
