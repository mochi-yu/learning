class WeatherData {
  String weather;   // 現在天気
  String weatherDescription;  // 天気の詳細
  double temp;      // 現在気温 
  double minTemp;   // ここまでの最低気温
  double maxTemp;   // ここまでの最高気温
  int    pressure;  // 現在気圧
  int    humidity;  // 現在湿度
  double windSpeed; // 風速
  int    clouds;    // 雲量

  WeatherData({
    this.weather = 'Weather',
    this.weatherDescription = "WeatherDescription",
    this.temp = 100.0,
    this.minTemp = 100.0,
    this.maxTemp = 100.0,
    this.pressure = 0,
    this.humidity = 200,
    this.windSpeed = 100.0,
    this.clouds = 100,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      weather: json['weather'][0]['main'],
      weatherDescription: json['weather'][0]['description'],
      temp: json['main']['temp'],
      maxTemp: json['main']['temp_max'],
      minTemp: json['main']['temp_min'],
      pressure: json['main']['pressure'],
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'],
      clouds: json['clouds']['all'],
    );
  }
}