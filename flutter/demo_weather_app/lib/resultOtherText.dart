import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'weatherDataNotifier.dart';

class ResultOtherText extends StatefulWidget {
  const ResultOtherText({Key? key}) : super(key: key);

  @override
  createState() => _ResultOtherText();
}

class _ResultOtherText extends State<ResultOtherText> {
  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherDataNotifier>(
      builder: (context, weather, _) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('気圧：${weather.getWeather.pressure}hPa'),
            Text('湿度：${weather.getWeather.humidity.toStringAsFixed(2)}％'),
            Text('風速：${weather.getWeather.windSpeed}m/s'),
            Text('雲量：${weather.getWeather.clouds}％'),
          ]
        )
      )
    );
  }
}