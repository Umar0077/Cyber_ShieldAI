import 'package:flutter/material.dart';
import 'package:cybershield_ai/constant/colors/colors.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  double _passwordStrength = 0.0;
  Color _passwordStrengthColor = AppColors.threatRed;
  String _passwordStrengthText = '';

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_updatePasswordStrength);
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _updatePasswordStrength() {
    final password = _passwordController.text;
    double strength = 0.0;
    Color color = AppColors.threatRed;
    String text = '';

    if (password.isEmpty) {
      strength = 0.0;
      color = AppColors.threatRed;
      text = '';
    } else if (password.length < 6) {
      strength = 0.25;
      color = AppColors.threatRed;
      text = 'Weak';
    } else if (password.length < 8) {
      strength = 0.5;
      color = AppColors.warningAmber;
      text = 'Fair';
    } else {
      // Check for complexity
      bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
      bool hasLowercase = password.contains(RegExp(r'[a-z]'));
      bool hasDigits = password.contains(RegExp(r'[0-9]'));
      bool hasSpecialCharacters = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

      int complexityCount = 0;
      if (hasUppercase) complexityCount++;
      if (hasLowercase) complexityCount++;
      if (hasDigits) complexityCount++;
      if (hasSpecialCharacters) complexityCount++;

      if (complexityCount >= 3 && password.length >= 10) {
        strength = 1.0;
        color = AppColors.safeGreen;
        text = 'Strong';
      } else if (complexityCount >= 2) {
        strength = 0.75;
        color = AppColors.warningAmber;
        text = 'Good';
      } else {
        strength = 0.5;
        color = AppColors.warningAmber;
        text = 'Fair';
      }
    }

    setState(() {
      _passwordStrength = strength;
      _passwordStrengthColor = color;
      _passwordStrengthText = text;
    });
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
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 20),
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
                      // App title
                      Text(
                        'CyberShield AI',
                        style: TextStyle(
                          color: AppColors.trustWhite,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.3,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Create Your Account',
                        style: TextStyle(
                          color: AppColors.trustWhite.withOpacity(0.75),
                          fontSize: 15,
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
                            // Full Name field
                            _buildInputField(
                              controller: _fullNameController,
                              label: 'Full Name',
                              hint: 'Enter your full name',
                              icon: Icons.person_outline,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your full name';
                                }
                                if (value.length < 3) {
                                  return 'Name must be at least 3 characters';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            // Email field
                            _buildInputField(
                              controller: _emailController,
                              label: 'Email',
                              hint: 'Enter your email address',
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
                            const SizedBox(height: 20),
                            // Password field
                            _buildInputField(
                              controller: _passwordController,
                              label: 'Password',
                              hint: 'Create a strong password',
                              icon: Icons.lock_outline,
                              obscureText: _obscurePassword,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: AppColors.mutedSteel,
                                  size: 20,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a password';
                                }
                                if (value.length < 8) {
                                  return 'Password must be at least 8 characters';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 12),
                            // Password strength indicator
                            if (_passwordController.text.isNotEmpty)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(4),
                                          child: LinearProgressIndicator(
                                            value: _passwordStrength,
                                            backgroundColor:
                                                AppColors.mutedSteel.withOpacity(0.2),
                                            valueColor: AlwaysStoppedAnimation<Color>(
                                              _passwordStrengthColor,
                                            ),
                                            minHeight: 6,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        _passwordStrengthText,
                                        style: TextStyle(
                                          color: _passwordStrengthColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Use 8+ characters with uppercase, lowercase, numbers & symbols',
                                    style: TextStyle(
                                      color: AppColors.mutedSteel.withOpacity(0.7),
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            const SizedBox(height: 20),
                            // Confirm Password field
                            _buildInputField(
                              controller: _confirmPasswordController,
                              label: 'Confirm Password',
                              hint: 'Re-enter your password',
                              icon: Icons.lock_outline,
                              obscureText: _obscureConfirmPassword,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureConfirmPassword
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: AppColors.mutedSteel,
                                  size: 20,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureConfirmPassword = !_obscureConfirmPassword;
                                  });
                                },
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please confirm your password';
                                }
                                if (value != _passwordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 28),
                            // Create Account button
                            SizedBox(
                              height: 54,
                              child: ElevatedButton(
                                onPressed: _handleSignUp,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.brandCyan,
                                  foregroundColor: AppColors.brandNavy,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  shadowColor: AppColors.brandCyan.withOpacity(0.3),
                                ),
                                child: const Text(
                                  'Create Account',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            // Google Sign Up button
                            SizedBox(
                              height: 54,
                              child: OutlinedButton.icon(
                                onPressed: _handleGoogleSignUp,
                                icon: Image.asset(
                                  'assets/images/google_icon.png',
                                  width: 22,
                                  height: 22,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(
                                      Icons.g_mobiledata_rounded,
                                      color: AppColors.textPrimary,
                                      size: 28,
                                    );
                                  },
                                ),
                                label: const Text(
                                  'Sign up with Google',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: AppColors.textPrimary,
                                  side: BorderSide(
                                    color: AppColors.mutedSteel.withOpacity(0.4),
                                    width: 1.5,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            // Email verification notice with glass effect
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
                                children: [
                                  Icon(
                                    Icons.email_outlined,
                                    color: AppColors.trustWhite,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      'A verification email will be sent to activate your account',
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
                            const SizedBox(height: 20),
                            // Already have account link
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already have an account? ",
                                  style: TextStyle(
                                    color: AppColors.trustWhite.withOpacity(0.8),
                                    fontSize: 14,
                                  ),
                                ),
                                TextButton(
                                  onPressed: _handleLogin,
                                  style: TextButton.styleFrom(
                                    foregroundColor: AppColors.brandCyan,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                      vertical: 8,
                                    ),
                                    minimumSize: Size.zero,
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  child: const Text(
                                    'Login',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
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
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool obscureText = false,
    Widget? suffixIcon,
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
          obscureText: obscureText,
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
            suffixIcon: suffixIcon,
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

  void _handleSignUp() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement signup logic
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Account created successfully! Check your email for verification.'),
          backgroundColor: AppColors.safeGreen,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
  }

  void _handleGoogleSignUp() {
    // TODO: Implement Google Sign Up
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Google Sign Up coming soon!'),
        backgroundColor: AppColors.brandCyan,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void _handleLogin() {
    // TODO: Navigate to login screen
    Navigator.pop(context);
  }
}

// Circuit background painter (matching splash and login screens)
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
