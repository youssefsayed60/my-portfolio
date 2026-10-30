import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants/app_colors.dart';
import 'constants/cv_data.dart';
import 'sections/contact_section.dart';
import 'sections/experience_section.dart';
import 'sections/footer_section.dart';
import 'sections/hero_section.dart';
import 'sections/navbar.dart';
import 'sections/projects_section.dart';
import 'sections/skills_section.dart';
import 'sections/stats_section.dart';
import 'widgets/background_particles.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '${CVData.name} • ${CVData.title}',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.bgDark,
        primaryColor: AppColors.cyan,
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
        colorScheme: const ColorScheme.dark(
          primary: AppColors.cyan,
          secondary: AppColors.purple,
          surface: AppColors.bgDarkSurface,
        ),
      ),
      home: const PortfolioHomePage(),
    );
  }
}

class PortfolioHomePage extends StatefulWidget {
  const PortfolioHomePage({super.key});

  @override
  State<PortfolioHomePage> createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  final ScrollController _scrollController = ScrollController();
  bool _showBackToTop = false;

  // Global Keys for smooth scrolling to sections
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final show = _scrollController.offset > 400;
      if (show != _showBackToTop) {
        setState(() => _showBackToTop = show);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToKey(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _onNavSelected(int index) {
    switch (index) {
      case 0:
        _scrollToKey(_heroKey);
        break;
      case 1:
        _scrollToKey(_experienceKey);
        break;
      case 2:
        _scrollToKey(_skillsKey);
        break;
      case 3:
        _scrollToKey(_projectsKey);
        break;
      case 4:
        _scrollToKey(_contactKey);
        break;
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundCanvas(
        child: Stack(
          children: [
            // Scrollable Content
            SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  const SizedBox(height: 90), // Space for floating navbar

                  // Hero Section
                  Container(
                    key: _heroKey,
                    child: HeroSection(
                      onViewProjects: () => _scrollToKey(_projectsKey),
                      onContactMe: () => _scrollToKey(_contactKey),
                    ),
                  ),

                  // Experience Section
                  Container(
                    key: _experienceKey,
                    child: const ExperienceSection(),
                  ),

                  // Skills Section
                  Container(
                    key: _skillsKey,
                    child: const SkillsSection(),
                  ),

                  // Featured Projects Section
                  Container(
                    key: _projectsKey,
                    child: const ProjectsSection(),
                  ),

                  // Contact & Connect Section
                  Container(
                    key: _contactKey,
                    child: const ContactSection(),
                  ),

                  // Footer Section
                  FooterSection(onBackToTop: _scrollToTop),
                ],
              ),
            ),

            // Top Floating Navbar
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Navbar(
                onNavItemSelected: _onNavSelected,
                onContactPressed: () => _scrollToKey(_contactKey),
              ),
            ),

            // Floating Scroll to Top Button
            if (_showBackToTop)
              Positioned(
                bottom: 24,
                right: 24,
                child: FloatingActionButton.small(
                  backgroundColor: AppColors.cyan,
                  foregroundColor: const Color(0xFFF4F4F5),
                  elevation: 6,
                  onPressed: _scrollToTop,
                  child: const Icon(Icons.arrow_upward_rounded),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
