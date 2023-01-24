import 'package:healthreminder1/WaterSection/models/Water.dart';
import 'package:healthreminder1/models/chartData.dart';

class WaterSection {
  dynamic TotalWaterPortion = 0;
  dynamic WaterTarget = 1500;
  List<Water> UserWaterList = [];
  List<dynamic> UserWaterListDates = [];
  List<dynamic> UserWaterListAmount = [];

  DateTime WaterListDate = DateTime.now();
  int WaterdayTargetMultiplyer = 1;
  dynamic chartWaterTarget = 1500;
  List<chartData> WaterChart = [
    chartData(' Total Water\n Consumpstion', 0),
  ];

  List<Water> WaterList = [
    Water(200, DateTime.now().toString()),
    Water(330, DateTime.now().toString()),
    Water(550, DateTime.now().toString()),
    Water(700, DateTime.now().toString()),
    Water(750, DateTime.now().toString()),
    Water(1500, DateTime.now().toString()),
  ];
}
