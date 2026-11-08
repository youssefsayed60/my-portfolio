import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/constants/cv_data.dart';
import 'package:portfolio/models/skill_model.dart';
import 'package:portfolio/sections/experience_section.dart';
import 'package:portfolio/sections/projects_section.dart';
import 'package:portfolio/sections/skills_section.dart';

void main() {
  testWidgets('Hero section loads immediately on initial build', (WidgetTester tester) async {
    await tester.pumpWidget(const PortfolioApp());
    await tester.pump();

    // Verify developer name is present in tree immediately
    expect(find.text(CVData.name), findsWidgets);
    expect(find.text('Hello, World! I am'), findsOneWidget);
    expect(find.text('Explore Projects'), findsOneWidget);
    expect(find.text('Get In Touch'), findsWidgets);

    // Initial state: subsequent heavy sections are deferred until scroll
    expect(find.byType(ExperienceSection), findsNothing);
    expect(find.byType(ProjectsSection), findsNothing);
  });

  testWidgets('Subsequent sections hydrate seamlessly when scrolling', (WidgetTester tester) async {
    await tester.pumpWidget(const PortfolioApp());
    await tester.pump();

    // Scroll down to trigger progressive hydration
    final scrollable = find.byType(SingleChildScrollView);
    expect(scrollable, findsOneWidget);

    await tester.drag(scrollable, const Offset(0, -900));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    // Experience section should now be mounted
    expect(find.byType(ExperienceSection), findsOneWidget);
  });

  testWidgets('Mobile viewport renders Skills section and Project details modal without overflow', (WidgetTester tester) async {
    // Set standard mobile phone screen size (390 x 844)
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(const PortfolioApp());
    await tester.pump();

    final mainScrollable = find.byType(Scrollable).first;

    // Scroll until skills are visible
    await tester.scrollUntilVisible(
      find.text('Clean Architecture & MVVM'),
      300,
      scrollable: mainScrollable,
    );
    await tester.pumpAndSettle();

    // Verify Skills section is rendered cleanly with full text
    expect(find.byType(SkillsSection), findsOneWidget);
    expect(find.text('Clean Architecture & MVVM'), findsOneWidget);
    expect(find.text('Flutter & Dart'), findsOneWidget);

    // Scroll until project details button is visible
    final detailsBtn = find.text('Explore Architecture').first;
    await tester.scrollUntilVisible(
      detailsBtn,
      300,
      scrollable: mainScrollable,
    );
    await tester.pumpAndSettle();

    // Tap "Explore Architecture" to open modal dialog
    await tester.tap(detailsBtn);
    await tester.pumpAndSettle();

    // Verify modal dialog opened without RenderFlex overflow
    expect(find.text('Project Overview'), findsOneWidget);
  });

  testWidgets('Small mobile viewport (320px) renders without overflow errors', (WidgetTester tester) async {
    // Set small mobile screen size (320 x 600)
    tester.view.physicalSize = const Size(320, 600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(const PortfolioApp());
    await tester.pump();

    expect(find.text(CVData.name), findsWidgets);

    // Scroll down to experience
    final scrollable = find.byType(SingleChildScrollView);
    await tester.drag(scrollable, const Offset(0, -500));
    await tester.pumpAndSettle();

    expect(find.byType(ExperienceSection), findsOneWidget);
  });

  testWidgets('Tablet viewport (800x1200) and Desktop (1920x1080) render without errors', (WidgetTester tester) async {
    // Tablet
    tester.view.physicalSize = const Size(800, 1200);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(const PortfolioApp());
    await tester.pump();
    expect(find.text(CVData.name), findsWidgets);
  });

  testWidgets('Skills cards target official websites or Google search URLs', (WidgetTester tester) async {
    final flutterSkill = CVData.skills.firstWhere((s) => s.name == 'Flutter & Dart');
    expect(flutterSkill.targetUrl, 'https://flutter.dev');

    final cleanArchSkill = CVData.skills.firstWhere((s) => s.name == 'Clean Architecture & MVVM');
    expect(cleanArchSkill.targetUrl, contains('google.com/search?q='));

    const testSkill = SkillItem(
      name: 'Custom Skill',
      description: 'Desc',
      icon: Icons.code,
      category: SkillCategory.programming,
    );
    expect(testSkill.targetUrl, 'https://www.google.com/search?q=Custom%20Skill');
  });
}
