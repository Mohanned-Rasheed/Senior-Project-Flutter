import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthreminder1/WaterSection/function/AddWater.dart';
import 'package:healthreminder1/WaterSection/function/ChangeWaterTarget.dart';
import 'package:healthreminder1/WaterSection/models/Water.dart';
import 'package:healthreminder1/userData/Data.dart';
import 'package:provider/provider.dart';

import '../fuction/notification_service.dart';

notification Notification = notification();

class UserWaterList extends StatefulWidget {
  const UserWaterList({Key? key}) : super(key: key);

  @override
  State<UserWaterList> createState() => _UserWaterListState();
}

class _UserWaterListState extends State<UserWaterList> {
  List<String> itemList = ['today', 'last 3 days', 'last week'];

  String selectedItem = 'today';

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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width * 0.94,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.white60,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // RaisedButton(
              //   onPressed: () {
              //     Navigator.pushNamed(context, ChatSuggetion.ScreanRoute);
              //   },
              //   child: Text("ChatBot"),
              // ),
              GestureDetector(
                child: const Icon(Icons.add_circle),
                onTap: () => showModalBottomSheet(
                  backgroundColor: Colors.teal[100],
                  context: context,
                  builder: (context) {
                    return SingleChildScrollView(
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
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.45,
                                          padding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom),
                                          child: const AddWater())));
                            },
                            child: SingleChildScrollView(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                child: Column(
                                  children: [
                                    Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      color: Colors.amber,
                                      elevation: 4,
                                      margin: const EdgeInsets.only(
                                          top: 8,
                                          left: 20,
                                          right: 20,
                                          bottom: 8),
                                      child: ListTile(
                                        title: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 13.0),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Center(
                                              child: Text(
                                                "Add Water",
                                                style: TextStyle(fontSize: 20),
                                              ),
                                            ),
                                          ),
                                        ),
                                        subtitle: Container(
                                          child: const Text(''),
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
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.60,
                                          padding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom),
                                          child: const ChangeWaterTarget())));
                            },
                            child: SingleChildScrollView(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                child: Column(
                                  children: [
                                    Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      color: Colors.amber,
                                      elevation: 4,
                                      margin: const EdgeInsets.only(
                                          top: 8,
                                          left: 20,
                                          right: 20,
                                          bottom: 8),
                                      child: ListTile(
                                        title: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 13.0),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Center(
                                              child: Text(
                                                "Change Water Target",
                                                style: TextStyle(fontSize: 20),
                                              ),
                                            ),
                                          ),
                                        ),
                                        subtitle: Container(
                                          child: const Text(''),
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Container(
                  child: DropdownButton<String>(
                    value: selectedItem,
                    items: itemList
                        .map((item) => DropdownMenuItem<String>(
                            value: item, child: Text(item)))
                        .toList(),
                    onChanged: (item) => setState(() {
                      selectedItem = item!;
                      if (selectedItem == 'today') {
                        Provider.of<Data>(context, listen: false)
                            .SelectWaterDay(DateTime.now(), 1);
                      } else if (selectedItem == 'last 3 days') {
                        Provider.of<Data>(context, listen: false)
                            .SelectWaterDay(
                                DateTime.now()
                                    .subtract(const Duration(days: 3)),
                                3);
                      } else if (selectedItem == 'last week') {
                        Provider.of<Data>(context, listen: false)
                            .SelectWaterDay(
                                DateTime.now()
                                    .subtract(const Duration(days: 7)),
                                7);
                      }
                    }),
                  ),
                ),
              ),
            ],
          ),
          Flexible(
            child: ListView.builder(
              itemCount: Provider.of<Data>(context)
                  .User
                  .WaterSectionData
                  .getUserWaterList
                  .length,
              itemBuilder: (BuildContext context, int index) {
                return DateTime.parse(Provider.of<Data>(context)
                                .User
                                .WaterSectionData
                                .getUserWaterList[index]
                                .getDate)
                            .isAfter(Provider.of<Data>(context)
                                .User
                                .WaterSectionData
                                .getWaterListDate) ||
                        Provider.of<Data>(context)
                                .User
                                .WaterSectionData
                                .getWaterListDate
                                .day ==
                            DateTime.parse(Provider.of<Data>(context)
                                    .User
                                    .WaterSectionData
                                    .getUserWaterList[index]
                                    .getDate)
                                .day
                    ? Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        color: const Color(0xffCFB997),
                        elevation: 4,
                        margin: const EdgeInsets.only(
                            top: 8, left: 20, right: 20, bottom: 8),
                        child: ListTile(
                          title: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(Provider.of<Data>(context)
                                    .User
                                    .WaterSectionData
                                    .getUserWaterList[index]
                                    .getAmount
                                    .toString() +
                                ' ml\t\t\t\t\t'),
                          ),
                          subtitle: Text('\t\t' 'At \t' +
                              Provider.of<Data>(context)
                                  .User
                                  .WaterSectionData
                                  .getUserWaterList[index]
                                  .getDate
                                  .toString()
                                  .substring(0, 10)),
                          trailing: Container(
                            child: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: (() {
                                Provider.of<Data>(context, listen: false)
                                    .DeleteWater(Provider.of<Data>(context,
                                            listen: false)
                                        .User
                                        .WaterSectionData
                                        .getUserWaterList[index]);
                                CheckNotifcation();
                              }),
                            ),
                          ),
                        ),
                      )
                    : Container();
              },
            ),
          ),
        ],
      ),
    );
  }

  void getDataAtFirst() async {
    CollectionReference userref = FirebaseFirestore.instance
        .collection('Users')
        .doc(Provider.of<Data>(context, listen: false)
            .User
            .getSingedInUser
            .currentUser!
            .email)
        .collection("Data");
    await userref.doc('WaterData').get().then((element) => {
          setState(() {
            Provider.of<Data>(context, listen: false)
                .User
                .WaterSectionData
                .setTotalWaterPortion = element.get("TotalWaterPortion");
            Provider.of<Data>(context, listen: false)
                .User
                .WaterSectionData
                .setWaterTarget = element.get("WaterTarget");
            Provider.of<Data>(context, listen: false)
                .User
                .WaterSectionData
                .setUserWaterListDates = element.get("DatesUserWaterList");
            Provider.of<Data>(context, listen: false)
                .User
                .WaterSectionData
                .setUserWaterListAmount = element.get("UserWaterListAmount");

            if (Provider.of<Data>(context, listen: false)
                    .User
                    .WaterSectionData
                    .getUserWaterListAmount
                    .length !=
                Provider.of<Data>(context, listen: false)
                    .User
                    .WaterSectionData
                    .getUserWaterList
                    .length) {
              Provider.of<Data>(context, listen: false)
                  .User
                  .WaterSectionData
                  .getUserWaterList
                  .clear();
              for (var i = 0;
                  i <
                      Provider.of<Data>(context, listen: false)
                          .User
                          .WaterSectionData
                          .getUserWaterListAmount
                          .length;
                  i++) {
                Water water = Water(
                    Provider.of<Data>(context, listen: false)
                        .User
                        .WaterSectionData
                        .getUserWaterListAmount[i],
                    Provider.of<Data>(context, listen: false)
                        .User
                        .WaterSectionData
                        .getUserWaterListDates[i]);
                Provider.of<Data>(context, listen: false)
                    .User
                    .WaterSectionData
                    .getUserWaterList
                    .add(water);
              }
            }
          })
        });

    Provider.of<Data>(context, listen: false).WaterChartKepUpDateAtFirst();
    Provider.of<Data>(context, listen: false).SelectWaterDay(DateTime.now(), 1);
  }

  @override
  initState() {
    getDataAtFirst();
  }
}
