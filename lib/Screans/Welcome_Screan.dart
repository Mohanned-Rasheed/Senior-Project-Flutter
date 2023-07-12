import 'package:flutter/material.dart';
import 'package:healthreminder1/Screans/Register_Screan.dart';
import 'package:healthreminder1/Screans/Sginin_Screan.dart';

class WelcomeScrean extends StatelessWidget {
  static const String ScreanRoute = 'WelcomeScrean';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              children: [
                SizedBox(
                    height: 180,
                    child: Image.asset('images/HealthyreminderLogo.png')),
                const Text(
                  "Healthy Reminder",
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                      color: Colors.black),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Material(
                elevation: 5,
                color: Colors.yellow[800],
                borderRadius: BorderRadius.circular(10),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Sginin_Screan.ScreeanRoute);
                  },
                  minWidth: 200,
                  height: 42,
                  child: const Text(
                    "Sign in",
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Material(
                elevation: 5,
                color: Colors.blue[600],
                borderRadius: BorderRadius.circular(10),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Register_Screan.ScreanRoute);
                  },
                  minWidth: 200,
                  height: 42,
                  child: const Text(
                    "Register",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
