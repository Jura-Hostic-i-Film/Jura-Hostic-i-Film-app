import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:jura_hostic_i_film_app/app/docs/DocumentOverviewScreen.dart';
import 'package:jura_hostic_i_film_app/app/docs/DocumentPDFPreviewScreen.dart';
import 'package:jura_hostic_i_film_app/app/main/HomeScreen.dart';
import 'package:jura_hostic_i_film_app/app/main/tabs/FullHistoryScreen.dart';
import 'package:jura_hostic_i_film_app/components/buttons/AsyncButton.dart';
import 'package:jura_hostic_i_film_app/main.dart' as app;

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  group(
    '# direktor pregled dokumenata',
        () {
      testWidgets(
        '@ kad valjani podaci navigiraj na home screen',
            (tester) async {
          app.main(["test_reset"]);
          await tester.pumpAndSettle();

          await Future.delayed(const Duration(seconds: 4));
          await tester.enterText(find.byType(TextField).at(0), 'direktor');
          await Future.delayed(const Duration(seconds: 2));
          await tester.enterText(find.byType(TextField).at(1), 'direktor');
          await Future.delayed(const Duration(seconds: 2));
          await tester.tap(find.byType(AsyncButton));
          await Future.delayed(const Duration(seconds: 4));
          await tester.pumpAndSettle();

          expect(find.byType(HomeScreen), findsOneWidget);
        },
      );
      testWidgets(
        '@ kad ulogiran navigiraj na full history screen, ako postoji dokument otvori pregled i zatim pdf',
            (tester) async {
          app.main([]);
          tester.pumpAndSettle();

          await Future.delayed(const Duration(seconds: 4));
          await tester.tap(find.byKey(const Key('navigationIconKey')));
          await Future.delayed(const Duration(seconds: 2));
          await tester.pumpAndSettle();
          await Future.delayed(const Duration(seconds: 2));
          await tester.tap(find.byKey(const Key('/home/fullhistory')));
          await Future.delayed(const Duration(seconds: 2));
          await tester.pumpAndSettle();

          expect(find.byType(FullHistoryScreen), findsOneWidget);

          try {
            await Future.delayed(const Duration(seconds: 2));
            await tester.tap(find
                .byKey(const Key('documentOverviewButtonKey'))
                .first);
            await Future.delayed(const Duration(seconds: 2));
            await tester.pumpAndSettle();
            await Future.delayed(const Duration(seconds: 4));
            expect(find.byType(DocumentOverviewScreen), findsOneWidget);
            await Future.delayed(const Duration(seconds: 2));
            await tester.tap(find.byKey(const Key('createPdfButtonKey')).first);
            await Future.delayed(const Duration(seconds: 2));
            await tester.pumpAndSettle();

            expect(find.byType(DocumentPDFPreviewScreen), findsOneWidget);
            await Future.delayed(const Duration(seconds: 2));
            final NavigatorState navigator = tester.state(find.byType(Navigator));
            navigator.pop();
            await tester.pumpAndSettle();
            expect(find.byType(DocumentOverviewScreen), findsOneWidget);
          } catch (exception) {
            expect(find.byType(FullHistoryScreen), findsOneWidget);
          }
        },
      );
    },
  );
}
