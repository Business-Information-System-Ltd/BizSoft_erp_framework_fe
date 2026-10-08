import 'package:bizsoft_frontend_framework/app/bs_app.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  testWidgets('BizSoft app shell builds', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: BsApp()));
    await tester.pump();

    expect(find.text('BizSoft ERP'), findsWidgets);
  });
}
