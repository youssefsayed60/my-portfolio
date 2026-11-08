import 'package:flutter/material.dart';

/// Wraps a page section so that it is only instantiated and mounted when triggered,
/// saving initial load time, memory, and CPU/GPU resources.
/// Once mounted, it stays in the widget tree for uninterrupted scrolling.
class ProgressiveSection extends StatefulWidget {
  final Widget child;
  final bool isLoaded;
  final double estimatedHeight;

  const ProgressiveSection({
    super.key,
    required this.child,
    required this.isLoaded,
    this.estimatedHeight = 500,
  });

  @override
  State<ProgressiveSection> createState() => _ProgressiveSectionState();
}

class _ProgressiveSectionState extends State<ProgressiveSection> {
  bool _hasMounted = false;

  @override
  void initState() {
    super.initState();
    if (widget.isLoaded) {
      _hasMounted = true;
    }
  }

  @override
  void didUpdateWidget(covariant ProgressiveSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isLoaded && !_hasMounted) {
      setState(() {
        _hasMounted = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_hasMounted) {
      return AnimatedOpacity(
        opacity: 1.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        child: widget.child,
      );
    }

    // Lightweight placeholder maintaining natural scroll geometry
    return SizedBox(
      height: widget.estimatedHeight,
      child: const SizedBox.shrink(),
    );
  }
}
