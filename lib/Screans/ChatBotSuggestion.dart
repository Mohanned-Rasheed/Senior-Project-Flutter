import 'package:bubble/bubble.dart';
import 'package:dialogflow_flutter/dialogflowFlutter.dart';
import 'package:dialogflow_flutter/googleAuth.dart';
import 'package:dialogflow_flutter/language.dart';
import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => ChatSuggetion();
}

class ChatSuggetion extends State<MyWidget> {
  var messageCon = TextEditingController();
  List<Map> messages = [];

  void response(query) async {
    AuthGoogle authGoogle = await AuthGoogle(
      fileJson: "assets/credentials.json",
    ).build();
    DialogFlow dialogFlow =
        DialogFlow(authGoogle: authGoogle, language: Language.english);
    AIResponse aiResponse = await dialogFlow.detectIntent(query);

    messages.insert(0, {
      "data": 0,
      "messages": aiResponse.getListMessage()![0]["text"]["text"][0].toString()
    });
    print(aiResponse.getListMessage()![0]["text"]["text"][0].toString());
    print(messages[0]["message"].toString());
    print(messages[0]["data"]);
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
                  "Today,  ",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Flexible(
                child: ListView.builder(
                    itemCount: 0,
                    reverse: true,
                    itemBuilder: (context, index) => chat(
                        messages[index]["message"].toString(),
                        messages[index]["data"]))),
            Divider(
              height: 5,
              color: Colors.black,
            ),
            Container(
              child: ListTile(
                leading: IconButton(
                  iconSize: 35,
                  icon: Icon(Icons.camera_alt),
                  onPressed: () {},
                ),
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
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
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
                      print("contrller emtay");
                    } else {
                      setState(() {
                        messages
                            .insert(0, {"data": 1, "message": messageCon.text});
                      });
                      response(messageCon.text);
                      messageCon.clear();
                    }
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
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
              color: data == 0 ? Colors.blue : Colors.green,
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
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          data == 0
              ? Container(
                  height: 60,
                  width: 60,
                  child: CircleAvatar(
                    backgroundColor: Colors.amber,
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
