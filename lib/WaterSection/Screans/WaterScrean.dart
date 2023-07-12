import 'package:flutter/material.dart';
import 'package:healthreminder1/fuction/notification_service.dart';

import 'package:healthreminder1/userData/Data.dart';
import 'package:provider/provider.dart';

import '../UserWaterList.dart';
import '../WaterDigram.dart';

class WaterSection extends StatefulWidget {
  const WaterSection({Key? key}) : super(key: key);

  @override
  State<WaterSection> createState() => _WaterSectionState();
}

class _WaterSectionState extends State<WaterSection> {
  @override
  void initState() {
    Provider.of<Data>(context, listen: false).getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          elevation: 5,
          width: MediaQuery.of(context).size.width * 0.64,
          backgroundColor: Color(0xff7B8FA1),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text("Hi"),
                accountEmail: Text(
                  '${Provider.of<Data>(context).User.getSingedInUser.currentUser!.email}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                ),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Sgin out'),
                onTap: () => Provider.of<Data>(context, listen: false)
                    .userLogout(context),
              )
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          centerTitle: true,
          title: Row(
            children: [
              const SizedBox(
                width: 15,
              ),
              Icon(Icons.water_drop_outlined),
              const SizedBox(
                width: 15,
              ),
              const Text(
                'Water Section',
                style: TextStyle(color: Colors.white70),
              )
            ],
          ),
        ),
        backgroundColor: const Color(0xff7B8FA1),
        body: SizedBox(
          height: 1000,
          width: 1000,
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: WaterDigram(),
                  ),
                  const UserWaterList(),
                ],
              ),
            ),
          ),
        ));
  }
}
