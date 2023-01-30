import 'package:flutter/material.dart';
import 'package:healthreminder1/SleepSection/Screans/DetailedRecordChart.dart';
import 'package:healthreminder1/userData/Data.dart';
import 'package:provider/provider.dart';

class SleepList extends StatefulWidget {
  const SleepList({Key? key}) : super(key: key);

  @override
  State<SleepList> createState() => _SleepListState();
}

class _SleepListState extends State<SleepList> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.65,
        child: Column(
          children: [
            Flexible(
              child: Provider.of<Data>(context)
                      .sleepsection
                      .getSleepRecords
                      .isEmpty
                  ? Container(
                      child: const Text(
                        'Sorry There is no Sleep Records',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    )
                  : ListView.builder(
                      itemCount: Provider.of<Data>(context, listen: false)
                          .sleepsection
                          .getSleepRecords
                          .length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            color: Colors.white54,
                            elevation: 4,
                            margin: const EdgeInsets.only(
                                top: 8, left: 20, right: 20, bottom: 8),
                            child: ListTile(
                              title: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text('SleepRecord'),
                              ),
                              subtitle: Container(
                                child: Text(
                                    '\t\t\t\t\t${Provider.of<Data>(context, listen: false).getDateFormated(index)} '),
                              ),
                            ),
                          ),
                          onTap: () {
                            Provider.of<Data>(context, listen: false)
                                    .sleepsection
                                    .setSleepRecordsInUse =
                                Provider.of<Data>(context, listen: false)
                                    .sleepsection
                                    .getSleepRecords[index];
                            (Provider.of<Data>(context, listen: false)
                                    .sleepsection
                                    .getChartData[0]
                                    .Duration =
                                Provider.of<Data>(context, listen: false)
                                        .sleepsection
                                        .getSleepRecords[index]
                                        .SleepDuration /
                                    60 /
                                    60);
                            Provider.of<Data>(context, listen: false)
                                    .sleepsection
                                    .getChartData[1]
                                    .Duration =
                                Provider.of<Data>(context, listen: false)
                                    .sleepsection
                                    .getSleepRecordsInUse
                                    .TargetOfDay;

                            Navigator.pushNamed(
                                context, DetailedRecord.ScreanRoute);
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
