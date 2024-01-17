import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:jura_hostic_i_film_app/app/docs/RevisionCreationScreen.dart';
import 'package:jura_hostic_i_film_app/app/main/HomeScreen.dart';
import 'package:jura_hostic_i_film_app/app/main/tabs/RevisionScreen.dart';
import 'package:jura_hostic_i_film_app/components/buttons/AsyncButton.dart';
import 'package:jura_hostic_i_film_app/main.dart' as app;

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  group(
    '# revizor revidiranje dokumenta',
        () {
      testWidgets(
        '@ kad valjani podaci navigiraj na home screen',
            (tester) async {
          app.main(["test_reset"]);
          await tester.pumpAndSettle();

          await Future.delayed(const Duration(seconds: 4));
          await tester.enterText(find.byType(TextField).at(0), 'revizor1');
          await Future.delayed(const Duration(seconds: 2));
          await tester.enterText(find.byType(TextField).at(1), 'revizor1');
          await Future.delayed(const Duration(seconds: 2));
          await tester.tap(find.byType(AsyncButton));
          await Future.delayed(const Duration(seconds: 4));
          await tester.pumpAndSettle();

          expect(find.byType(HomeScreen), findsOneWidget);
        },
      );
      testWidgets(
        '@ kad ulogiran navigiraj na revision screen, ako postoji dokument za reviziju navigiraj na revision creation screen i revidiraj',
            (tester) async {
          app.main([]);
          tester.pumpAndSettle();

          await Future.delayed(const Duration(seconds: 4));
          await tester.tap(find.byKey(const Key('navigationIconKey')));
          await Future.delayed(const Duration(seconds: 2));
          await tester.pumpAndSettle();
          await Future.delayed(const Duration(seconds: 2));
          await tester.tap(find.byKey(const Key('/home/revision')));
          await Future.delayed(const Duration(seconds: 2));
          await tester.pumpAndSettle();

          expect(find.byType(RevisionScreen), findsOneWidget);

          try {
            await Future.delayed(const Duration(seconds: 2));
            await tester.tap(find
                .byKey(const Key('reviseButtonKey'))
                .first);
            await Future.delayed(const Duration(seconds: 2));
            await tester.pumpAndSettle();

            expect(find.byType(RevisionCreationScreen), findsOneWidget);

            await tester.tap(find.byType(AsyncButton));
            await tester.pumpAndSettle();
            await Future.delayed(const Duration(seconds: 4));

            expect(
              find.byKey(const Key('successMessageKey')),
              findsOneWidget,
            );

            await Future.delayed(const Duration(seconds: 2));
            await tester.tap(find.byKey(const Key('closeDialogButtonKey')));
            await Future.delayed(const Duration(seconds: 4));
            expect(find.byType(RevisionScreen), findsOneWidget);
          } catch (exception) {
            expect(find.byType(RevisionScreen), findsOneWidget);
          }
        },
      );
      testWidgets(
        '@ kad ulogiran navigiraj na revision screen i pregledaj revizije',
            (tester) async {
          app.main([]);
          tester.pumpAndSettle();

          await Future.delayed(const Duration(seconds: 4));
          await tester.tap(find.byKey(const Key('navigationIconKey')));
          await Future.delayed(const Duration(seconds: 2));
          await tester.pumpAndSettle();
          await Future.delayed(const Duration(seconds: 2));
          await tester.tap(find.byKey(const Key('/home/revision')));
          await Future.delayed(const Duration(seconds: 2));
          await tester.pumpAndSettle();
          await Future.delayed(const Duration(seconds: 2));
          await tester.tap(find.widgetWithText(RawGestureDetector, 'Revidirani'));
          await Future.delayed(const Duration(seconds: 4));

          expect(find.byType(RevisionScreen), findsOneWidget);
        },
      );
    },
  );
}
