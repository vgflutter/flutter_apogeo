class Weather {
  final int code;
  final int? codeIcon;
  final double? temperature;
  final double? temperatureMin;
  final double? temperatureMax;
  final double windspeed;
  final String winddirection;
  final String time;

  const Weather({
    required this.code,
    this.codeIcon,
    this.temperatureMin,
    this.temperatureMax,
    this.temperature,
    required this.windspeed,
    required this.winddirection,
    required this.time,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      code: json['weathercode'],
      codeIcon: iconFromCode(json['weathercode']),
      temperature: json['temperature'],
      temperatureMin: json['temperature_2m_min'],
      temperatureMax: json['temperature_2m_max'],
      windspeed: json['windspeed'] ?? json['windspeed_10m_max'],
      winddirection: convertDirection(
          json['winddirection'] ?? json['winddirection_10m_dominant']),
      time: json['time'],
    );
  }

  static String convertDirection(double direction) {
    if ((direction >= 0 && direction <= 23) ||
        (direction >= 337 && direction <= 360)) {
      return 'North';
    }
    if ((direction >= 24 && direction <= 67)) {
      return 'North-east';
    }
    if ((direction >= 68 && direction <= 113)) {
      return 'East';
    }
    if (direction >= 293 && direction <= 336) {
      return 'Nord-West';
    }
    if ((direction >= 247 && direction <= 292)) {
      return 'West';
    }
    if ((direction >= 157 && direction <= 203)) {
      return 'South';
    }

    if ((direction >= 114 && direction <= 156)) {
      return 'South-east';
    }

    if ((direction >= 204 && direction <= 246)) {
      return 'South-West';
    }
    throw 'Invalid direction';
  }

  static int iconFromCode(int code) {
    if (code >= 0 && code <= 3) {
      return 0xe80e;
    }

    if (code >= 45 && code <= 48) {
      return 0xe820;
    }

    if (code >= 51 && code <= 57) {
      return 0xe812;
    }

    if ((code >= 61 && code <= 67 || code >= 80 && code <= 82)) {
      return 0xe813;
    }
    if ((code >= 71 && code <= 77 || code >= 85 && code <= 86)) {
      return 0xe829;
    }
    if (code >= 61 && code <= 67) {
      return 0xe813;
    }

    if (code >= 95 && code <= 99) {
      return 0xe823;
    }
    throw 'Invalid code';
  }
}
