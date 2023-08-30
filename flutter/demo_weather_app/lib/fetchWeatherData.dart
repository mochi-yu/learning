import 'dart:convert';
import 'package:http/http.dart' as http;
import './weatherData.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

const String apiRoute = "https://api.openweathermap.org/data/2.5/weather";
const String cityId = "1851368";    // Suwa, Nagano
String appId  = "";


Future<WeatherData> fetchWeatherData() async {
  await dotenv.load(fileName: '.env');
  appId = dotenv.get('API_KEY');
  final res = await http.get(Uri.parse('$apiRoute?id=$cityId&appid=$appId&lang=ja'));

  if (res.statusCode == 200) {
    return WeatherData.fromJson(jsonDecode(res.body));
  } else {
    throw Exception('Failed to Load Weather.');
  }
}