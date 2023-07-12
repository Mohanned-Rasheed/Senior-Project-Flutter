import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthreminder1/ClassDiagram/PulseSensor.dart';
import 'package:healthreminder1/SleepSection/model/RecordChartData.dart';
import 'package:healthreminder1/SleepSection/model/SleepRecord.dart';

class SleepSection extends PulseSensor {
  late SleepRecord _SleepRecordsInUse;
  dynamic _LastTimeHasBeenChanged = 0;
  List<RecordChartData> _ChartData = [
    RecordChartData('Your Record', 0.0),
    RecordChartData('Your Target', 8.0),
  ];
  void sginOut() {
    super.sginOut();
    List<RecordChartData> _ChartData = [
      RecordChartData('Your Record', 0.0),
      RecordChartData('Your Target', 8.0),
    ];
  }

  get getSleepRecordsInUse => _SleepRecordsInUse;

  set setSleepRecordsInUse(SleepRecordsInUse) =>
      _SleepRecordsInUse = SleepRecordsInUse;

  get getLastTimeHasBeenChanged => _LastTimeHasBeenChanged;

  set setLastTimeHasBeenChanged(LastTimeHasBeenChanged) =>
      _LastTimeHasBeenChanged = LastTimeHasBeenChanged;

  List<RecordChartData> get getChartData => _ChartData;

  set setChartData(List<RecordChartData> ChartData) => _ChartData = ChartData;

  String BedTimeAnalysis() {
    String text = '';
    if (DateTime.parse(getSleepRecordsInUse.getSleepDate)
                .subtract(
                    Duration(seconds: getSleepRecordsInUse.getSleepDuration))
                .hour >=
            18 &&
        DateTime.parse(getSleepRecordsInUse.getSleepDate)
                .subtract(
                    Duration(seconds: getSleepRecordsInUse.getSleepDuration))
                .hour <=
            20) {
      text =
          '•You went to bed between 6pm and 8pm\n it affects the bodys internal clock\n or what is known as circadian rhythm.';
    }
    if (DateTime.parse(getSleepRecordsInUse.getSleepDate)
                .subtract(
                    Duration(seconds: getSleepRecordsInUse.getSleepDuration))
                .hour >=
            20 &&
        DateTime.parse(getSleepRecordsInUse.getSleepDate)
                .subtract(
                    Duration(seconds: getSleepRecordsInUse.getSleepDuration))
                .hour <=
            23) {
      text =
          '•You went to bed between 8pm and 11pm\n and that is the Sweet Spot for Bedtime.';
    }
    if (DateTime.parse(getSleepRecordsInUse.getSleepDate)
                .subtract(
                    Duration(seconds: getSleepRecordsInUse.getSleepDuration))
                .hour >=
            23 &&
        DateTime.parse(getSleepRecordsInUse.getSleepDate)
                .subtract(
                    Duration(seconds: getSleepRecordsInUse.getSleepDuration))
                .hour <=
            01) {
      text =
          '•You went to bed between 11pm and 1am\n try getting to bed early so you can sleep before midnight because it affect your overall wellness when awake .';
    }
    if (DateTime.parse(getSleepRecordsInUse.getSleepDate)
                .subtract(
                    Duration(seconds: getSleepRecordsInUse.getSleepDuration))
                .hour >=
            01 &&
        DateTime.parse(getSleepRecordsInUse.getSleepDate)
                .subtract(
                    Duration(seconds: getSleepRecordsInUse.getSleepDuration))
                .hour <=
            05) {
      text =
          '•You went to bed between 1am and 5am its\n really unhealthy to sleep really late at night because\n you deprive yourself of some of the rejuvenating\n functions that occur during non-REM sleep.';
    }
    if (DateTime.parse(getSleepRecordsInUse.getSleepDate)
                .subtract(
                    Duration(seconds: getSleepRecordsInUse.getSleepDuration))
                .hour >=
            05 &&
        DateTime.parse(getSleepRecordsInUse.getSleepDate)
                .subtract(
                    Duration(seconds: getSleepRecordsInUse.getSleepDuration))
                .hour <=
            17) {
      text =
          '•You went to bed between 5am and 5pm,\n it affects the bodys internal clock\n or what is known as circadian rhythm.';
    }

    return text;
  }

