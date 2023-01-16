import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:healthreminder1/Screans/ChatBotSuggestion.dart';
import 'package:healthreminder1/WaterSection/function/AddWater.dart';
import 'package:healthreminder1/WaterSection/function/ChangeWaterTarget.dart';
import 'package:healthreminder1/fuction/AddAmeal.dart';
import 'package:healthreminder1/fuction/AddCalories.dart';
import 'package:healthreminder1/fuction/TargetChanger.dart';
import 'package:healthreminder1/userData/Data.dart';
import 'package:provider/provider.dart';

class UserWaterList extends StatefulWidget {
  const UserWaterList({Key? key}) : super(key: key);

  @override
  State<UserWaterList> createState() => _UserWaterListState();
}

class _UserWaterListState extends State<UserWaterList> {
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
                      } else if (selectedItem == 'last 3 days') {
                      } else if (selectedItem == 'last week') {}
                    }),
                  ),
                ),
              ),
            ],
          ),
          Flexible(
            child: ListView.builder(
              itemCount: Provider.of<Data>(context).UserWaterList.length,
              itemBuilder: (BuildContext context, int index) {
                return Provider.of<Data>(context).ListDate.day <=
                        DateTime.parse(Provider.of<Data>(context)
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
                                    .UserWaterList[index]
                                    .amount
                                    .toString() +
                                ' ml'),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                          ),
                          trailing: Container(
                            child: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: (() {
                                Provider.of<Data>(context, listen: false)
                                    .DeleteWater(Provider.of<Data>(context,
                                            listen: false)
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
