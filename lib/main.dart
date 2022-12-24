import 'package:flutter/material.dart';
import 'package:healthreminder1/Screans/ChatBotSuggestion.dart';
import 'package:healthreminder1/Screans/Register_Screan.dart';
import 'package:healthreminder1/Screans/Sginin_Screan.dart';
import 'package:healthreminder1/Screans/Sleep.dart';
import 'package:healthreminder1/Screans/Water.dart';
import 'package:healthreminder1/Screans/Welcome_Screan.dart';
import 'Screans/Calories.dart';
import 'package:provider/provider.dart';
import 'userData/Data.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  final _auth = FirebaseAuth.instance;

  int index = 0;
  final pages = [
    Center(
      child: CaloriesSection(),
    ),
    Center(
      child: WaterSection(),
    ),
    Center(
      child: SleepSection(),
    )
  ];
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Data(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute:
            _auth.currentUser == null ? WelcomeScrean.ScreanRoute : 'AllThree',
        routes: {
          WelcomeScrean.ScreanRoute: (context) => WelcomeScrean(),
          Sginin_Screan.ScreeanRoute: (context) => Sginin_Screan(),
          Register_Screan.ScreanRoute: (context) => Register_Screan(),
          'AllThree': (context) => AllThree(),
          ChatSuggetion.ScreanRoute: (context) => MyWidget(),
        },
      ),
    );
  }

  FutureBuilder<FirebaseApp> AllThree() {
    return FutureBuilder(
      future: _fbApp,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print("you have an error! ${snapshot.error.toString()}");
          return Text('Something went wrong');
        } else if (snapshot.hasData) {
          return Scaffold(
            body: pages[index],
            bottomNavigationBar: NavigationBar(
              backgroundColor: Colors.greenAccent,
              selectedIndex: index,
              onDestinationSelected: (index) => setState(() {
                this.index = index;
              }),
              height: 60,
              destinations: [
                NavigationDestination(
                  icon: Icon(Icons.home),
                  selectedIcon: Icon(Icons.home),
                  label: 'CaloriesSection',
                ),
                NavigationDestination(
                  icon: Icon(Icons.home),
                  selectedIcon: Icon(Icons.home),
                  label: 'WaterSection',
                ),
                NavigationDestination(
                  icon: Icon(Icons.home),
                  selectedIcon: Icon(Icons.home),
                  label: 'SleepSection',
                ),
              ],
            ),
          );
        } else {
          return Scaffold(
              body: Center(
            child: CircularProgressIndicator(),
          ));
        }
      },
    );
  }
}
