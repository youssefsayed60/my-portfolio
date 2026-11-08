import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/app_colors.dart';
import '../constants/cv_data.dart';
import '../widgets/glass_container.dart';
import '../widgets/responsive_builder.dart';
import '../widgets/section_header.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isSent = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _copyToClipboard(String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_rounded, color: AppColors.cyan, size: 18),
            const SizedBox(width: 10),
            Text(
              '$label copied to clipboard!',
              style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        backgroundColor: AppColors.bgDarkSurface,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AppColors.glassBorder, width: 1),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isSent = true);

      final uri = Uri(
        scheme: 'mailto',
        path: CVData.email,
        query: 'subject=Project Inquiry from ${_nameController.text}&body=${_messageController.text}%0D%0A%0D%0AReply to: ${_emailController.text}',
      );
      launchUrl(uri);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Thank you, ${_nameController.text}! Message prepared in your email client.',
            style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w600),
          ),
          backgroundColor: AppColors.emerald,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );

      _nameController.clear();
      _emailController.clear();
      _messageController.clear();

      Future.delayed(const Duration(seconds: 4), () {
        if (mounted) setState(() => _isSent = false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isSmall = Responsive.isSmallMobile(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 60 : (isSmall ? 16 : 20),
        vertical: isDesktop ? 50 : 30,
      ),
      child: Column(
        children: [
          const SectionHeader(
            tag: '04. REACH OUT',
            title: 'Let\'s Build Together',
            subtitle:
                'Have an exciting project, full-time role, or contract? I\'d love to hear from you. Send a message or connect directly.',
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1050),
            child: isDesktop
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 5, child: _buildContactInfo(context)),
                      const SizedBox(width: 36),
                      Expanded(flex: 6, child: _buildContactForm(context)),
                    ],
                  )
                : Column(
                    children: [
                      _buildContactInfo(context),
                      const SizedBox(height: 24),
                      _buildContactForm(context),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo(BuildContext context) {
    return Column(
      children: [
        // Email Card
        _ContactCard(
          icon: Icons.email_outlined,
          title: 'Direct Email',
          value: CVData.email,
          color: AppColors.cyan,
          actionLabel: 'Copy',
          onAction: () => _copyToClipboard(CVData.email, 'Email address'),
          onCardTap: () => _launchUrl('mailto:${CVData.email}'),
        ),
        const SizedBox(height: 12),

        // Phone Card
        _ContactCard(
          icon: Icons.phone_android_outlined,
          title: 'Phone & WhatsApp',
          value: CVData.phone,
          color: AppColors.emerald,
          actionLabel: 'Chat',
          onAction: () => _launchUrl('https://wa.me/201094348682'),
          onCardTap: () => _launchUrl('tel:${CVData.phone}'),
        ),
        const SizedBox(height: 12),

        // LinkedIn Card
        _ContactCard(
          icon: Icons.work_rounded,
          title: 'LinkedIn Network',
          value: 'Youssef Sayed',
          color: AppColors.blue,
          actionLabel: 'Visit',
          onAction: () => _launchUrl(CVData.linkedIn),
          onCardTap: () => _launchUrl(CVData.linkedIn),
        ),
      ],
    );
  }

  Widget _buildContactForm(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isSmall = Responsive.isSmallMobile(context);

    return GlassCard(
      glowColor: AppColors.cyan,
      padding: EdgeInsets.all(isDesktop ? 28 : (isSmall ? 16 : 20)),
      borderRadius: 18,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Send a Message',
              style: GoogleFonts.outfit(
                fontSize: isDesktop ? 22 : (isSmall ? 18 : 20),
                fontWeight: FontWeight.w800,
                color: AppColors.textWhite,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Fill out the form below to get in touch.',
              style: GoogleFonts.inter(
                fontSize: isSmall ? 12 : 13,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 16),

            // Name Field
            _buildTextField(
              controller: _nameController,
              label: 'Your Name',
              hint: 'John Doe',
              icon: Icons.person_outline_rounded,
              validator: (val) =>
                  val == null || val.trim().isEmpty ? 'Please enter your name' : null,
            ),
            const SizedBox(height: 14),

            // Email Field
            _buildTextField(
              controller: _emailController,
              label: 'Email Address',
              hint: 'john@example.com',
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              validator: (val) {
                if (val == null || val.trim().isEmpty) return 'Please enter your email';
                if (!val.contains('@') || !val.contains('.')) return 'Invalid email address';
                return null;
              },
            ),
            const SizedBox(height: 14),

            // Message Field
            _buildTextField(
              controller: _messageController,
              label: 'Your Message',
              hint: 'Tell me about your project, timeline, and goals...',
              icon: Icons.message_outlined,
              maxLines: 4,
              validator: (val) =>
                  val == null || val.trim().isEmpty ? 'Please enter your message' : null,
            ),
            const SizedBox(height: 20),

            // Submit Button
            _SubmitButton(
              isSent: _isSent,
              onPressed: _submitForm,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.textWhite,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          validator: validator,
          style: GoogleFonts.inter(color: Colors.white, fontSize: 13),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.inter(color: AppColors.textMuted, fontSize: 13),
            prefixIcon: maxLines == 1 ? Icon(icon, color: AppColors.cyan, size: 18) : null,
            filled: true,
            fillColor: AppColors.bgDarkSurface,
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.glassBorder),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.glassBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.cyan, width: 1.2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.rose),
            ),
          ),
        ),
      ],
    );
  }
}

class _ContactCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;
  final String actionLabel;
  final VoidCallback? onAction;
  final VoidCallback? onCardTap;

  const _ContactCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
    required this.actionLabel,
    this.onAction,
    this.onCardTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSmall = Responsive.isSmallMobile(context);

    return GlassCard(
      glowColor: color,
      padding: EdgeInsets.all(isSmall ? 12 : 16),
      borderRadius: 16,
      onTap: onCardTap,
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(isSmall ? 8 : 10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: color.withValues(alpha: 0.25)),
            ),
            child: Icon(icon, color: color, size: isSmall ? 18 : 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: isSmall ? 10.5 : 11,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: GoogleFonts.outfit(
                    fontSize: isSmall ? 12.5 : 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textWhite,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          if (onAction != null) ...[
            const SizedBox(width: 6),
            GestureDetector(
              onTap: onAction,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isSmall ? 9 : 12,
                  vertical: isSmall ? 5 : 6,
                ),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: color.withValues(alpha: 0.3)),
                ),
                child: Text(
                  actionLabel,
                  style: GoogleFonts.outfit(
                    fontSize: isSmall ? 10.5 : 11,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _SubmitButton extends StatefulWidget {
  final bool isSent;
  final VoidCallback onPressed;

  const _SubmitButton({
    required this.isSent,
    required this.onPressed,
  });

  @override
  State<_SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<_SubmitButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isSmall = Responsive.isSmallMobile(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: isSmall ? 12 : 14),
          decoration: BoxDecoration(
            gradient: widget.isSent
                ? const LinearGradient(colors: [AppColors.emerald, Color(0xFF059669)])
                : AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(14),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: (widget.isSent ? AppColors.emerald : AppColors.cyan)
                          .withValues(alpha: 0.3),
                      blurRadius: 14,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.isSent ? Icons.check_circle_rounded : Icons.send_rounded,
                color: AppColors.textWhite,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                widget.isSent ? 'Message Dispatched!' : 'Send Message',
                style: GoogleFonts.outfit(
                  fontSize: isSmall ? 13 : 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textWhite,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
