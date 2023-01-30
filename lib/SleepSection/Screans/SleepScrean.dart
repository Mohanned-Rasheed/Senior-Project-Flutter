import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import 'package:healthreminder1/SleepSection/function/ChangeSleepTarget.dart';
import 'package:healthreminder1/SleepSection/function/SleepList.dart';
import 'package:healthreminder1/SleepSection/model/SleepRecord.dart';
import 'package:healthreminder1/fuction/notification_service.dart';
import 'package:healthreminder1/userData/Data.dart';
import 'package:provider/provider.dart';

final ref = FirebaseDatabase.instance.ref('sleepoutput');
notification Notification = notification();

class SleepSection extends StatefulWidget {
  const SleepSection({Key? key}) : super(key: key);

  @override
  State<SleepSection> createState() => _SleepSectionState();
}

class _SleepSectionState extends State<SleepSection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          elevation: 5,
          width: MediaQuery.of(context).size.width * 0.64,
          backgroundColor: Color(0xff7B8FA1),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text("Hi"),
                accountEmail: Text(
                  '${Provider.of<Data>(context).CaloriesSectionData.getSingedInUser.currentUser!.email}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                ),
              ),
              ListTile(
                leading: Icon(Icons.change_circle_outlined),
                title: Text('ChangeSleepTarget'),
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (_) {
                        return const ChangeSleepTarget();
                      });
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Sgin out'),
                onTap: () => Provider.of<Data>(context, listen: false)
                    .userLogout(context),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: const Color(0xff7B8FA1),
          centerTitle: true,
          title: Row(
            children: [
              const SizedBox(
                width: 15,
              ),
              Icon(Icons.airline_seat_individual_suite_sharp),
              const SizedBox(
                width: 15,
              ),
              const Text(
                'Sleep Section',
                style: TextStyle(color: Colors.white70),
              )
            ],
          ),
        ),
        backgroundColor: Colors.blueGrey,
        body: Container(
          padding: const EdgeInsets.only(top: 30, bottom: 20),
          child: Column(
            children: [
              Flexible(
                child: SizedBox(
                  width: 0,
                  height: 0,
                  child: FirebaseAnimatedList(
                    query: ref,
                    itemBuilder: (context, snapshot, animation, index) {
                      if (Provider.of<Data>(context)
                                  .sleepsection
                                  .getLastTimeHasBeenChanged !=
                              snapshot.value &&
                          Provider.of<Data>(context)
                                  .sleepsection
                                  .getLastTimeHasBeenChanged !=
                              0) {
                        Provider.of<Data>(context, listen: false)
                            .AddSleepRecord(SleepRecord(
                                snapshot.value,
                                DateTime.now().toString(),
                                Provider.of<Data>(context, listen: false)
                                    .sleepsection
                                    .getTargetOfDay));
                      }
                      Provider.of<Data>(context)
                          .sleepsection
                          .setLastTimeHasBeenChanged = snapshot.value;

                      return const Text('');
                    },
                  ),
                ),
              ),
              const SleepList(),
            ],
          ),
        ));
  }

  void getSleepDataAtFirst() async {
    CollectionReference userref = FirebaseFirestore.instance
        .collection('Users')
        .doc(Provider.of<Data>(context, listen: false)
            .CaloriesSectionData
            .getSingedInUser
            .currentUser!
            .email)
        .collection("Data");
    await userref.doc('SleepData').get().then((element) => {
          setState(() {
            Provider.of<Data>(context, listen: false)
                .sleepsection
                .setSleepDurationList = element.get('SleepDurationList');
            Provider.of<Data>(context, listen: false)
                .sleepsection
                .setSleepDateList = element.get('SleepDateList');
            Provider.of<Data>(context, listen: false)
                .sleepsection
                .setTargetOfDayList = element.get('TargetOfDayList');
            Provider.of<Data>(context, listen: false)
                .sleepsection
                .setTargetOfDay = element.get('TargetOfDay');
          })
        });
    setState(() {
      Provider.of<Data>(context, listen: false)
          .sleepsection
          .getSleepRecords
          .clear();
      for (var i = 0;
          i <
              Provider.of<Data>(context, listen: false)
                  .sleepsection
                  .getSleepDurationList
                  .length;
          i++) {
        Provider.of<Data>(context, listen: false)
            .sleepsection
            .getSleepRecords
            .add(SleepRecord(
                Provider.of<Data>(context, listen: false)
                    .sleepsection
                    .getSleepDurationList[i],
                Provider.of<Data>(context, listen: false)
                    .sleepsection
                    .getSleepDateList[i],
                Provider.of<Data>(context, listen: false)
                    .sleepsection
                    .getTargetOfDayList[i]));
      }
    });
  }

  @override
  void initState() {
    Notification.initialiseNotifications();
    Notification.sendNotification('SleepSection', 'Sleep', 1);
    Provider.of<Data>(context, listen: false).getCurrentUser();
    getSleepDataAtFirst();
  }
}
