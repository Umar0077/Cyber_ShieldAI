import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:cybershield_ai/constant/colors/colors.dart';
import 'package:cybershield_ai/Screens/user/Login_Screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _logoController;
  late final Animation<double> _logoScale;
  late final Animation<double> _logoFade;

  late final AnimationController _dotController;

  @override
  void initState() {
    super.initState();

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );

    _logoScale = Tween<double>(begin: 0.86, end: 1.0)
        .animate(CurvedAnimation(parent: _logoController, curve: Curves.easeOut));
    _logoFade = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _logoController, curve: Curves.easeOut));

    _logoController.forward();

    _dotController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();

    // Navigate to Login screen after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _dotController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.brandNavy,
      body: Stack(
        children: [
          // Subtle digital circuit background
          Positioned.fill(
            child: CustomPaint(
              painter: _CircuitPainter(
                color: AppColors.brandCyan.withOpacity(0.06),
              ),
            ),
          ),
          // Center content
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedBuilder(
                  animation: _logoController,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _logoFade.value,
                      child: Transform.scale(
                        scale: _logoScale.value,
                        child: child,
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.brandCyan.withOpacity(0.28),
                          blurRadius: 48,
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/Logos/logo.png',
                        width: 200,
                        height: 200,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                // Three animated dots
                AnimatedBuilder(
                  animation: _dotController,
                  builder: (context, child) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildDot(0),
                        const SizedBox(width: 12),
                        _buildDot(1),
                        const SizedBox(width: 12),
                        _buildDot(2),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(int index) {
    final delay = index * 0.2;
    final animationValue = (_dotController.value - delay) % 1.0;
    
    // Create a bounce effect
    final scale = animationValue < 0.5
        ? 1.0 + (math.sin(animationValue * math.pi * 2) * 0.5)
        : 1.0;
    
    final opacity = animationValue < 0.5
        ? 0.4 + (math.sin(animationValue * math.pi * 2) * 0.6)
        : 0.4;

    return Transform.scale(
      scale: scale,
      child: Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.brandCyan.withOpacity(opacity),
          boxShadow: [
            BoxShadow(
              color: AppColors.brandCyan.withOpacity(opacity * 0.5),
              blurRadius: 8,
              spreadRadius: 2,
            ),
          ],
        ),
      ),
    );
  }
}

class _CircuitPainter extends CustomPainter {
  final Color color;

  _CircuitPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final rng = math.Random(42);
    // draw subtle horizontal lines and small nodes
    for (int i = 0; i < 12; i++) {
      final y = size.height * (i / 12 + 0.02 * (rng.nextDouble() - 0.5));
      final startX = size.width * (0.06 + rng.nextDouble() * 0.12);
      final endX = size.width * (0.9 - rng.nextDouble() * 0.12);
      canvas.drawLine(Offset(startX, y), Offset(endX, y), paint);

      // small vertical branches
      final branchCount = 1 + rng.nextInt(3);
      for (int b = 0; b < branchCount; b++) {
        final bx = startX + (endX - startX) * rng.nextDouble();
        final by = y + (rng.nextBool() ? -12.0 : 12.0) * rng.nextDouble();
        canvas.drawLine(Offset(bx, y), Offset(bx, by), paint);
        canvas.drawCircle(Offset(bx, by), 1.2, paint..style = PaintingStyle.fill);
        paint.style = PaintingStyle.stroke;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
