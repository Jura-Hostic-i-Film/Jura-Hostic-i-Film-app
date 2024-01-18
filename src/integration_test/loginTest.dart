import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:jura_hostic_i_film_app/app/auth/LoginScreen.dart';
import 'package:jura_hostic_i_film_app/app/main/HomeScreen.dart';
import 'package:jura_hostic_i_film_app/components/buttons/AsyncButton.dart';
import 'package:jura_hostic_i_film_app/main.dart' as app;

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  group(
    '# admin uspješan login i logout',
    () {
      testWidgets(
        '@ kad valjani podaci za prijavu navigiraj na home screen',
        (tester) async {
          app.main(["test_reset"]);
          await tester.pumpAndSettle();

          await Future.delayed(const Duration(seconds: 4));
          await tester.enterText(find.byType(TextField).at(0), 'admin');
          await Future.delayed(const Duration(seconds: 2));
          await tester.enterText(find.byType(TextField).at(1), 'admin');
          await Future.delayed(const Duration(seconds: 2));
          await tester.tap(find.byType(AsyncButton));
          await Future.delayed(const Duration(seconds: 4));
          await tester.pumpAndSettle();

          expect(find.byType(HomeScreen), findsOneWidget);
        },
      );
      testWidgets(
        '@ kad ulogiran izlogiraj se i vrati na login screen',
        (tester) async {
          app.main([]);
          tester.pumpAndSettle();

          await Future.delayed(const Duration(seconds: 4));
          await tester.tap(find.byKey(const Key('navigationIconKey')));
          await Future.delayed(const Duration(seconds: 2));
          await tester.pumpAndSettle();
          await Future.delayed(const Duration(seconds: 2));
          await tester.tap(find.byType(InkWell).last);
          await Future.delayed(const Duration(seconds: 2));
          await tester.pumpAndSettle();

          expect(find.byType(LoginScreen), findsOneWidget);
        },
      );
    },
  );

  group(
    "# admin neuspješan login",
    () {
      testWidgets(
        '@ kad nevaljani podaci za prijavu ostani na login screen',
        (tester) async {
          app.main(["test_reset"]);
          await tester.pumpAndSettle();

          await Future.delayed(const Duration(seconds: 4));
          await tester.enterText(find.byType(TextField).at(0), 'admin');
          await Future.delayed(const Duration(seconds: 2));
          await tester.enterText(find.byType(TextField).at(1), 'neadmin');
          await Future.delayed(const Duration(seconds: 2));
          await tester.tap(find.byType(AsyncButton));
          await Future.delayed(const Duration(seconds: 4));

          expect(find.byType(LoginScreen), findsOneWidget);
        },
      );
    },
  );
}
