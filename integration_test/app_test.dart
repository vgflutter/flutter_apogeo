import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:demo_meteo/main.dart' as app;

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('failing test example', (tester) async {
    app.main();
    await tester.pump(Duration(seconds: 5));

    await binding.traceAction(
      () async {
        await tester.startGesture(const Offset(0, 100));
      },
      reportKey: 'scrolling_timeline',
    );
  });
}
