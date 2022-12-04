import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../userData/Data.dart';

class MealsList extends StatefulWidget {
  const MealsList({Key? key}) : super(key: key);

  @override
  State<MealsList> createState() => UserMealsList();
}

class UserMealsList extends State<MealsList> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 15),
        height: 300,
        width: 350,
        decoration: new BoxDecoration(
          borderRadius: new BorderRadius.circular(16.0),
          color: Colors.white60,
        ),
        child: ListView.builder(
          itemCount: Provider.of<Data>(context).UserMeals.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              color: Colors.amber,
              elevation: 4,
              margin: EdgeInsets.only(top: 8, left: 20, right: 20, bottom: 8),
              child: ListTile(
                title: Container(
                  child: Text(Provider.of<Data>(context).UserMeals[index].name),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                ),
                subtitle: Container(
                  child: Text(
                      ' calories: ${Provider.of<Data>(context).UserMeals[index].calories}'),
                ),
                trailing: Container(
                  child: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: (() {
                      Provider.of<Data>(context, listen: false).deletecalo(
                          Provider.of<Data>(context, listen: false)
                              .UserMeals[index]
                              .calories);
                      Provider.of<Data>(context, listen: false)
                          .DeleteUserMealsList(
                              Provider.of<Data>(context, listen: false)
                                  .UserMeals[index]);
                    }),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
