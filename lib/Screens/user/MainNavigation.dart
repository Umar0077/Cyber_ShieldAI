import 'package:flutter/material.dart';
import 'package:cybershield_ai/constant/colors/colors.dart';
import 'package:cybershield_ai/Screens/user/Dashboard.dart';
import 'package:cybershield_ai/Screens/user/CallHistory.dart';
import 'package:cybershield_ai/Screens/user/SmSHistory.dart';
import 'package:cybershield_ai/Screens/user/Image_Detection.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({Key? key}) : super(key: key);

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const CallHistoryScreen(),
    const SMSHistoryScreen(),
    const ImageDetectionScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.brandCyan.withOpacity(0.15),
              AppColors.brandCyan.withOpacity(0.08),
            ],
          ),
          border: Border(
            top: BorderSide(
              color: AppColors.brandCyan.withOpacity(0.3),
              width: 1.5,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.brandCyan.withOpacity(0.15),
              blurRadius: 24,
              offset: const Offset(0, -4),
              spreadRadius: 3,
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  icon: Icons.dashboard_outlined,
                  activeIcon: Icons.dashboard,
                  label: 'Home',
                  index: 0,
                ),
                _buildNavItem(
                  icon: Icons.phone_outlined,
                  activeIcon: Icons.phone,
                  label: 'Calls',
                  index: 1,
                ),
                _buildNavItem(
                  icon: Icons.sms_outlined,
                  activeIcon: Icons.sms,
                  label: 'SMS',
                  index: 2,
                ),
                _buildNavItem(
                  icon: Icons.image_outlined,
                  activeIcon: Icons.image,
                  label: 'Images',
                  index: 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required int index,
  }) {
    final isActive = _currentIndex == index;

    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            _currentIndex = index;
          });
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isActive
                ? AppColors.brandCyan.withOpacity(0.12)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isActive ? activeIcon : icon,
                color: isActive ? AppColors.brandCyan : AppColors.mutedSteel,
                size: 26,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: isActive ? AppColors.brandCyan : AppColors.mutedSteel,
                  fontSize: 12,
                  fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
