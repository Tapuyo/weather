import 'package:flutter/foundation.dart';
import 'package:weather/models/weather_model.dart';

class WeatherProvider with ChangeNotifier {
  bool refresh = false;
  String searchText = '';

  bool get isRefresh => refresh;

  String get searchString => searchText;

  WeatherModel? weather;

  WeatherModel? get weatherForecast => weather;

  void setWeather(WeatherModel value) {
    weather = value;
    notifyListeners();
  }

  void setSearchString(String value) {
    searchText = value;
    notifyListeners();
  }

  void setRefresh(bool value) {
    refresh = value;
    notifyListeners();
  }
}
