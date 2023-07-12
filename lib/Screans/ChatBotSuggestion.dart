import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dialogflow_flutter/dialogflowFlutter.dart';
import 'package:dialogflow_flutter/googleAuth.dart';
import 'package:dialogflow_flutter/language.dart';
import 'package:flutter/material.dart';
import 'package:healthreminder1/models/Meals.dart';
import 'package:healthreminder1/models/ShowErrorMessage.dart';
import 'package:healthreminder1/userData/Data.dart';
import 'package:provider/provider.dart';

class ChatSuggetion extends State<MyWidget> {
  static const String ScreanRoute = 'ChatSuggetion';
  var messageCon = TextEditingController();
  List<Map> messages = [];
  List<Meals> SuggestedMeals = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff7B8FA1),
        title: const Text("Sugetion"),
      ),
      body: Container(
        color: Colors.blueGrey,
        child: Column(
          children: [
            Flexible(
                child: ListView.builder(
                    itemCount: messages.length,
                    reverse: true,
                    itemBuilder: (context, index) => chat(
                        messages[index]["messages"].toString(),
                        messages[index]["data"]))),
            const Divider(
              height: 5,
              color: Colors.black,
            ),
            Container(
              child: ListTile(
                title: Container(
                  height: 35,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Colors.black12),
                  padding: const EdgeInsets.only(left: 15),
                  child: TextFormField(
                    controller: messageCon,
                    decoration: const InputDecoration(
                      hintText: "Enter a message",
                      hintStyle: TextStyle(color: Colors.black),
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.send,
                    size: 30,
                  ),
                  onPressed: () {
                    if (messageCon.text.isEmpty) {
                      ShowErrorMessage(
                          context, "Error", "Make Sure To Write Something", 75);
                    } else {
                      setState(() {
                        messages.insert(
                            0, {"data": 1, "messages": messageCon.text});
                      });

                      if (int.tryParse(messageCon.text) != null &&
                          int.parse(messageCon.text) < 4 &&
                          SuggestedMeals.isNotEmpty) {
                        // Provider.of<Data>(context, listen: false)
                        //     .UserMeals
                        //     .add(SuggestedMeals[int.parse(messageCon.text)]);
                        Provider.of<Data>(context, listen: false).addcalo(
                            SuggestedMeals[int.parse(messageCon.text) - 1]
                                .getCalories);

                        Provider.of<Data>(context, listen: false)
                            .addUserMealsList(
                                SuggestedMeals[int.parse(messageCon.text) - 1]);
                        Provider.of<Data>(context, listen: false)
                            .addDates(DateTime.now().toString());
                        Provider.of<Data>(context, listen: false)
                            .ChartKepUpDate();
                        updateUserMeals();
                        setState(() {
                          messages.insert(0, {
                            "data": 0,
                            "messages": "Meal Has Been Added To Your List"
                          });
                        });
                      }

                      if (messageCon.text.contains('sugg')) {
                        SuggestedMeals.clear();
                        Provider.of<Data>(context, listen: false)
                            .User
                            .CaloriesSectionData
                            .meals
                            .shuffle();
                        int counter = 0;
                        for (var i = 0;
                            i <
                                Provider.of<Data>(context, listen: false)
                                    .User
                                    .CaloriesSectionData
                                    .meals
                                    .length;
                            i++) {
                          if (Provider.of<Data>(context, listen: false)
                                          .User
                                          .CaloriesSectionData
                                          .getTargetCalories -
                                      Provider.of<Data>(context, listen: false)
                                          .User
                                          .CaloriesSectionData
                                          .getCaloriesChart[0]
                                          .getValue >=
                                  Provider.of<Data>(context, listen: false)
                                      .User
                                      .CaloriesSectionData
                                      .meals[i]
                                      .getCalories &&
                              counter < 3) {
                            String NewString = '';
                            if (!SuggestedMeals.contains(
                                Provider.of<Data>(context, listen: false)
                                    .User
                                    .CaloriesSectionData
                                    .meals[i])) {
                              SuggestedMeals.add(
                                  Provider.of<Data>(context, listen: false)
                                      .User
                                      .CaloriesSectionData
                                      .meals[i]);
                              NewString =
                                  '${counter + 1}.${Provider.of<Data>(context, listen: false).User.CaloriesSectionData.meals[i].getName}, ${Provider.of<Data>(context, listen: false).User.CaloriesSectionData.meals[i].getCalories} Calories';
                              setState(() {
                                messages.insert(
                                    0, {"data": 0, "messages": NewString});
                              });
                              counter++;
                            }
                          }
                        }
                        if (SuggestedMeals.isNotEmpty) {
                          response(messageCon.text);
                        } else {
                          response('NoSuggestion');
                        }
                      } else {
                        if (int.tryParse(messageCon.text) == null) {
                          response(messageCon.text);
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
      padding: const EdgeInsets.only(right: 20, left: 20),
      child: Row(
        mainAxisAlignment:
            data == 1 ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Bubble(
              radius: const Radius.circular(15),
              color: data == 0 ? Colors.grey : Colors.green,
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 200),
                        child: Text(
                          message,
                          style: const TextStyle(
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
  }

  void updateUserMeals() {
    final docUser = FirebaseFirestore.instance
        .collection('Users')
        .doc(Provider.of<Data>(context, listen: false)
            .User
            .getSingedInUser
            .currentUser!
            .email)
        .collection("Data");
    docUser.doc('CaloriesData').update({
      'calories': Provider.of<Data>(context, listen: false)
          .User
          .CaloriesSectionData
          .getTotalCalories,
      'mealsName': Provider.of<Data>(context, listen: false)
          .User
          .CaloriesSectionData
          .getUserMealsNames,
      'mealsCalories': Provider.of<Data>(context, listen: false)
          .User
          .CaloriesSectionData
          .getUserMealsCalories,
      'dateOfTheDay': Provider.of<Data>(context, listen: false)
          .User
          .CaloriesSectionData
          .getUserMealsDates,
    });
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => ChatSuggetion();
}
