import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:jura_hostic_i_film_app/app/docs/ArchiveCreationScreen.dart';
import 'package:jura_hostic_i_film_app/app/main/HomeScreen.dart';
import 'package:jura_hostic_i_film_app/app/main/tabs/ArchiveScreen.dart';
import 'package:jura_hostic_i_film_app/components/buttons/AsyncButton.dart';
import 'package:jura_hostic_i_film_app/main.dart' as app;

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  group(
    '# računovođa arhiviranje dokumenta',
        () {
      testWidgets(
        '@ kad valjani podaci navigiraj na home screen',
            (tester) async {
          app.main(["test_reset"]);
          await tester.pumpAndSettle();

          await Future.delayed(const Duration(seconds: 4));
          await tester.enterText(find.byType(TextField).at(0), 'racunovoda1');
          await Future.delayed(const Duration(seconds: 2));
          await tester.enterText(find.byType(TextField).at(1), 'racunovoda1');
          await Future.delayed(const Duration(seconds: 2));
          await tester.tap(find.byType(AsyncButton));
          await Future.delayed(const Duration(seconds: 4));
          await tester.pumpAndSettle();

          expect(find.byType(HomeScreen), findsOneWidget);
        },
      );
      testWidgets(
        '@ kad ulogiran navigiraj na archive screen, ako postoji dokument za arhiviranje navigiraj na archive creation screen i arhiviraj',
            (tester) async {
          app.main([]);
          tester.pumpAndSettle();

          await Future.delayed(const Duration(seconds: 4));
          await tester.tap(find.byKey(const Key('navigationIconKey')));
          await Future.delayed(const Duration(seconds: 2));
          await tester.pumpAndSettle();
          await Future.delayed(const Duration(seconds: 2));
          await tester.tap(find.byKey(const Key('/home/archive')));
          await Future.delayed(const Duration(seconds: 2));
          await tester.pumpAndSettle();

          expect(find.byType(ArchiveScreen), findsOneWidget);

          try {
            await Future.delayed(const Duration(seconds: 2));
            await tester.tap(find
                .byKey(const Key('archiveButtonKey'))
                .first);
            await Future.delayed(const Duration(seconds: 2));
            await tester.pumpAndSettle();

            expect(find.byType(ArchiveCreationScreen), findsOneWidget);

            await tester.tap(find.byType(AsyncButton).last);
            await tester.pumpAndSettle();
            await Future.delayed(const Duration(seconds: 4));

            expect(
              find.byKey(const Key('successMessageKey')),
              findsOneWidget,
            );

            await Future.delayed(const Duration(seconds: 2));
            await tester.tap(find.byKey(const Key('closeDialogButtonKey')));
            await Future.delayed(const Duration(seconds: 4));
            expect(find.byType(ArchiveScreen), findsOneWidget);
          } catch (exception) {
            expect(find.byType(ArchiveScreen), findsOneWidget);
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
          await tester.tap(find.byKey(const Key('/home/archive')));
          await Future.delayed(const Duration(seconds: 2));
          await tester.pumpAndSettle();
          await Future.delayed(const Duration(seconds: 2));
          await tester.tap(find.widgetWithText(RawGestureDetector, 'Arhivirani'));
          await Future.delayed(const Duration(seconds: 4));

          expect(find.byType(ArchiveScreen), findsOneWidget);
        },
      );
    },
  );
}
