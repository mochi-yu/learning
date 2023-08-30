import 'package:demo_weather_app/weatherData.dart';
import 'package:flutter/foundation.dart';
import 'fetchWeatherData.dart';

class WeatherDataNotifier extends ChangeNotifier {
  WeatherData _weather = WeatherData();

  // getter
  WeatherData get getWeather => _weather;

  void updateWeather() async {
    _weather = await fetchWeatherData();
    print("weather updated!");
    notifyListeners();
  }
}