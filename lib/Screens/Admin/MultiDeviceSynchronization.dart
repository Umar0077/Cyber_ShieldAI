import 'package:flutter/material.dart';
import 'package:cybershield_ai/constant/colors/colors.dart';
import 'dart:math' as math;

class MultiDeviceSynchronization extends StatefulWidget {
  const MultiDeviceSynchronization({Key? key}) : super(key: key);

  @override
  State<MultiDeviceSynchronization> createState() => _MultiDeviceSynchronizationState();
}

class _MultiDeviceSynchronizationState extends State<MultiDeviceSynchronization>
    with SingleTickerProviderStateMixin {
  bool _isSyncing = false;
  double _syncProgress = 0.0;
  late AnimationController _animationController;

  final List<Map<String, dynamic>> _connectedDevices = [
    {
      'name': 'iPhone 13 Pro',
      'type': 'iOS',
      'lastSync': '2 mins ago',
      'icon': Icons.phone_iphone,
      'isOnline': true,
    },
    {
      'name': 'Samsung Galaxy S22',
      'type': 'Android',
      'lastSync': '15 mins ago',
      'icon': Icons.phone_android,
      'isOnline': true,
    },
    {
      'name': 'iPad Air',
      'type': 'iOS',
      'lastSync': '1 hour ago',
      'icon': Icons.tablet_mac,
      'isOnline': false,
    },
    {
      'name': 'MacBook Pro',
      'type': 'Desktop',
      'lastSync': '3 hours ago',
      'icon': Icons.laptop_mac,
      'isOnline': false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
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
                // Header
                _buildHeader(),
                // Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Cloud Sync Status
                        _buildCloudSyncStatus(),
                        const SizedBox(height: 20),
                        // Manual Sync Button
                        _buildManualSyncButton(),
                        const SizedBox(height: 24),
                        // Sync Settings
                        _buildSyncSettings(),
                        const SizedBox(height: 24),
                        // Device List
                        _buildDeviceListSection(),
                        const SizedBox(height: 20),
                      ],
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

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.brandNavy,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Back button
          IconButton(
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
          const SizedBox(width: 12),
          // Logo with cyan glow
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.brandCyan.withOpacity(0.4),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/Logos/logo.png',
                width: 36,
                height: 36,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Device Sync',
                  style: TextStyle(
                    color: AppColors.trustWhite,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3,
                  ),
                ),
                Text(
                  'Multi-device synchronization',
                  style: TextStyle(
                    color: AppColors.trustWhite.withOpacity(0.7),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          // Settings icon
          IconButton(
            onPressed: () {
              _showSyncSettingsDialog();
            },
            icon: Icon(
              Icons.settings_outlined,
              color: AppColors.brandCyan,
              size: 26,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCloudSyncStatus() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.trustWhite,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
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
                  Icons.cloud_sync,
                  color: AppColors.brandCyan,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cloud Sync Status',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      _isSyncing ? 'Syncing...' : 'All devices synced',
                      style: TextStyle(
                        color: _isSyncing ? AppColors.brandCyan : AppColors.safeGreen,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              if (_isSyncing)
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: AppColors.brandCyan,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 28),
          // Circular Progress
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 160,
                height: 160,
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return CustomPaint(
                      painter: _CircularProgressPainter(
                        progress: _isSyncing ? _animationController.value : _syncProgress,
                        progressColor: _isSyncing ? AppColors.brandCyan : AppColors.safeGreen,
                        backgroundColor: AppColors.mutedSteel.withOpacity(0.2),
                        isAnimating: _isSyncing,
                      ),
                    );
                  },
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _isSyncing ? Icons.sync : Icons.cloud_done,
                    color: _isSyncing ? AppColors.brandCyan : AppColors.safeGreen,
                    size: 48,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _isSyncing ? '${(_syncProgress * 100).toInt()}%' : '100%',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _isSyncing ? 'Syncing data...' : 'Up to date',
                    style: TextStyle(
                      color: AppColors.mutedSteel,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Sync Info
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.brandCyan.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.brandCyan.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: AppColors.brandCyan,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Last sync: 2 minutes ago\n${_connectedDevices.length} devices connected',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
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

  Widget _buildManualSyncButton() {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton.icon(
        onPressed: _isSyncing ? null : _startManualSync,
        icon: Icon(
          _isSyncing ? Icons.sync : Icons.sync,
          size: 22,
        ),
        label: Text(
          _isSyncing ? 'Syncing...' : 'Manual Sync',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.brandCyan,
          foregroundColor: AppColors.brandNavy,
          disabledBackgroundColor: AppColors.mutedSteel.withOpacity(0.3),
          disabledForegroundColor: AppColors.mutedSteel,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          shadowColor: AppColors.brandCyan.withOpacity(0.3),
        ),
      ),
    );
  }

  Widget _buildSyncSettings() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.trustWhite,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sync Settings',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildSyncSettingItem(
            icon: Icons.wifi,
            title: 'Auto Sync',
            subtitle: 'Sync automatically when connected',
            value: true,
          ),
          const SizedBox(height: 12),
          _buildSyncSettingItem(
            icon: Icons.battery_charging_full,
            title: 'Sync on Charging',
            subtitle: 'Only sync when device is charging',
            value: false,
          ),
          const SizedBox(height: 12),
          _buildSyncSettingItem(
            icon: Icons.wifi_tethering,
            title: 'WiFi Only',
            subtitle: 'Sync only on WiFi connection',
            value: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSyncSettingItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.brandCyan.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: AppColors.brandCyan,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  color: AppColors.mutedSteel,
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: (newValue) {},
          activeColor: AppColors.brandCyan,
          inactiveThumbColor: AppColors.mutedSteel,
        ),
      ],
    );
  }

  Widget _buildDeviceListSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Connected Devices',
              style: TextStyle(
                color: AppColors.trustWhite,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.brandCyan.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColors.brandCyan.withOpacity(0.5),
                  width: 1,
                ),
              ),
              child: Text(
                '${_connectedDevices.length} devices',
                style: TextStyle(
                  color: AppColors.brandCyan,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        ...(_connectedDevices.map((device) => _buildDeviceCard(device))),
      ],
    );
  }

  Widget _buildDeviceCard(Map<String, dynamic> device) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.trustWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Device Icon
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.brandCyan.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              device['icon'],
              color: AppColors.brandCyan,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          // Device Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        device['name'],
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (device['isOnline'])
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColors.safeGreen.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: AppColors.safeGreen.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: AppColors.safeGreen,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Online',
                              style: TextStyle(
                                color: AppColors.safeGreen,
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  device['type'],
                  style: TextStyle(
                    color: AppColors.textPrimary.withOpacity(0.7),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      color: AppColors.mutedSteel,
                      size: 12,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Last sync: ${device['lastSync']}',
                      style: TextStyle(
                        color: AppColors.mutedSteel,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Actions
          Column(
            children: [
              IconButton(
                onPressed: () => _syncDevice(device),
                icon: Icon(
                  Icons.sync,
                  color: AppColors.brandCyan,
                  size: 22,
                ),
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.brandCyan.withOpacity(0.1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              IconButton(
                onPressed: () => _removeDevice(device),
                icon: Icon(
                  Icons.delete_outline,
                  color: AppColors.threatRed,
                  size: 22,
                ),
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.threatRed.withOpacity(0.1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _startManualSync() async {
    setState(() {
      _isSyncing = true;
      _syncProgress = 0.0;
    });

    // Simulate sync progress
    for (int i = 0; i <= 100; i += 10) {
      await Future.delayed(const Duration(milliseconds: 300));
      if (mounted) {
        setState(() {
          _syncProgress = i / 100;
        });
      }
    }

    if (mounted) {
      setState(() {
        _isSyncing = false;
        _syncProgress = 1.0;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('All devices synced successfully'),
          backgroundColor: AppColors.safeGreen,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
  }

  void _syncDevice(Map<String, dynamic> device) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Syncing ${device['name']}...'),
        backgroundColor: AppColors.brandCyan,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void _removeDevice(Map<String, dynamic> device) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: AppColors.threatRed),
            const SizedBox(width: 12),
            Text(
              'Remove Device',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Text(
          'Are you sure you want to remove "${device['name']}" from your connected devices?',
          style: TextStyle(
            color: AppColors.mutedSteel,
            fontSize: 14,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: AppColors.mutedSteel,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _connectedDevices.remove(device);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${device['name']} removed'),
                  backgroundColor: AppColors.threatRed,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.threatRed,
              foregroundColor: AppColors.trustWhite,
            ),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }

  void _showSyncSettingsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(Icons.settings_outlined, color: AppColors.brandCyan),
            const SizedBox(width: 12),
            Text(
              'Sync Settings',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Configure how and when your devices sync:',
              style: TextStyle(
                color: AppColors.mutedSteel,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 16),
            _buildDialogOption('Sync Frequency', 'Every 30 minutes'),
            const SizedBox(height: 12),
            _buildDialogOption('Data Retention', '90 days'),
            const SizedBox(height: 12),
            _buildDialogOption('Encryption', 'AES-256'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Close',
              style: TextStyle(
                color: AppColors.brandCyan,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDialogOption(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: AppColors.brandCyan,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

// Circular Progress Painter
class _CircularProgressPainter extends CustomPainter {
  final double progress;
  final Color progressColor;
  final Color backgroundColor;
  final bool isAnimating;

  _CircularProgressPainter({
    required this.progress,
    required this.progressColor,
    required this.backgroundColor,
    required this.isAnimating,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Background circle
    final bgPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, bgPaint);

    // Progress arc
    final progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;

    final sweepAngle = 2 * math.pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      sweepAngle,
      false,
      progressPaint,
    );

    // Glow effect for active state
    if (isAnimating) {
      final glowPaint = Paint()
        ..color = progressColor.withOpacity(0.3)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 16
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -math.pi / 2,
        sweepAngle,
        false,
        glowPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Circuit background painter
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
      canvas.drawCircle(Offset(x, y), 2, paint..style = PaintingStyle.fill);
      paint.style = PaintingStyle.stroke;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
