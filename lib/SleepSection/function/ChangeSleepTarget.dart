import 'package:flutter/material.dart';
import 'package:healthreminder1/userData/Data.dart';
import 'package:provider/provider.dart';

class ChangeSleepTarget extends StatefulWidget {
  const ChangeSleepTarget({Key? key}) : super(key: key);

  @override
  State<ChangeSleepTarget> createState() => _ChangeSleepTargetState();
}

class _ChangeSleepTargetState extends State<ChangeSleepTarget> {
  List<String> itemList = [
    '2 Hours',
    '3 Hours',
    '4 Hours',
    '5 Hours',
    '6 Hours',
    '7 Hours',
    '8 Hours',
    '9 Hours',
    '10 Hours',
    '11 Hours',
    '12 Hours',
    '13 Hours',
    '14 Hours'
  ];
  String selectedItem = '8 Hours';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(
                textAlign: TextAlign.center,
                'Choose New Sleep Target',
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.indigo[400],
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 20,
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
                    }),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          TextButton(
            onPressed: () {
              Provider.of<Data>(context, listen: false)
                  .User
                  .sleepsection
                  .setTargetOfDay = double.parse(selectedItem.substring(0, 2));

              Navigator.pop(context);
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.teal[300],
            ),
            child: Text('Submit'),
          )
        ],
      ),
    );
  }
}
