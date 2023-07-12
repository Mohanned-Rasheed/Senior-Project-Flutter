import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthreminder1/Screans/Register_Screan.dart';
import 'package:healthreminder1/models/ShowErrorMessage.dart';

class Sginin_Screan extends StatefulWidget {
  static const String ScreeanRoute = 'Sginin_Screan';

  @override
  State<Sginin_Screan> createState() => _Sginin_ScreanState();
}

class _Sginin_ScreanState extends State<Sginin_Screan> {
  bool showSpinner = false;

  final _auth = FirebaseAuth.instance;

  late String email;

  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sgin in Page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(
                height: 50,
              ),
              Column(
                children: [
                  SizedBox(
                      height: 180,
                      child: Image.asset('images/HealthyreminderLogo.png')),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration: const InputDecoration(
                  fillColor: Colors.black,
                  hintText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  )),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.orange,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.teal,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration: const InputDecoration(
                  fillColor: Colors.black,
                  hintText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  )),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.orange,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.teal,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Material(
                  elevation: 5,
                  color: Colors.yellow[800],
                  borderRadius: BorderRadius.circular(10),
                  child: MaterialButton(
                    onPressed: () async {
                      try {
                        if (email.isEmpty || password.isEmpty) {
                          throw NullThrownError;
                        }
                        final user = await _auth.signInWithEmailAndPassword(
                            email: email, password: password);
                        Navigator.pushNamed(context, 'AllThree');
                      } on FirebaseAuthException catch (Exception) {
                        ShowErrorMessage(
                            context, 'Error', Exception.toString(), 120);
                      } on NullThrownError catch (Exception) {
                        ShowErrorMessage(
                            context, 'Error', Exception.toString(), 120);
                      } catch (e) {
                        ShowErrorMessage(context, 'Error', e.toString(), 120);
                      }
                    },
                    minWidth: 200,
                    height: 42,
                    child: const Text(
                      "Sgin in",
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('No account?'),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(
                            context, Register_Screan.ScreanRoute);
                      },
                      child: Text(
                        "Create one!",
                        style: TextStyle(color: Colors.amber[800]),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
