import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'weatherDataNotifier.dart';

class ResultTempText extends StatefulWidget {
  const ResultTempText({Key? key}) : super(key: key);

  @override
  createState() => _ResultTempText();
}

class _ResultTempText extends State<ResultTempText> {
  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherDataNotifier>(
      builder: (context, weather, _) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('気温：${weather.getWeather.temp.toStringAsFixed(2)}℃'),
            Text('最高気温：${weather.getWeather.maxTemp.toStringAsFixed(2)}℃'),
            Text('最低気温：${weather.getWeather.minTemp.toStringAsFixed(2)}℃'),
          ],
        )
      )
    );
  }
}