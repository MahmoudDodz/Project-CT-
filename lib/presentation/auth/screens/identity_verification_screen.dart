import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/routes/app_router.dart';
import '../../../core/session/app_session.dart';
import '../../shared/widgets/ctos_logo.dart';

class IdentityVerificationScreen extends StatefulWidget {
  final String role;
  const IdentityVerificationScreen({super.key, required this.role});

  @override
  State<IdentityVerificationScreen> createState() =>
      _IdentityVerificationScreenState();
}

class _IdentityVerificationScreenState
    extends State<IdentityVerificationScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  bool _idFrontScanned = false;
  bool _idBackScanned = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _onInitialize() {
    if (_nameController.text.isEmpty) return;
    AppSession.instance.name = _nameController.text.trim();
    AppSession.instance.email = _emailController.text.trim();
    AppSession.instance.role = widget.role;
    context.go(
      '${AppRouter.verifyingIdentity}?role=${widget.role}&name=${Uri.encodeComponent(_nameController.text.trim())}',
    );
  }

  @override
  Widget build(BuildContext context) {
    final isOfficial = widget.role == 'officer';

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => context.go(AppRouter.roleSelection),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.chevron_left,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(child: const CtosLogo(size: 60, showText: false)),
              const SizedBox(height: 16),
              const Center(
                child: Text('Identity Verification',
                    style: AppTextStyles.headlineLarge),
              ),
              const SizedBox(height: 8),
              const Center(
                child: Text(
                  'Secure access for safer communities. Data is\nencrypted end-to-end',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyMedium,
                ),
              ),
              const SizedBox(height: 24),
              // Role tabs
              Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    _TabItem(
                        label: 'Citizen',
                        isActive: !isOfficial,
                        onTap: () => context.go(
                            '${AppRouter.identityVerification}?role=citizen')),
                    _TabItem(
                        label: 'Government Official',
                        isActive: isOfficial,
                        onTap: () => context.go(
                            '${AppRouter.identityVerification}?role=officer')),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              _FieldLabel('Full Legal Name'),
              const SizedBox(height: 8),
              TextField(
                controller: _nameController,
                style: const TextStyle(color: AppColors.textPrimary),
                decoration: InputDecoration(
                  hintText: 'Ex. Jane Doe',
                  suffixIcon: const Icon(Icons.person_outline,
                      color: AppColors.textMuted, size: 18),
                ),
              ),
              const SizedBox(height: 16),
              _FieldLabel('Email Address'),
              const SizedBox(height: 8),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: AppColors.textPrimary),
                decoration: InputDecoration(
                  hintText: 'name@domain.com',
                  suffixIcon: const Icon(Icons.mail_outline,
                      color: AppColors.textMuted, size: 18),
                ),
              ),
              const SizedBox(height: 24),
              _FieldLabel('Government ID Front'),
              const SizedBox(height: 8),
              _ScanBox(
                isScanned: _idFrontScanned,
                label: 'TAP TO SCAN ID FRONT',
                onTap: () => setState(() => _idFrontScanned = !_idFrontScanned),
              ),
              const SizedBox(height: 16),
              _FieldLabel('Government ID Back'),
              const SizedBox(height: 8),
              _ScanBox(
                isScanned: _idBackScanned,
                label: 'TAP TO SCAN ID BACK',
                onTap: () => setState(() => _idBackScanned = !_idBackScanned),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _onInitialize,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Initialize Verification'),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward, size: 18),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.lock_outline,
                      color: AppColors.primary, size: 14),
                  const SizedBox(width: 4),
                  Text(
                    '256-bit SSL Encryption',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Center(
                child: GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Already verified? Log In Access',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: AppTextStyles.titleMedium.copyWith(fontWeight: FontWeight.w600));
  }
}

class _TabItem extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _TabItem(
      {required this.label, required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isActive ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isActive ? AppColors.background : AppColors.textSecondary,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}

class _ScanBox extends StatelessWidget {
  final bool isScanned;
  final String label;
  final VoidCallback onTap;

  const _ScanBox(
      {required this.isScanned, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 120,
        decoration: BoxDecoration(
          color: AppColors.scannerBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isScanned
                ? AppColors.primary
                : AppColors.scannerBorder.withOpacity(0.4),
            width: 1.5,
          ),
        ),
        child: Stack(
          children: [
            // Corner brackets
            ..._buildCorners(),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isScanned ? Icons.check_circle : Icons.crop_free,
                    color: AppColors.primary,
                    size: 28,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    isScanned ? 'SCANNED' : label,
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isScanned ? 'Ready' : 'Automated verification ready',
                    style: const TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildCorners() {
    const c = AppColors.primary;
    const thick = 2.0;
    const len = 16.0;
    const r = 4.0;
    return [
      Positioned(
          top: 8,
          left: 8,
          child: _Corner(color: c, thick: thick, len: len, r: r, pos: 0)),
      Positioned(
          top: 8,
          right: 8,
          child: _Corner(color: c, thick: thick, len: len, r: r, pos: 1)),
      Positioned(
          bottom: 8,
          left: 8,
          child: _Corner(color: c, thick: thick, len: len, r: r, pos: 2)),
      Positioned(
          bottom: 8,
          right: 8,
          child: _Corner(color: c, thick: thick, len: len, r: r, pos: 3)),
    ];
  }
}

class _Corner extends StatelessWidget {
  final Color color;
  final double thick;
  final double len;
  final double r;
  final int pos; // 0=TL,1=TR,2=BL,3=BR

  const _Corner(
      {required this.color,
      required this.thick,
      required this.len,
      required this.r,
      required this.pos});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(len, len),
      painter: _CornerPainter(
          color: color, thick: thick, pos: pos, r: r),
    );
  }
}

class _CornerPainter extends CustomPainter {
  final Color color;
  final double thick;
  final int pos;
  final double r;

  _CornerPainter(
      {required this.color, required this.thick, required this.pos, required this.r});

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = color
      ..strokeWidth = thick
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;

    final w = size.width;
    final h = size.height;

    switch (pos) {
      case 0: // TL
        canvas.drawLine(Offset(0, h), Offset(0, r), p);
        canvas.drawLine(Offset(r, 0), Offset(w, 0), p);
        break;
      case 1: // TR
        canvas.drawLine(Offset(0, 0), Offset(w - r, 0), p);
        canvas.drawLine(Offset(w, r), Offset(w, h), p);
        break;
      case 2: // BL
        canvas.drawLine(Offset(0, 0), Offset(0, h - r), p);
        canvas.drawLine(Offset(r, h), Offset(w, h), p);
        break;
      case 3: // BR
        canvas.drawLine(Offset(w, 0), Offset(w, h - r), p);
        canvas.drawLine(Offset(0, h), Offset(w - r, h), p);
        break;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
