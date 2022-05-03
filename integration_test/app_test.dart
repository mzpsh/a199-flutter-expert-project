import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_test/flutter_test.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:integration_test/integration_test.dart';

import 'package:ditonton/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('should be able to show detail page',
        (WidgetTester tester) async {
      // di.init();
      app.main();
      await tester.pumpAndSettle();

      await tester.pump(Duration(seconds: 5));

      // movie poster
      final poster = find.byType(CachedNetworkImage);
      tester.tap(poster);

      await tester.pump(Duration(seconds: 5));

      final overviewText = find.text('Overview');
      expect(overviewText, findsOneWidget);
    });
  });
}
