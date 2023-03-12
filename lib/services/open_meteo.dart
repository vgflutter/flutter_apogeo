import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/weather.dart';

Future<Weather> fetchCurrentWeather(
    {required double latitude, required double longitude}) async {
  Uri url = Uri.parse(
      'https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&current_weather=true');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    return Weather.fromJson(jsonDecode(response.body)['current_weather']);
  } else {
    throw Exception('Failed to load weather');
  }
}

Future<List<Weather>> fetchForecastWeather(
    {required double latitude, required double longitude}) async {
  List<Weather> w = [];
  Uri url = Uri.parse(
      'https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&daily=temperature_2m_max,temperature_2m_min,weathercode,winddirection_10m_dominant,windspeed_10m_max&timezone=GMT');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    var j = jsonDecode(response.body);
    for (int i = 0; i < j['daily']['time'].length; i++) {
      w.add(Weather(
          time: j['daily']['time'][i],
          code: j['daily']['weathercode'][i],
          codeIcon: Weather.iconFromCode(j['daily']['weathercode'][i]),
          temperatureMin: j['daily']['temperature_2m_min'][i],
          temperatureMax: j['daily']['temperature_2m_max'][i],
          windspeed: j['daily']['windspeed_10m_max'][i],
          winddirection: Weather.convertDirection(
              j['daily']['winddirection_10m_dominant'][i].toDouble())));
    }
    return w;
  } else {
    throw Exception('Failed to load items');
  }
}
