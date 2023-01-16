import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:healthreminder1/WaterSection/userWaterList.dart';

import 'WaterDigram.dart';

class WaterSection extends StatefulWidget {
  const WaterSection({Key? key}) : super(key: key);

  @override
  State<WaterSection> createState() => _WaterSectionState();
}

class _WaterSectionState extends State<WaterSection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff7B8FA1),
        body: Container(
          height: 1000,
          width: 1000,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(top: 50, bottom: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('WaterSection',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22)),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: WaterDigram(),
                  ),
                  UserWaterList()
                ],
              ),
            ),
          ),
        ));
  }
}
