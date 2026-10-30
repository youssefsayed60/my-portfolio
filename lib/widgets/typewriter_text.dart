import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

class TypewriterText extends StatefulWidget {
  final List<String> texts;
  final TextStyle? style;
  final Duration typingSpeed;
  final Duration deletingSpeed;
  final Duration pauseDuration;

  const TypewriterText({
    super.key,
    required this.texts,
    this.style,
    this.typingSpeed = const Duration(milliseconds: 70),
    this.deletingSpeed = const Duration(milliseconds: 35),
    this.pauseDuration = const Duration(milliseconds: 1800),
  });

  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText> {
  int _textIndex = 0;
  int _charIndex = 0;
  bool _isDeleting = false;
  Timer? _timer;
  bool _showCursor = true;
  Timer? _cursorTimer;

  @override
  void initState() {
    super.initState();
    _startCursorBlink();
    _typeNext();
  }

  void _startCursorBlink() {
    _cursorTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (mounted) {
        setState(() => _showCursor = !_showCursor);
      }
    });
  }

  void _typeNext() {
    final currentFullText = widget.texts[_textIndex];

    if (!_isDeleting) {
      if (_charIndex < currentFullText.length) {
        _charIndex++;
        setState(() {});
        _timer = Timer(widget.typingSpeed, _typeNext);
      } else {
        _timer = Timer(widget.pauseDuration, () {
          _isDeleting = true;
          _typeNext();
        });
      }
    } else {
      if (_charIndex > 0) {
        _charIndex--;
        setState(() {});
        _timer = Timer(widget.deletingSpeed, _typeNext);
      } else {
        _isDeleting = false;
        _textIndex = (_textIndex + 1) % widget.texts.length;
        _timer = Timer(const Duration(milliseconds: 400), _typeNext);
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _cursorTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final displayedText =
        widget.texts[_textIndex].substring(0, _charIndex);

    final defaultStyle = GoogleFonts.outfit(
      fontSize: 28,
      fontWeight: FontWeight.w700,
      color: AppColors.cyan,
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: ShaderMask(
            shaderCallback: (bounds) => AppColors.primaryGradient.createShader(bounds),
            child: Text(
              displayedText,
              style: (widget.style ?? defaultStyle).copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ),
        AnimatedOpacity(
          opacity: _showCursor ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 100),
          child: Text(
            ' |',
            style: (widget.style ?? defaultStyle).copyWith(
              color: AppColors.cyan,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ],
    );
  }
}
