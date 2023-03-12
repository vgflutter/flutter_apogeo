import 'package:flutter_test/flutter_test.dart';
import 'package:nock/nock.dart';

import 'package:flutter/material.dart';
import 'package:demo_meteo/screens/current_screen.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  setUpAll(nock.init);

  setUp(() {
    nock.cleanAll();
  });

  Position p = Position(
      longitude: -122.406417,
      latitude: 37.785834,
      timestamp: DateTime.now(),
      accuracy: 10,
      altitude: 800,
      heading: 1,
      speed: 10,
      speedAccuracy: 1);

  String domain = 'https://api.open-meteo.com';
  String url =
      '/v1/forecast?latitude=37.785834&longitude=-122.406417&current_weather=true';
  String json =
      '{"latitude":37.78929,"longitude":-122.422,"generationtime_ms":0.2579689025878906,"utc_offset_seconds":0,"timezone":"GMT","timezone_abbreviation":"GMT","elevation":49.0,"current_weather":{"temperature":8.8,"windspeed":32.8,"winddirection":15.0,"weathercode":0,"time":"2023-01-23T11:00"}}';

  testWidgets('CurrentWeather Widget CircularProgressIndicator',
      (tester) async {
    nock(domain).get(url).reply(200, json);

    final widget =
        MaterialApp(home: Scaffold(body: CurrentWeatherView(location: p)));

    await tester.pumpWidget(widget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('CurrentWeather Widget data loaded', (tester) async {
    nock(domain).get(url).reply(200, json);

    final widget =
        MaterialApp(home: Scaffold(body: CurrentWeatherView(location: p)));

    await tester.pumpWidget(widget);
    await tester.pump(const Duration(seconds: 5));
    expect(find.text('Temperature: '), findsOneWidget);
  });
}
