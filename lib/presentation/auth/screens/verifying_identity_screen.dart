import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/routes/app_router.dart';
import '../../shared/widgets/ctos_logo.dart';

class VerifyingIdentityScreen extends StatefulWidget {
  final String role;
  const VerifyingIdentityScreen({super.key, required this.role});

  @override
  State<VerifyingIdentityScreen> createState() =>
      _VerifyingIdentityScreenState();
}

class _VerifyingIdentityScreenState extends State<VerifyingIdentityScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _progressController;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..forward().then((_) async {
        if (mounted) {
          context.go('${AppRouter.identityVerified}?role=${widget.role}');
        }
      });
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CtosLogo(size: 80),
              const SizedBox(height: 40),
              Text(
                'Please wait while we verify your identity',
                textAlign: TextAlign.center,
                style: AppTextStyles.primaryAccent.copyWith(fontSize: 16),
              ),
              const SizedBox(height: 24),
              Text(
                'Automated verification in progress',
                style: AppTextStyles.bodyMedium,
              ),
              const SizedBox(height: 20),
              AnimatedBuilder(
                animation: _progressController,
                builder: (_, __) => ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: _progressController.value,
                    backgroundColor: AppColors.surface,
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(AppColors.primary),
                    minHeight: 6,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
