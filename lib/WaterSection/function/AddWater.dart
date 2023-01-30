import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:healthreminder1/WaterSection/models/Water.dart';
import 'package:provider/provider.dart';

import '../../userData/Data.dart';

class AddWater extends StatefulWidget {
  const AddWater({Key? key}) : super(key: key);

  @override
  State<AddWater> createState() => _AddWaterState();
}

class _AddWaterState extends State<AddWater> {
  @override
  var NewTarget = 0;
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.teal[100],
              child: ListView.builder(
                itemCount: Provider.of<Data>(context, listen: false)
                    .WaterSectionData
                    .getWaterList
                    .length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    color: Colors.amber,
                    elevation: 4,
                    margin:
                        EdgeInsets.only(top: 8, left: 12, right: 12, bottom: 8),
                    child: ListTile(
                      title: Container(
                        child: Text(''),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                      subtitle: Container(
                        child: Text(
                          Provider.of<Data>(context, listen: false)
                                  .WaterSectionData
                                  .getWaterList[index]
                                  .amount
                                  .toString() +
                              ' ml ',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      trailing: Container(
                        child: ElevatedButton(
                          // color: Colors.teal[200],
                          // shape: RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.circular(12)),
                          onPressed: (() {
                            Provider.of<Data>(context, listen: false).AddWater(
                                Water(
                                    Provider.of<Data>(context, listen: false)
                                        .WaterSectionData
                                        .getWaterList[index]
                                        .amount,
                                    Provider.of<Data>(context, listen: false)
                                        .WaterSectionData
                                        .getWaterList[index]
                                        .date));
                          }),
                          child: Text('Add',
                              style: TextStyle(color: Colors.black54)),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
    ;
  }
}
