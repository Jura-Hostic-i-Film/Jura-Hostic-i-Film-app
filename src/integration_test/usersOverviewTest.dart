import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:jura_hostic_i_film_app/app/main/HomeScreen.dart';
import 'package:jura_hostic_i_film_app/app/main/Tabs/UsersScreen.dart';
import 'package:jura_hostic_i_film_app/components/buttons/AsyncButton.dart';
import 'package:jura_hostic_i_film_app/main.dart' as app;

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  group(
    '# direktor pregled korisnika',
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
        '@ kad ulogiran navigiraj na users screen, ako postoji korisnik otvori statistiku',
            (tester) async {
          app.main([]);
          tester.pumpAndSettle();

          await Future.delayed(const Duration(seconds: 4));
          await tester.tap(find.byKey(const Key('navigationIconKey')));
          await Future.delayed(const Duration(seconds: 2));
          await tester.pumpAndSettle();
          await Future.delayed(const Duration(seconds: 2));
          await tester.tap(find.byKey(const Key('/home/users')));
          await Future.delayed(const Duration(seconds: 2));
          await tester.pumpAndSettle();

          expect(find.byType(UsersScreen), findsOneWidget);

          try {
            await Future.delayed(const Duration(seconds: 2));
            await tester.tap(find
                .byKey(const Key('openStatisticsButtonKey'))
                .first);
            await Future.delayed(const Duration(seconds: 2));
            await tester.pumpAndSettle();
            await Future.delayed(const Duration(seconds: 4));

            expect(
              find.byKey(const Key('successMessageKey')),
              findsOneWidget,
            );

            await Future.delayed(const Duration(seconds: 2));
            await tester.tap(find.byKey(const Key('closeDialogButtonKey')));
            await Future.delayed(const Duration(seconds: 4));
            expect(find.byType(UsersScreen), findsOneWidget);
          } catch (exception) {
            expect(find.byType(UsersScreen), findsOneWidget);
          }
        },
      );
    },
  );
}
