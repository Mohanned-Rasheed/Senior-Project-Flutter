import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthreminder1/WaterSection/function/AddWater.dart';
import 'package:healthreminder1/WaterSection/function/ChangeWaterTarget.dart';
import 'package:healthreminder1/WaterSection/models/Water.dart';
import 'package:healthreminder1/userData/Data.dart';
import 'package:provider/provider.dart';

class UserWaterList extends StatefulWidget {
  const UserWaterList({Key? key}) : super(key: key);

  @override
  State<UserWaterList> createState() => _UserWaterListState();
}

class _UserWaterListState extends State<UserWaterList> {
  initState() {
    getDataAtFirst();
  }

  void getDataAtFirst() async {
    CollectionReference userref = FirebaseFirestore.instance
        .collection('Users')
        .doc(Provider.of<Data>(context, listen: false)
            .CaloriesSectionData
            .singedInUser
            .email)
        .collection("Data");
    await userref.doc('WaterData').get().then((element) => {
          setState(() {
            Provider.of<Data>(context, listen: false)
                .WaterSectionData
                .TotalWaterPortion = element.get("TotalWaterPortion");
            Provider.of<Data>(context, listen: false)
                .WaterSectionData
                .WaterTarget = element.get("WaterTarget");
            Provider.of<Data>(context, listen: false)
                .WaterSectionData
                .UserWaterListDates = element.get("DatesUserWaterList");
            Provider.of<Data>(context, listen: false)
                .WaterSectionData
                .UserWaterListAmount = element.get("UserWaterListAmount");

            if (Provider.of<Data>(context, listen: false)
                    .WaterSectionData
                    .UserWaterListAmount
                    .length !=
                Provider.of<Data>(context, listen: false)
                    .WaterSectionData
                    .UserWaterList
                    .length) {
              Provider.of<Data>(context, listen: false)
                  .WaterSectionData
                  .UserWaterList
                  .clear();
              for (var i = 0;
                  i <
                      Provider.of<Data>(context, listen: false)
                          .WaterSectionData
                          .UserWaterListAmount
                          .length;
                  i++) {
                Water water = Water(
                    Provider.of<Data>(context, listen: false)
                        .WaterSectionData
                        .UserWaterListAmount[i],
                    Provider.of<Data>(context, listen: false)
                        .WaterSectionData
                        .UserWaterListDates[i]);
                Provider.of<Data>(context, listen: false)
                    .WaterSectionData
                    .UserWaterList
                    .add(water);
              }
            }
          })
        });

    Provider.of<Data>(context, listen: false).WaterChartKepUpDateAtFirst();
    Provider.of<Data>(context, listen: false).SelectWaterDay(DateTime.now(), 1);
  }

  List<String> itemList = ['today', 'last 3 days', 'last week'];
  String selectedItem = 'today';
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width * 0.94,
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.circular(16.0),
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
                child: Icon(Icons.add_circle),
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
                                          child: AddWater())));
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
                                      margin: EdgeInsets.only(
                                          top: 8,
                                          left: 20,
                                          right: 20,
                                          bottom: 8),
                                      child: ListTile(
                                        title: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 13.0),
                                          child: Container(
                                            child: Center(
                                              child: Text(
                                                "Add Water",
                                                style: TextStyle(fontSize: 20),
                                              ),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                          ),
                                        ),
                                        subtitle: Container(
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
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.60,
                                          padding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom),
                                          child: ChangeWaterTarget())));
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
                                      margin: EdgeInsets.only(
                                          top: 8,
                                          left: 20,
                                          right: 20,
                                          bottom: 8),
                                      child: ListTile(
                                        title: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 13.0),
                                          child: Container(
                                            child: Center(
                                              child: Text(
                                                "Change Water Target",
                                                style: TextStyle(fontSize: 20),
                                              ),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                          ),
                                        ),
                                        subtitle: Container(
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
                                DateTime.now().subtract(Duration(days: 3)), 3);
                      } else if (selectedItem == 'last week') {
                        Provider.of<Data>(context, listen: false)
                            .SelectWaterDay(
                                DateTime.now().subtract(Duration(days: 7)), 7);
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
                  .WaterSectionData
                  .UserWaterList
                  .length,
              itemBuilder: (BuildContext context, int index) {
                return Provider.of<Data>(context)
                            .WaterSectionData
                            .WaterListDate
                            .day <=
                        DateTime.parse(Provider.of<Data>(context)
                                .WaterSectionData
                                .UserWaterList[index]
                                .date)
                            .day
                    ? Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        color: Color(0xffCFB997),
                        elevation: 4,
                        margin: EdgeInsets.only(
                            top: 8, left: 20, right: 20, bottom: 8),
                        child: ListTile(
                          title: Container(
                            child: Text(Provider.of<Data>(context)
                                    .WaterSectionData
                                    .UserWaterList[index]
                                    .amount
                                    .toString() +
                                ' ml\t\t\t\t\t'),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                          ),
                          subtitle: Text('\t\t' +
                              'At \t' +
                              Provider.of<Data>(context)
                                  .WaterSectionData
                                  .UserWaterList[index]
                                  .date
                                  .toString()
                                  .substring(0, 10)),
                          trailing: Container(
                            child: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: (() {
                                Provider.of<Data>(context, listen: false)
                                    .DeleteWater(Provider.of<Data>(context,
                                            listen: false)
                                        .WaterSectionData
                                        .UserWaterList[index]);
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
}
