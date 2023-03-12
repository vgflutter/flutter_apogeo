import '../models/weather.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../services/open_meteo.dart';

class ForecastWeatherView extends StatefulWidget {
  final Position location;
  const ForecastWeatherView({super.key, required this.location});

  @override
  State<ForecastWeatherView> createState() => _ForecastWeatherViewState();
}

class _ForecastWeatherViewState extends State<ForecastWeatherView> {
  late Future<List<Weather>> futureForecastWeather;
  List<Weather> w = [];

  @override
  void initState() {
    super.initState();
    futureForecastWeather = fetchForecastWeather(
        latitude: widget.location.latitude,
        longitude: widget.location.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: futureForecastWeather,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          debugPrint('Future result: ${snapshot.data}');
          return ListView(
              padding: const EdgeInsets.all(8),
              children: snapshot.data
                  .map<Widget>((Weather i) => Card(
                          child:
                              Column(mainAxisSize: MainAxisSize.max, children: [
                        ListTile(
                          title: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                    IconData(i.codeIcon ?? i.code,
                                        fontFamily: 'MyFlutterApp'),
                                    size: 62),
                                Text(i.time,
                                    style: const TextStyle(
                                        color: Color.fromRGBO(0, 0, 0, 0.8),
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold))
                              ]),
                          subtitle: Column(children: [
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Temperature min: '),
                                Text(
                                  '${i.temperatureMin}°',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Text(' max: '),
                                Text(
                                  '${i.temperatureMax}°',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Wind speed: '),
                                Text(
                                  '${i.windspeed} Km/h',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Wind direction: '),
                                Text(
                                  '${i.winddirection} Km/h',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Text('Location: ${widget.location}')
                          ]),
                        )
                      ])))
                  .toList());
        } else if (snapshot.hasError) {
          return const Text('Error');
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
