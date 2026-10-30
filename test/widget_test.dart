import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/constants/cv_data.dart';

void main() {
  testWidgets('Portfolio loads and displays developer name', (WidgetTester tester) async {
    await tester.pumpWidget(const PortfolioApp());
    await tester.pump();

    // Verify developer name is present in tree
    expect(find.text(CVData.name), findsWidgets);
  });
}
