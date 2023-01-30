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
    _TotalWaterPortion = _TotalWaterPortion + newWater.amount;
    _UserWaterList.add(newWater);
    _WaterChart[0].type = _TotalWaterPortion;
    _UserWaterListDates.add(newWater.date);
    _UserWaterListAmount.add(newWater.amount);
    UpdateWaterData(email);
    WaterChartKepUpDate();
  }

  void DeleteWater(Water newWater, String email) {
    _TotalWaterPortion = _TotalWaterPortion - newWater.amount;
    _UserWaterList.remove(newWater);
    _WaterChart[0].type = _TotalWaterPortion;
    _UserWaterListDates.remove(newWater.date);
    _UserWaterListAmount.remove(newWater.amount);
    UpdateWaterData(email);
    WaterChartKepUpDate();
  }

  void UpdateWaterTarget(dynamic NewTarget, String email) {
    _WaterTarget = NewTarget;
    _chartWaterTarget = _WaterTarget;
    UpdateWaterData(email);
  }

  void UpdateWaterData(String email) {
    final docUser = FirebaseFirestore.instance
        .collection('Users')
        .doc(email)
        .collection("Data");
    docUser.doc('WaterData').update({
      'TotalWaterPortion': _TotalWaterPortion,
      'WaterTarget': _WaterTarget,
      'DatesUserWaterList': _UserWaterListDates,
      'UserWaterListAmount': _UserWaterListAmount,
    });
  }

  void SelectWaterDay(DateTime newDate, int newDayMultiplier) {
    changeWaterListDate(newDate);
    _WaterdayTargetMultiplyer = newDayMultiplier;
    _chartWaterTarget = _WaterTarget * _WaterdayTargetMultiplyer;
    WaterChartKepUpDate();
  }

  void WaterChartKepUpDateAtFirst() async {
    await Future.delayed(Duration(milliseconds: 400));

    int tempTotalWater = 0;
    for (var i = 0; i < _UserWaterList.length; i++) {
      if (_WaterListDate.day <= DateTime.parse(_UserWaterList[i].date).day) {
        tempTotalWater = tempTotalWater + _UserWaterList[i].amount as int;
      }
    }

    newWaterChart(tempTotalWater);
  }

  void WaterChartKepUpDate() {
    int tempTotalWater = 0;
    for (var i = 0; i < _UserWaterList.length; i++) {
      if (_WaterListDate.day <= DateTime.parse(_UserWaterList[i].date).day) {
        tempTotalWater = tempTotalWater + _UserWaterList[i].amount as int;
      }
    }

    newWaterChart(tempTotalWater);
  }

  void newWaterChart(int newWaterChart) {
    _WaterChart[0].type = newWaterChart;
  }

  void changeWaterListDate(DateTime newListDate) {
    _WaterListDate = newListDate;
  }

  dynamic get getTotalWaterPortion => _TotalWaterPortion;

  set setTotalWaterPortion(dynamic TotalWaterPortion) =>
      _TotalWaterPortion = TotalWaterPortion;

  int get getWaterTarget => this._WaterTarget;

  set setWaterTarget(int value) => this._WaterTarget = value;

  get getUserWaterList => _UserWaterList;

  set setUserWaterList(UserWaterList) => _UserWaterList = UserWaterList;

  get getUserWaterListDates => _UserWaterListDates;

  set setUserWaterListDates(UserWaterListDates) =>
      _UserWaterListDates = UserWaterListDates;

  get getUserWaterListAmount => _UserWaterListAmount;

  set setUserWaterListAmount(UserWaterListAmount) =>
      _UserWaterListAmount = UserWaterListAmount;

  get getWaterListDate => _WaterListDate;

  set setWaterListDate(WaterListDate) => _WaterListDate = WaterListDate;

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
