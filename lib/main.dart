import 'package:flutter/material.dart';
import 'package:healthreminder1/Screans/AfterRegester_Screan.dart';
import 'package:healthreminder1/Screans/ChatBotSuggestion.dart';
import 'package:healthreminder1/Screans/Register_Screan.dart';
import 'package:healthreminder1/Screans/Sginin_Screan.dart';
import 'package:healthreminder1/SleepSection/Screans/SleepScrean.dart';
import 'package:healthreminder1/SleepSection/Screans/DetailedRecordChart.dart';
import 'package:healthreminder1/WaterSection/Screans/WaterScrean.dart';
import 'package:healthreminder1/Screans/Welcome_Screan.dart';
import 'package:healthreminder1/models/ShowErrorMessage.dart';
import 'Screans/CaloriesScrean.dart';
import 'package:provider/provider.dart';
import 'userData/Data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

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
    const Center(
      child: WaterSection(),
    ),
    const Center(
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
          ChatSuggetion.ScreanRoute: (context) => const MyWidget(),
          AfterRegester_Screan.ScreanRoute: (context) =>
              const AfterRegester_Screan(),
          CaloriesSection.ScreanRoute: (context) => CaloriesSection(),
          DetailedRecord.ScreanRoute: (context) => const DetailedRecord(),
        },
      ),
    );
  }

  FutureBuilder<FirebaseApp> AllThree() {
    return FutureBuilder(
      future: _fbApp,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          ShowErrorMessage(context,
              "you have an error! ${snapshot.error.toString()}", '', 100);
          return const Text('Something went wrong');
        } else if (snapshot.hasData) {
          return Scaffold(
            body: pages[index],
            bottomNavigationBar: NavigationBar(
              backgroundColor: Colors.black12,
              selectedIndex: index,
              onDestinationSelected: (index) => setState(() {
                this.index = index;
              }),
              height: 60,
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.fastfood_rounded),
                  selectedIcon: Icon(Icons.fastfood_rounded),
                  label: 'CaloriesSection',
                ),
                NavigationDestination(
                  icon: Icon(Icons.water_drop_outlined),
                  selectedIcon: Icon(Icons.water_drop_outlined),
                  label: 'WaterSection',
                ),
                NavigationDestination(
                  icon: Icon(Icons.airline_seat_individual_suite_sharp),
                  selectedIcon: Icon(Icons.airline_seat_individual_suite_sharp),
                  label: 'SleepSection',
                ),
              ],
            ),
          );
        } else {
          return const Scaffold(
              body: Center(
            child: CircularProgressIndicator(),
          ));
        }
      },
    );
  }
}