  // String BedTimeAnalysisTest(String i, int x) {
  //   String text = '';
  //   if (DateTime.parse(i).subtract(Duration(seconds: x)).hour >= 18 &&
  //       DateTime.parse(i).subtract(Duration(seconds: x)).hour <= 20) {
  //     text =
  //         '•You went to bed between 6pm and 8pm\n it affects the bodys internal clock\n or what is known as circadian rhythm.';
  //   }
  //   if (DateTime.parse(i).subtract(Duration(seconds: x)).hour >= 20 &&
  //       DateTime.parse(i).subtract(Duration(seconds: x)).hour <= 23) {
  //     text =
  //         '•You went to bed between 8pm and 11pm\n and that is the Sweet Spot for Bedtime.';
  //   }
  //   if (DateTime.parse(i).subtract(Duration(seconds: x)).hour >= 23 &&
  //       DateTime.parse(i).subtract(Duration(seconds: x)).hour <= 01) {
  //     text =
  //         '•You went to bed between 11pm and 1am\n try getting to bed early so you can sleep before midnight because it affect your overall wellness when awake .';
  //   }
  //   if (DateTime.parse(i).subtract(Duration(seconds: x)).hour >= 01 &&
  //       DateTime.parse(i).subtract(Duration(seconds: x)).hour <= 05) {
  //     text =
  //         '•You went to bed between 1am and 5am its\n really unhealthy to sleep really late at night because\n you deprive yourself of some of the rejuvenating\n functions that occur during non-REM sleep.';
  //   }
  //   if (DateTime.parse(i).subtract(Duration(seconds: x)).hour >= 05 &&
  //       DateTime.parse(i).subtract(Duration(seconds: x)).hour <= 17) {
  //     text =
  //         '•You went to bed between 5am and 5pm,\n it affects the bodys internal clock\n or what is known as circadian rhythm.';
  //   }

  //   return text;
  // }

  String getDateFormated(int index) {
    return DateTime.parse(getSleepRecords[index].getSleepDate)
        .subtract(Duration(seconds: getSleepRecords[index].getSleepDuration))
        .toString()
        .substring(0, 16);
  }

  String getDateFormatedDay() {
    return DateTime.parse(getSleepRecordsInUse.getSleepDate)
        .subtract(Duration(seconds: getSleepRecordsInUse.getSleepDuration))
        .toString()
        .substring(0, 10);
  }

  String getDateFormatedhours() {
    return DateTime.parse(getSleepRecordsInUse.getSleepDate)
        .subtract(Duration(seconds: getSleepRecordsInUse.getSleepDuration))
        .toString()
        .substring(11, 16);
  }

  String SleepDurationAnalysis() {
    String text = '';
    if (getSleepRecordsInUse.getSleepDuration / 60 / 60 >= 7 &&
        getSleepRecordsInUse.getSleepDuration / 60 / 60 <= 10) {
      text =
          '• Your Sleep Duration Was Great its between 7 and 10\n Hours and That The Optimal Sleep Duration';
    }
    if (getSleepRecordsInUse.getSleepDuration / 60 / 60 >= 5 &&
        getSleepRecordsInUse.getSleepDuration / 60 / 60 <= 7) {
      text =
          '• Your Sleep Duration Was 4 to 6 hours, it is close\n to optimal but you can make up for it during nap time. ';
    }
    if (getSleepRecordsInUse.getSleepDuration / 60 / 60 >= 3 &&
        getSleepRecordsInUse.getSleepDuration / 60 / 60 <= 5) {
      text =
          '• Your Sleep Duration Was 3 to 5 hours, Sleeping\n 5 hours or fewer every night could put you\n at risk of multiple chronic diseases.';
    }
    if (getSleepRecordsInUse.getSleepDuration / 60 / 60 >= 11 &&
        getSleepRecordsInUse.getSleepDuration / 60 / 60 <= 20) {
      text =
          '• Your Sleep Duration was more than 10 hours,\n Too much sleep on a regular basis can increase \nthe risk of diabetes, heart disease, stroke, and death.';
    }
    if (getSleepRecordsInUse.getSleepDuration / 60 >= 10 &&
        getSleepRecordsInUse.getSleepDuration / 60 <= 20) {
      text = '• You toked power nap thats between 10 to 20 minutes';
    }
    if (getSleepRecordsInUse.getSleepDuration / 60 >= 21 &&
        getSleepRecordsInUse.getSleepDuration / 60 <= 30) {
      text = '• You toked grogginess nap thats between 20 to 30 minutes';
    }
    if (getSleepRecordsInUse.getSleepDuration / 60 >= 31 &&
        getSleepRecordsInUse.getSleepDuration / 60 <= 60) {
      text = '• You toked short-term nap thats between 30 to 60 minutes';
    }
    if (getSleepRecordsInUse.getSleepDuration / 60 >= 61 &&
        getSleepRecordsInUse.getSleepDuration / 60 <= 90) {
      text = '• You toked rem nap thats between 60 to 90 minutes';
    }
    if (getSleepRecordsInUse.getSleepDuration / 60 < 5) {
      text = '• Cant analyze with given duration.';
    }

    return text;
  }

  void UpdateSleepData(String email) {
    final docUser = FirebaseFirestore.instance
        .collection('Users')
        .doc(email)
        .collection("Data");
    docUser.doc('SleepData').update({
      'SleepDurationList': getSleepDurationList,
      'SleepDateList': getSleepDateList,
      'TargetOfDayList': getTargetOfDayList,
      'TargetOfDay': getTargetOfDay,
      'LastTimeHasBeenChanged': getLastTimeHasBeenChanged,
    });
  }

  void AddSleepRecord(SleepRecord SleepRecord, String email) {
    getSleepRecords.add(SleepRecord);
    getSleepDurationList.add(SleepRecord.getSleepDuration);
    getSleepDateList.add(SleepRecord.getSleepDate);
    getTargetOfDayList.add(SleepRecord.getTargetOfDay);
    UpdateSleepData(email);
  }
}
