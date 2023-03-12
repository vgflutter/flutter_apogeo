import '../services/open_meteo.dart';
import '../models/weather.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class CurrentWeatherView extends StatefulWidget {
  final Position location;
  const CurrentWeatherView({super.key, required this.location});

  @override
  State<CurrentWeatherView> createState() => _CurrentWeatherViewState();
}

class _CurrentWeatherViewState extends State<CurrentWeatherView> {
  late Future<Weather> _futureCurrentWeather;

  @override
  void initState() {
    super.initState();
    _futureCurrentWeather = fetchCurrentWeather(
        latitude: widget.location.latitude,
        longitude: widget.location.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: _futureCurrentWeather,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return Card(
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            ListTile(
              title: Icon(
                  IconData(snapshot.data.codeIcon, fontFamily: 'MyFlutterApp'),
                  size: 62),
              subtitle: Column(children: [
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Temperature: '),
                    Text(
                      '${snapshot.data.temperature}°',
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Wind speed: '),
                    Text(
                      '${snapshot.data.windspeed} Km/h',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Wind direction: '),
                    Text(
                      '${snapshot.data.winddirection}',
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Text('Time: ${snapshot.data.time}'),
                Text('GPS Lat: ${widget.location.latitude}'),
                Text('GPS Long: ${widget.location.longitude}'),
              ]),
            )
          ]));
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error.toString()}');
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
