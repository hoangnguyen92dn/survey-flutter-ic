import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:survey_flutter_ic/ui/home/home_screen.dart';

import 'utils/test_util.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Home Page', (WidgetTester tester) async {
    await tester
        .pumpWidget(TestUtil.pumpWidgetWithShellApp(const HomeScreen()));
    await tester.pumpAndSettle();

    expect(find.text('Today'), findsOneWidget);
  });
}
