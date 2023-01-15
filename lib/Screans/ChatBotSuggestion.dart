import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dialogflow_flutter/dialogflowFlutter.dart';
import 'package:dialogflow_flutter/googleAuth.dart';
import 'package:dialogflow_flutter/language.dart';
import 'package:flutter/material.dart';
import 'package:healthreminder1/models/Meals.dart';
import 'package:healthreminder1/userData/Data.dart';
import 'package:provider/provider.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => ChatSuggetion();
}

class ChatSuggetion extends State<MyWidget> {
  static const String ScreanRoute = 'ChatSuggetion';
  var messageCon = TextEditingController();
  List<Map> messages = [];
  List<Meals> SuggestedMeals = [];
  @override
  void initState() {
    response('start');
  }

  void response(query) async {
    AuthGoogle authGoogle = await AuthGoogle(
      fileJson: "assets/credentials.json",
    ).build();
    DialogFlow dialogFlow =
        DialogFlow(authGoogle: authGoogle, language: Language.english);
    AIResponse aiResponse = await dialogFlow.detectIntent(query);
    setState(() {
      messages.insert(0, {
        "data": 0,
        "messages":
            aiResponse.getListMessage()![0]["text"]["text"][0].toString()
      });
    });

    // Meals m = Meals('name', 200);
    // Provider.of<Data>(context, listen: false).addcalo(m.calories);
    // Provider.of<Data>(context, listen: false).addUserMealsList(m);
    // Provider.of<Data>(context, listen: false)
    //     .addDates(DateTime.now().toString());
    // Provider.of<Data>(context, listen: false).updateUser();
    // print("bro please ");

    // print(aiResponse.getListMessage()![0]["text"]["text"][0].toString());
    //print(messages[0]["message"].toString());
    //print(messages[0]["data"]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sugetion"),
      ),
      body: Container(
        child: Column(
          children: [
            Center(
              child: Container(
                padding: EdgeInsets.only(top: 15, bottom: 10),
                child: Text(
                  "  ",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Flexible(
                child: ListView.builder(
                    itemCount: messages.length,
                    reverse: true,
                    itemBuilder: (context, index) => chat(
                        messages[index]["messages"].toString(),
                        messages[index]["data"]))),
            Divider(
              height: 5,
              color: Colors.black,
            ),
            Container(
              child: ListTile(
                title: Container(
                  height: 35,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Colors.black12),
                  padding: EdgeInsets.only(left: 15),
                  child: TextFormField(
                    controller: messageCon,
                    decoration: InputDecoration(
                      hintText: "Enter a message",
                      hintStyle: TextStyle(color: Colors.black),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.send,
                    size: 30,
                  ),
                  onPressed: () {
                    if (messageCon.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Make Sure To Write Something'),
                      ));
                    } else {
                      messages
                          .insert(0, {"data": 1, "messages": messageCon.text});
                      if (int.tryParse(messageCon.text) == null) {
                        response(messageCon.text);
                      } else {
                        if (int.parse(messageCon.text) < 4 &&
                            SuggestedMeals.isNotEmpty) {
                          // Provider.of<Data>(context, listen: false)
                          //     .UserMeals
                          //     .add(SuggestedMeals[int.parse(messageCon.text)]);
                          Provider.of<Data>(context, listen: false).addcalo(
                              SuggestedMeals[int.parse(messageCon.text) - 1]
                                  .calories);

                          Provider.of<Data>(context, listen: false)
                              .addUserMealsList(SuggestedMeals[
                                  int.parse(messageCon.text) - 1]);
                          Provider.of<Data>(context, listen: false)
                              .addDates(DateTime.now().toString());
                          Provider.of<Data>(context, listen: false)
                              .ChartKepUpDate();
                          updateUserMeals();
                        }
                      }
                      if (messageCon.text.contains('sugg')) {
                        SuggestedMeals.clear();
                        int counter = 0;
                        for (var i = 0;
                            i <
                                Provider.of<Data>(context, listen: false)
                                    .meals
                                    .length;
                            i++) {
                          if (Provider.of<Data>(context, listen: false)
                                          .TargetCalories -
                                      Provider.of<Data>(context, listen: false)
                                          .totalCalories >
                                  Provider.of<Data>(context, listen: false)
                                      .meals[i]
                                      .calories &&
                              counter < 3) {
                            Provider.of<Data>(context, listen: false)
                                .meals
                                .shuffle();
                            SuggestedMeals.add(
                                Provider.of<Data>(context, listen: false)
                                    .meals[i]);
                            String NewString = '${counter + 1}.' +
                                Provider.of<Data>(context, listen: false)
                                    .meals[i]
                                    .name;
                            setState(() {
                              messages.insert(
                                  0, {"data": 0, "messages": NewString});
                            });

                            counter++;
                          }
                        }
                      }

                      messageCon.clear();
                    }
                    // FocusScopeNode currentFocus = FocusScope.of(context);
                    // if (!currentFocus.hasPrimaryFocus) {
                    //   currentFocus.unfocus();
                    // }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget chat(String message, int data) {
    return Container(
      padding: EdgeInsets.only(right: 20, left: 20),
      child: Row(
        mainAxisAlignment:
            data == 1 ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Bubble(
              radius: Radius.circular(15),
              color: data == 0 ? Colors.grey : Colors.green,
              elevation: 0,
              child: Padding(
                padding: EdgeInsets.all(2),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: Container(
                        constraints: BoxConstraints(maxWidth: 200),
                        child: Text(
                          message,
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void updateUserMeals() {
    final docUser = FirebaseFirestore.instance
        .collection('Users')
        .doc(Provider.of<Data>(context, listen: false).singedInUser.email);
    docUser.update({
      'calories': Provider.of<Data>(context, listen: false).totalCalories,
      'mealsName': Provider.of<Data>(context, listen: false).UserMealsNames,
      'mealsCalories':
          Provider.of<Data>(context, listen: false).UserMealsCalories,
      'dateOfTheDay': Provider.of<Data>(context, listen: false).UserMealsDates,
    });
  }
}
