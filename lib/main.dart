import 'dart:async';
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
import 'widgets/background_particles.dart';
import 'widgets/progressive_section.dart';
import 'widgets/responsive_builder.dart';

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
          secondary: AppColors.blue,
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
  Timer? _idlePreloadTimer;

  // Progressive section hydration flags
  // Hero section loads immediately on frame 1
  bool _experienceLoaded = false;
  bool _skillsLoaded = false;
  bool _projectsLoaded = false;
  bool _contactLoaded = false;
  bool _footerLoaded = false;

  // Global Keys for smooth scrolling to sections
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    // Staged initial hydration: after the hero section is immediately displayed,
    // prepare the adjacent experience section during idle time
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _idlePreloadTimer = Timer(const Duration(milliseconds: 250), () {
        if (mounted && !_experienceLoaded) {
          setState(() => _experienceLoaded = true);
        }
      });
    });
  }

  void _onScroll() {
    final offset = _scrollController.offset;

    // Toggle Back to Top button
    final show = offset > 350;
    if (show != _showBackToTop) {
      setState(() => _showBackToTop = show);
    }

    // Progressively mount subsequent sections well ahead of viewport
    // ensuring seamless, unnoticeable transition with 0 pop-in
    bool stateChanged = false;

    if (!_experienceLoaded && offset > 40) {
      _experienceLoaded = true;
      stateChanged = true;
    }
    if (!_skillsLoaded && offset > 250) {
      _skillsLoaded = true;
      stateChanged = true;
    }
    if (!_projectsLoaded && offset > 650) {
      _projectsLoaded = true;
      stateChanged = true;
    }
    if (!_contactLoaded && offset > 1050) {
      _contactLoaded = true;
      _footerLoaded = true;
      stateChanged = true;
    }
    if (!_footerLoaded && offset > 1300) {
      _footerLoaded = true;
      stateChanged = true;
    }

    if (stateChanged) {
      setState(() {});
    }
  }

  void _loadUpTo(int index) {
    bool changed = false;
    if (index >= 1 && !_experienceLoaded) {
      _experienceLoaded = true;
      changed = true;
    }
    if (index >= 2 && !_skillsLoaded) {
      _skillsLoaded = true;
      changed = true;
    }
    if (index >= 3 && !_projectsLoaded) {
      _projectsLoaded = true;
      changed = true;
    }
    if (index >= 4 && !_contactLoaded) {
      _contactLoaded = true;
      _footerLoaded = true;
      changed = true;
    }
    if (changed) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _idlePreloadTimer?.cancel();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToKey(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _onNavSelected(int index) {
    _loadUpTo(index);
    WidgetsBinding.instance.addPostFrameCallback((_) {
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
    });
  }

  void _navigateToProjects() {
    _loadUpTo(3);
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToKey(_projectsKey));
  }

  void _navigateToContact() {
    _loadUpTo(4);
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToKey(_contactKey));
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isSmall = Responsive.isSmallMobile(context);
    final topSpacing = isSmall ? 66.0 : 76.0;

    return Scaffold(
      body: BackgroundCanvas(
        child: Stack(
          children: [
            // Scrollable Content
            SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  SizedBox(height: topSpacing), // Space for floating navbar

                  // 1. Hero Section — loaded immediately on startup
                  Container(
                    key: _heroKey,
                    child: HeroSection(
                      onViewProjects: _navigateToProjects,
                      onContactMe: _navigateToContact,
                    ),
                  ),

                  // 2. Experience Section — progressive deferred hydration
                  ProgressiveSection(
                    isLoaded: _experienceLoaded,
                    estimatedHeight: 650,
                    child: Container(
                      key: _experienceKey,
                      child: const ExperienceSection(),
                    ),
                  ),

                  // 3. Skills Section — progressive deferred hydration
                  ProgressiveSection(
                    isLoaded: _skillsLoaded,
                    estimatedHeight: 550,
                    child: Container(
                      key: _skillsKey,
                      child: const SkillsSection(),
                    ),
                  ),

                  // 4. Featured Projects Section — progressive deferred hydration
                  ProgressiveSection(
                    isLoaded: _projectsLoaded,
                    estimatedHeight: 750,
                    child: Container(
                      key: _projectsKey,
                      child: const ProjectsSection(),
                    ),
                  ),

                  // 5. Contact Section — progressive deferred hydration
                  ProgressiveSection(
                    isLoaded: _contactLoaded,
                    estimatedHeight: 600,
                    child: Container(
                      key: _contactKey,
                      child: const ContactSection(),
                    ),
                  ),

                  // 6. Footer Section
                  ProgressiveSection(
                    isLoaded: _footerLoaded,
                    estimatedHeight: 180,
                    child: FooterSection(onBackToTop: _scrollToTop),
                  ),
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
                onContactPressed: _navigateToContact,
              ),
            ),

            // Floating Scroll to Top Button
            if (_showBackToTop)
              Positioned(
                bottom: isSmall ? 16 : 22,
                right: isSmall ? 16 : 22,
                child: FloatingActionButton.small(
                  backgroundColor: AppColors.cyan,
                  foregroundColor: AppColors.textWhite,
                  elevation: 4,
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
