import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:healthreminder1/userData/Data.dart';

class AddAmeal extends StatefulWidget {
  const AddAmeal({Key? key}) : super(key: key);

  @override
  State<AddAmeal> createState() => _AddAmealState();
}

class _AddAmealState extends State<AddAmeal> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: Provider.of<Data>(context).meals.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.amber,
          elevation: 4,
          margin: EdgeInsets.only(top: 8, left: 12, right: 12, bottom: 8),
          child: ListTile(
            title: Container(
              child: Text(Provider.of<Data>(context).meals[index].name),
              padding: EdgeInsets.symmetric(horizontal: 10),
            ),
            subtitle: Container(
              child: Text(
                  ' calories: ${Provider.of<Data>(context).meals[index].calories}'),
            ),
            trailing: Container(
              child: RaisedButton(
                onPressed: (() {
                  Provider.of<Data>(context, listen: false).addcalo(
                      Provider.of<Data>(context, listen: false)
                          .meals[index]
                          .calories);

                  Provider.of<Data>(context, listen: false).addUserMealsList(
                      Provider.of<Data>(context, listen: false).meals[index]);
                }),
                child: Text('Add'),
              ),
            ),
          ),
        );
      },
    );
  }
}
