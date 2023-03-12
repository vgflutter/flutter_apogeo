import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'current_screen.dart';
import 'forecast_screen.dart';
import '../services/get_position.dart';
import '../icons/my_flutter_app_icons.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  late Future<Position> _position;

  Widget _onWidgetTapped(Position data) {
    if (_selectedIndex == 0) {
      return CurrentWeatherView(location: data);
    } else {
      return ForecastWeatherView(location: data);
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _position = determinePosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: FutureBuilder<Position>(
              future: _position,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  return _onWidgetTapped(snapshot.data);
                } else {
                  return const Text('waiting location..');
                }
              })),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(MyFlutterApp.sun),
            label: 'Weather',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Days',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
