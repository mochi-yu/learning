import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'weatherDataNotifier.dart';

class ResultMainText extends StatefulWidget {
  const ResultMainText({Key? key}) : super(key: key);

  @override
  createState() => _ResultMainText();
}

class _ResultMainText extends State<ResultMainText> {
  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherDataNotifier>(
      builder: (context, weather, _) => Center(
        child:       Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('天気：${weather.getWeather.weather}'),
            Text('詳細：${weather.getWeather.weatherDescription}'),
          ]
        )
      )
    );
    
    
  }
}