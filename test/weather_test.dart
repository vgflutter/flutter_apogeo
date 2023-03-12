import 'dart:convert';
import 'package:demo_meteo/models/weather.dart';
import 'package:test/test.dart';

void main() {
  test('Weather class initialization', () {
    Map t = jsonDecode(
        '{"temperature": 11.5,"windspeed": 8.7,"winddirection": 336.0,"weathercode": 0,"time": "2023-01-22T00:00"}');
    Weather w = Weather(
        time: t['time'],
        code: t['weathercode'],
        codeIcon: Weather.iconFromCode(t['weathercode']),
        temperatureMin: t['temperature_2m_min'],
        temperatureMax: t['temperature_2m_max'],
        windspeed: t['windspeed'],
        winddirection: Weather.convertDirection(t['winddirection'].toDouble()));

    expect(w.windspeed, 8.7);
  });

  test('Weather class initialization by factory', () {
    String t =
        '{"temperature": 11.5,"windspeed": 8.7,"winddirection": 336.0,"weathercode": 0,"time": "2023-01-22T00:00"}';
    Weather w = Weather.fromJson(jsonDecode(t));

    expect(w.code, 0);
  });
  test('Weather convertDirection method', () {
    String w = Weather.convertDirection(337);

    expect(w, 'North');
  });

  test('Weather iconFromCode method', () {
    int t = Weather.iconFromCode(48);

    expect(t, 0xe820);
  });
  group('Weather static methods', () {
    test('Weather convertDirection method', () {
      String w = Weather.convertDirection(337);

      expect(w, 'North');
    });

    test('Weather iconFromCode method', () {
      int t = Weather.iconFromCode(48);

      expect(t, 0xe820);
    });
  });
}
