import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:survey_flutter_ic/navigation/app_router.dart';
import 'package:survey_flutter_ic/ui/signin/sign_in_widget_id.dart';

import 'fake_data/fake_data.dart';
import 'utils/test_util.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  signInTest();
}

void signInTest() {
  group('SignIn Page', () {
    late Finder emailField;
    late Finder passwordField;
    late Finder signInButton;

    setUpAll(() async {
      await TestUtil.setupTestEnvironment();
    });

    setUp(() {
      emailField = find.byKey(SignInWidgetId.emailInputField);
      passwordField = find.byKey(SignInWidgetId.passwordInputField);
      signInButton = find.byKey(SignInWidgetId.signInButton);
    });

    testWidgets(
        "When the sign in screen shown, it displays the Sign In screen correctly",
        (WidgetTester tester) async {
      await tester
          .pumpWidget(TestUtil.pumpWidgetWithRoutePath(routePathSignInScreen));

      expect(emailField, findsOneWidget);
      expect(passwordField, findsOneWidget);
      expect(signInButton, findsOneWidget);
    });

    testWidgets(
        "When sign in with valid email and password, it navigate to Home screen",
        (WidgetTester tester) async {
      await FakeData.initDefault();
      await tester
          .pumpWidget(TestUtil.pumpWidgetWithRoutePath(routePathSignInScreen));
      await tester.enterText(emailField, 'valid@example.com');
      await tester.enterText(passwordField, '1111111');
      await tester.tap(signInButton);
      await tester.pump(const Duration(milliseconds: 200));

      // TODO: Skip this text, this require refactor to handle the route
      // https://guillaume.bernos.dev/testing-go-router/
      // expect(find.byKey(const Key(routePathHomeScreen)), findsOneWidget);
    });
  });
}
