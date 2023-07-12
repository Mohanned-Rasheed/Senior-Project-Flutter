import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthreminder1/WaterSection/models/Water.dart';
import 'package:healthreminder1/models/chartData.dart';

class WaterSection {
  dynamic _TotalWaterPortion = 0;
  int _WaterTarget = 1500;
  List<Water> _UserWaterList = [];
  List<dynamic> _UserWaterListDates = [];
  List<dynamic> _UserWaterListAmount = [];
  DateTime _WaterListDate = DateTime.now();
  int _WaterdayTargetMultiplyer = 1;
  dynamic _chartWaterTarget = 1500;
  List<chartData> _WaterChart = [
    chartData(' Total Water\n Consumpstion', 0),
  ];

  List<Water> _WaterList = [
    Water(200, DateTime.now().toString()),
    Water(330, DateTime.now().toString()),
    Water(550, DateTime.now().toString()),
    Water(700, DateTime.now().toString()),
    Water(750, DateTime.now().toString()),
    Water(1500, DateTime.now().toString()),
  ];

  void sginOut() {
    _TotalWaterPortion = 0;
    _WaterTarget = 1500;

    _UserWaterList = [];
    _UserWaterListDates = [];
    _UserWaterListAmount = [];
    _WaterListDate = DateTime.now();
    _WaterdayTargetMultiplyer = 1;
    _chartWaterTarget = 1500;
    _WaterChart = [
      chartData(' Total Water\n Consumpstion', 0),
    ];
  }

  void AddWater(Water newWater, String email) {
    _TotalWaterPortion = _TotalWaterPortion + newWater.getAmount;
    _UserWaterList.add(newWater);
    _WaterChart[0].setValue = _TotalWaterPortion;
    _UserWaterListDates.add(newWater.getDate);
    _UserWaterListAmount.add(newWater.getAmount);
    UpdateWaterData(email);
    WaterChartKepUpDate();
  }

  void DeleteWater(Water newWater, String email) {
    _TotalWaterPortion = _TotalWaterPortion - newWater.getAmount;
    _UserWaterList.remove(newWater);
    _WaterChart[0].setValue = _TotalWaterPortion;
    _UserWaterListDates.remove(newWater.getDate);
    _UserWaterListAmount.remove(newWater.getAmount);
    UpdateWaterData(email);
    WaterChartKepUpDate();
  }

  void changeWaterListDate(DateTime newListDate) {
    setWaterListDate = newListDate;
  }

  void newWaterChart(int newWaterChart) {
    getWaterChart[0].setValue = newWaterChart;
  }

  void SelectWaterDay(DateTime newDate, int newDayMultiplier) {
    changeWaterListDate(newDate);
    setWaterdayTargetMultiplyer = newDayMultiplier;
    setChartWaterTarget = getWaterTarget * getWaterdayTargetMultiplyer;
    WaterChartKepUpDate();
  }

  void UpdateWaterData(String email) {
    final docUser = FirebaseFirestore.instance
        .collection('Users')
        .doc(email)
        .collection("Data");
    docUser.doc('WaterData').update({
      'TotalWaterPortion': getTotalWaterPortion,
      'WaterTarget': getWaterTarget,
      'DatesUserWaterList': getUserWaterListDates,
      'UserWaterListAmount': getUserWaterListAmount,
    });
  }

  void UpdateWaterTarget(dynamic NewTarget, String email) {
    setWaterTarget = int.parse(NewTarget);
    setChartWaterTarget = getWaterTarget;
    UpdateWaterData(email);
  }

  void WaterChartKepUpDate() {
    int tempTotalWater = 0;
    for (var i = 0; i < getUserWaterList.length; i++) {
      if (DateTime.parse(getUserWaterList[i].getDate)
              .isAfter(getWaterListDate) ||
          getWaterListDate.day ==
              DateTime.parse(getUserWaterList[i].getDate).day) {
        tempTotalWater = tempTotalWater + getUserWaterList[i].getAmount as int;
      }
    }

    newWaterChart(tempTotalWater);
  }

  void WaterChartKepUpDateAtFirst() async {
    await Future.delayed(const Duration(milliseconds: 10));

    int tempTotalWater = 0;
    for (var i = 0; i < getUserWaterList.length; i++) {
      if (getWaterListDate.day <=
          DateTime.parse(getUserWaterList[i].getDate).day) {
        tempTotalWater = tempTotalWater + getUserWaterList[i].getAmount as int;
      }
    }

    newWaterChart(tempTotalWater);
  }

  dynamic get getTotalWaterPortion => _TotalWaterPortion;

  set setTotalWaterPortion(dynamic TotalWaterPortion) =>
      _TotalWaterPortion = TotalWaterPortion;

  int get getWaterTarget => this._WaterTarget;

  set setWaterTarget(int value) => this._WaterTarget = value;

  List<Water> get getUserWaterList => _UserWaterList;

  set setUserWaterList(List<Water> UserWaterList) =>
      _UserWaterList = UserWaterList;

  get getUserWaterListDates => _UserWaterListDates;

  set setUserWaterListDates(UserWaterListDates) =>
      _UserWaterListDates = UserWaterListDates;

  get getUserWaterListAmount => _UserWaterListAmount;

  set setUserWaterListAmount(UserWaterListAmount) =>
      _UserWaterListAmount = UserWaterListAmount;

  DateTime get getWaterListDate => _WaterListDate;

  set setWaterListDate(DateTime WaterListDate) =>
      _WaterListDate = WaterListDate;

  get getWaterdayTargetMultiplyer => _WaterdayTargetMultiplyer;

  set setWaterdayTargetMultiplyer(WaterdayTargetMultiplyer) =>
      _WaterdayTargetMultiplyer = WaterdayTargetMultiplyer;

  get getChartWaterTarget => _chartWaterTarget;

  set setChartWaterTarget(chartWaterTarget) =>
      _chartWaterTarget = chartWaterTarget;

  List<chartData> get getWaterChart => _WaterChart;

  set setWaterChart(List<chartData> WaterChart) => _WaterChart = WaterChart;

  List<Water> get getWaterList => _WaterList;

  set setWaterList(List<Water> WaterList) => _WaterList = WaterList;
}
