// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:weather/models/weather_model.dart';
import 'package:weather/provider/weather_forecast_provider.dart';

abstract class DailyServices {
  static Future<void> getWeatherDetails(
      BuildContext context, String seachString) async {
    print('call api');
    final weatherProvider = context.read<WeatherProvider>();
    weatherProvider.setRefresh(true);
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$seachString&APPID=35f974a83d7227d07a862cb36b7c313c'));
    var jsondata = json.decode(response.body);

    if (jsondata['weather'] != null) {
      WeatherModel newWeather = WeatherModel(
          jsondata['weather'][0]['main'] ?? '',
          jsondata['weather'][0]['description'] ?? '',
          jsondata['main']['temp'] ?? 0,
          jsondata['main']['feels_like'] ?? 0,
          jsondata['main']['temp_min'] ?? 0,
          jsondata['main']['temp_max'] ?? 0,
          jsondata['main']['pressure'] ?? 0,
          jsondata['main']['humidity'] ?? 0,
          jsondata['wind']['speed'] ?? 0,
          jsondata['wind']['deg'] ?? 0,
          jsondata['name'] ?? '');
      final userProvider = context.read<WeatherProvider>();
      userProvider.setWeather(newWeather);
    }
    weatherProvider.setRefresh(false);
  }
}
