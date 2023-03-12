import 'package:demo_meteo/main.dart';
import 'package:demo_meteo/screens/home_screen.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('CurrentWeather Widget data loaded', (tester) async {
    const widget = MyApp();

    await tester.pumpWidget(widget);
    expect(find.byType(MyHomePage), findsOneWidget);
  });
}
