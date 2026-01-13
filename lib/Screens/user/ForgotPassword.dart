import 'package:flutter/material.dart';
import 'package:cybershield_ai/constant/colors/colors.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;
  bool _emailSent = false;

  @override
  void dispose() {
    _emailController.dispose();
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
          // Main content
          SafeArea(
            child: Column(
              children: [
                // Back button
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: AppColors.trustWhite,
                        size: 20,
                      ),
                      style: IconButton.styleFrom(
                        backgroundColor: AppColors.trustWhite.withOpacity(0.1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
                // Scrollable content
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Logo with cyan glow
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.brandCyan.withOpacity(0.35),
                                    blurRadius: 52,
                                    spreadRadius: 6,
                                  ),
                                ],
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  'assets/Logos/logo.png',
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            // Title
                            Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: AppColors.trustWhite,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.3,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'No worries, we\'ll send you reset instructions',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.trustWhite.withOpacity(0.75),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 32),
                            // Glass morphism card container
                            Container(
                              padding: const EdgeInsets.all(28),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    AppColors.trustWhite.withOpacity(0.15),
                                    AppColors.trustWhite.withOpacity(0.08),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: AppColors.brandCyan.withOpacity(0.25),
                                  width: 1.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.brandCyan.withOpacity(0.15),
                                    blurRadius: 24,
                                    offset: const Offset(0, 8),
                                    spreadRadius: 3,
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  if (!_emailSent) ...[
                                    // Email field
                                    _buildInputField(
                                      controller: _emailController,
                                      label: 'Email Address',
                                      hint: 'Enter your registered email',
                                      icon: Icons.email_outlined,
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your email';
                                        }
                                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                            .hasMatch(value)) {
                                          return 'Please enter a valid email';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 24),
                                    // Security verification section with glass effect
                                    Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            AppColors.safeGreen.withOpacity(0.12),
                                            AppColors.safeGreen.withOpacity(0.06),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: AppColors.safeGreen.withOpacity(0.25),
                                          width: 1.5,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColors.safeGreen.withOpacity(0.1),
                                            blurRadius: 16,
                                            spreadRadius: 1,
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  color: AppColors.brandCyan.withOpacity(0.1),
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: Icon(
                                                  Icons.verified_user_outlined,
                                                  color: AppColors.brandCyan,
                                                  size: 24,
                                                ),
                                              ),
                                              const SizedBox(width: 14),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Secure Verification',
                                                      style: TextStyle(
                                                        color: AppColors.trustWhite,
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 4),
                                                    Text(
                                                      'Protected by advanced security',
                                                      style: TextStyle(
                                                        color: AppColors.trustWhite.withOpacity(0.85),
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 14),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              _buildSecurityIcon(Icons.shield_outlined),
                                              _buildSecurityDivider(),
                                              _buildSecurityIcon(Icons.lock_clock_outlined),
                                              _buildSecurityDivider(),
                                              _buildSecurityIcon(Icons.check_circle_outline),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 28),
                                    // Send Reset Link button
                                    SizedBox(
                                      height: 54,
                                      child: ElevatedButton(
                                        onPressed: _isLoading ? null : _handleSendResetLink,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.brandCyan,
                                          foregroundColor: AppColors.brandNavy,
                                          disabledBackgroundColor:
                                              AppColors.mutedSteel.withOpacity(0.3),
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                        ),
                                        child: _isLoading
                                            ? SizedBox(
                                                height: 20,
                                                width: 20,
                                                child: CircularProgressIndicator(
                                                  strokeWidth: 2,
                                                  color: AppColors.brandNavy,
                                                ),
                                              )
                                            : const Text(
                                                'Send Reset Link',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  letterSpacing: 0.5,
                                                ),
                                              ),
                                      ),
                                    ),
                                  ] else ...[
                                    // Success state
                                    Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(20),
                                          decoration: BoxDecoration(
                                            color: AppColors.safeGreen.withOpacity(0.1),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.mark_email_read_outlined,
                                            color: AppColors.safeGreen,
                                            size: 64,
                                          ),
                                        ),
                                        const SizedBox(height: 24),
                                        Text(
                                          'Check Your Email',
                                          style: TextStyle(
                                            color: AppColors.textPrimary,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        Text(
                                          'We have sent password reset instructions to',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: AppColors.mutedSteel,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          _emailController.text,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: AppColors.brandCyan,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 28),
                                        SizedBox(
                                          width: double.infinity,
                                          height: 54,
                                          child: ElevatedButton(
                                            onPressed: () => Navigator.pop(context),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: AppColors.brandCyan,
                                              foregroundColor: AppColors.brandNavy,
                                              elevation: 0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                            ),
                                            child: const Text(
                                              'Back to Login',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 0.5,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              _emailSent = false;
                                            });
                                          },
                                          style: TextButton.styleFrom(
                                            foregroundColor: AppColors.brandCyan,
                                          ),
                                          child: const Text(
                                            'Resend Email',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                  const SizedBox(height: 20),
                                  // Information note with glass effect
                                  Container(
                                    padding: const EdgeInsets.all(14),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          AppColors.warningAmber.withOpacity(0.12),
                                          AppColors.warningAmber.withOpacity(0.06),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: AppColors.warningAmber.withOpacity(0.25),
                                        width: 1.5,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.warningAmber.withOpacity(0.1),
                                          blurRadius: 12,
                                          spreadRadius: 1,
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.info_outline,
                                          color: AppColors.trustWhite,
                                          size: 18,
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                            'After verification, a temporary password reset link will be sent to your registered email or phone number. Please check your spam folder if you don\'t see it.',
                                            style: TextStyle(
                                              color: AppColors.trustWhite,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              height: 1.4,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),
                            // Back to login link
                            if (!_emailSent)
                              TextButton.icon(
                                onPressed: () => Navigator.pop(context),
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: AppColors.brandCyan,
                                  size: 18,
                                ),
                                label: Text(
                                  'Back to Login',
                                  style: TextStyle(
                                    color: AppColors.brandCyan,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.trustWhite,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: AppColors.mutedSteel.withOpacity(0.6),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            prefixIcon: Icon(
              icon,
              color: AppColors.mutedSteel,
              size: 20,
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppColors.mutedSteel.withOpacity(0.3),
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.brandCyan,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.threatRed,
                width: 1.5,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.threatRed,
                width: 2,
              ),
            ),
            errorStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSecurityIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.brandCyan.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        icon,
        color: AppColors.mutedSteel,
        size: 20,
      ),
    );
  }

  Widget _buildSecurityDivider() {
    return Container(
      width: 20,
      height: 1,
      color: AppColors.brandCyan.withOpacity(0.3),
    );
  }

  void _handleSendResetLink() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isLoading = false;
        _emailSent = true;
      });

      // TODO: Implement actual password reset logic
    }
  }
}

// Circuit background painter (matching other screens)
class _CircuitPainter extends CustomPainter {
  final Color color;

  _CircuitPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final random = DateTime.now().millisecondsSinceEpoch;
    for (var i = 0; i < 30; i++) {
      final x = (random * i * 13) % size.width;
      final y = (random * i * 17) % size.height;
      final endX = x + ((random * i * 7) % 60) - 30;
      final endY = y + ((random * i * 11) % 60) - 30;

      canvas.drawLine(Offset(x, y), Offset(endX, endY), paint);

      // Small node circles
      canvas.drawCircle(Offset(x, y), 2, paint..style = PaintingStyle.fill);
      paint.style = PaintingStyle.stroke;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
