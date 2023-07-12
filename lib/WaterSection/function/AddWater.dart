import 'package:flutter/material.dart';
import 'package:healthreminder1/WaterSection/models/Water.dart';
import 'package:provider/provider.dart';
import '../../fuction/notification_service.dart';
import '../../userData/Data.dart';

notification Notification = notification();

class AddWater extends StatefulWidget {
  const AddWater({Key? key}) : super(key: key);

  @override
  State<AddWater> createState() => _AddWaterState();
}

class _AddWaterState extends State<AddWater> {
  @override
  var NewTarget = 0;
  Widget build(BuildContext context) {
    void CheckNotifcation() {
      Notification.initialiseNotifications();
      if (Provider.of<Data>(context, listen: false)
                  .User
                  .WaterSectionData
                  .getWaterTarget -
              Provider.of<Data>(context, listen: false)
                  .User
                  .WaterSectionData
                  .getWaterChart[0]
                  .getValue >=
          0) {
        Notification.sendNotification(
            'YourReminig Water is: ${Provider.of<Data>(context, listen: false).User.WaterSectionData.getWaterTarget - Provider.of<Data>(context, listen: false).User.WaterSectionData.getWaterChart[0].getValue} ml',
            'Dont Forget To Drink Water To reach your Target',
            1);
      }
    }

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.teal[100],
              child: ListView.builder(
                itemCount: Provider.of<Data>(context, listen: false)
                    .User
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
                                  .User
                                  .WaterSectionData
                                  .getWaterList[index]
                                  .getAmount
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
                                        .User
                                        .WaterSectionData
                                        .getWaterList[index]
                                        .getAmount,
                                    Provider.of<Data>(context, listen: false)
                                        .User
                                        .WaterSectionData
                                        .getWaterList[index]
                                        .getDate));
                            CheckNotifcation();
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
