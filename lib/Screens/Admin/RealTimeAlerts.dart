import 'package:flutter/material.dart';
import 'package:cybershield_ai/constant/colors/colors.dart';

class RealTimeAlerts extends StatefulWidget {
  const RealTimeAlerts({Key? key}) : super(key: key);

  @override
  State<RealTimeAlerts> createState() => _RealTimeAlertsState();
}

class _RealTimeAlertsState extends State<RealTimeAlerts> {
  bool _callAlertsEnabled = true;
  bool _smsAlertsEnabled = true;
  bool _imageAlertsEnabled = false;
  bool _pushNotificationsEnabled = true;

  final List<Map<String, dynamic>> _alertHistory = [
    {
      'type': 'Scam Call Blocked',
      'description': 'Blocked call from +1 (555) 0123 - Known scam number',
      'timestamp': '2 mins ago',
      'severity': 'critical',
      'icon': Icons.phone_missed,
    },
    {
      'type': 'Suspicious SMS Detected',
      'description': 'SMS contains phishing link from unknown sender',
      'timestamp': '15 mins ago',
      'severity': 'warning',
      'icon': Icons.message,
    },
    {
      'type': 'Safe Image Verified',
      'description': 'Image scanned and verified safe - No threats detected',
      'timestamp': '1 hour ago',
      'severity': 'safe',
      'icon': Icons.image,
    },
    {
      'type': 'Malware Detected',
      'description': 'Suspicious attachment blocked in SMS from +1 (555) 9876',
      'timestamp': '2 hours ago',
      'severity': 'critical',
      'icon': Icons.bug_report,
    },
    {
      'type': 'Suspicious Contact',
      'description': 'Multiple calls from unverified number flagged',
      'timestamp': '3 hours ago',
      'severity': 'warning',
      'icon': Icons.warning_amber_rounded,
    },
    {
      'type': 'Safe Call Verified',
      'description': 'Incoming call from verified contact - Safe to answer',
      'timestamp': '4 hours ago',
      'severity': 'safe',
      'icon': Icons.phone_in_talk,
    },
    {
      'type': 'Critical Threat Blocked',
      'description': 'Advanced persistent threat detected and neutralized',
      'timestamp': '5 hours ago',
      'severity': 'critical',
      'icon': Icons.shield,
    },
    {
      'type': 'Spam SMS Filtered',
      'description': 'Marketing SMS filtered to spam folder automatically',
      'timestamp': '6 hours ago',
      'severity': 'warning',
      'icon': Icons.filter_alt,
    },
  ];

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
                        // Alert Settings Card
                        _buildAlertSettingsCard(),
                        const SizedBox(height: 20),
                        // Push Notifications Status
                        _buildPushNotificationStatus(),
                        const SizedBox(height: 24),
                        // Alert History Section
                        _buildAlertHistorySection(),
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
                  'Real-Time Alerts',
                  style: TextStyle(
                    color: AppColors.trustWhite,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3,
                  ),
                ),
                Text(
                  'Threat monitoring & notifications',
                  style: TextStyle(
                    color: AppColors.trustWhite.withOpacity(0.7),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          // Active indicator
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.safeGreen.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
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
                const SizedBox(width: 6),
                Text(
                  'Active',
                  style: TextStyle(
                    color: AppColors.safeGreen,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlertSettingsCard() {
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
        crossAxisAlignment: CrossAxisAlignment.start,
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
                  Icons.notifications_active,
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
                      'Alert Settings',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Configure real-time threat alerts',
                      style: TextStyle(
                        color: AppColors.mutedSteel,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildAlertToggle(
            icon: Icons.phone,
            title: 'Call Alerts',
            subtitle: 'Notify for suspicious or scam calls',
            value: _callAlertsEnabled,
            onChanged: (value) {
              setState(() {
                _callAlertsEnabled = value;
              });
            },
          ),
          const SizedBox(height: 16),
          _buildAlertToggle(
            icon: Icons.message,
            title: 'SMS Alerts',
            subtitle: 'Notify for phishing or spam messages',
            value: _smsAlertsEnabled,
            onChanged: (value) {
              setState(() {
                _smsAlertsEnabled = value;
              });
            },
          ),
          const SizedBox(height: 16),
          _buildAlertToggle(
            icon: Icons.image,
            title: 'Image Alerts',
            subtitle: 'Notify for malicious or suspicious images',
            value: _imageAlertsEnabled,
            onChanged: (value) {
              setState(() {
                _imageAlertsEnabled = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAlertToggle({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: value
            ? AppColors.brandCyan.withOpacity(0.05)
            : AppColors.mutedSteel.withOpacity(0.05),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: value
              ? AppColors.brandCyan.withOpacity(0.2)
              : AppColors.mutedSteel.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: value
                  ? AppColors.brandCyan.withOpacity(0.15)
                  : AppColors.mutedSteel.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
              boxShadow: value
                  ? [
                      BoxShadow(
                        color: AppColors.brandCyan.withOpacity(0.3),
                        blurRadius: 12,
                        spreadRadius: 1,
                      ),
                    ]
                  : [],
            ),
            child: Icon(
              icon,
              color: value ? AppColors.brandCyan : AppColors.mutedSteel,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: AppColors.mutedSteel,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.brandCyan,
            activeTrackColor: AppColors.brandCyan.withOpacity(0.3),
            inactiveThumbColor: AppColors.mutedSteel,
            inactiveTrackColor: AppColors.mutedSteel.withOpacity(0.3),
          ),
        ],
      ),
    );
  }

  Widget _buildPushNotificationStatus() {
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
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _pushNotificationsEnabled
                  ? AppColors.brandCyan.withOpacity(0.15)
                  : AppColors.mutedSteel.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              boxShadow: _pushNotificationsEnabled
                  ? [
                      BoxShadow(
                        color: AppColors.brandCyan.withOpacity(0.3),
                        blurRadius: 16,
                        spreadRadius: 2,
                      ),
                    ]
                  : [],
            ),
            child: Icon(
              _pushNotificationsEnabled
                  ? Icons.notifications_active
                  : Icons.notifications_off,
              color: _pushNotificationsEnabled
                  ? AppColors.brandCyan
                  : AppColors.mutedSteel,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Push Notifications',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _pushNotificationsEnabled
                      ? 'Real-time alerts are enabled'
                      : 'Push notifications are disabled',
                  style: TextStyle(
                    color: _pushNotificationsEnabled
                        ? AppColors.safeGreen
                        : AppColors.mutedSteel,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: _pushNotificationsEnabled
                        ? AppColors.brandCyan.withOpacity(0.1)
                        : AppColors.mutedSteel.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _pushNotificationsEnabled
                            ? Icons.check_circle
                            : Icons.info_outline,
                        color: _pushNotificationsEnabled
                            ? AppColors.brandCyan
                            : AppColors.mutedSteel,
                        size: 12,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _pushNotificationsEnabled
                            ? 'Connected'
                            : 'Not Connected',
                        style: TextStyle(
                          color: _pushNotificationsEnabled
                              ? AppColors.brandCyan
                              : AppColors.mutedSteel,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: _pushNotificationsEnabled,
            onChanged: (value) {
              setState(() {
                _pushNotificationsEnabled = value;
              });
            },
            activeColor: AppColors.brandCyan,
            activeTrackColor: AppColors.brandCyan.withOpacity(0.3),
            inactiveThumbColor: AppColors.mutedSteel,
            inactiveTrackColor: AppColors.mutedSteel.withOpacity(0.3),
          ),
        ],
      ),
    );
  }

  Widget _buildAlertHistorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Alert History',
                  style: TextStyle(
                    color: AppColors.trustWhite,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Recent threat detections',
                  style: TextStyle(
                    color: AppColors.mutedSteel,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                _showFilterDialog();
              },
              icon: Icon(
                Icons.filter_list,
                color: AppColors.brandCyan,
                size: 24,
              ),
              style: IconButton.styleFrom(
                backgroundColor: AppColors.brandCyan.withOpacity(0.15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Alert Statistics
        _buildAlertStatistics(),
        const SizedBox(height: 16),
        // Alert History Cards
        ...(_alertHistory.map((alert) => _buildAlertCard(alert))),
      ],
    );
  }

  Widget _buildAlertStatistics() {
    final criticalCount = _alertHistory.where((a) => a['severity'] == 'critical').length;
    final warningCount = _alertHistory.where((a) => a['severity'] == 'warning').length;
    final safeCount = _alertHistory.where((a) => a['severity'] == 'safe').length;

    return Container(
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
          Expanded(
            child: _buildStatItem(
              'Critical',
              criticalCount,
              AppColors.threatRed,
              Icons.dangerous,
            ),
          ),
          Container(
            width: 1,
            height: 40,
            color: AppColors.mutedSteel.withOpacity(0.2),
          ),
          Expanded(
            child: _buildStatItem(
              'Warnings',
              warningCount,
              AppColors.warningAmber,
              Icons.warning_amber_rounded,
            ),
          ),
          Container(
            width: 1,
            height: 40,
            color: AppColors.mutedSteel.withOpacity(0.2),
          ),
          Expanded(
            child: _buildStatItem(
              'Safe',
              safeCount,
              AppColors.safeGreen,
              Icons.check_circle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, int count, Color color, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: color,
          size: 24,
        ),
        const SizedBox(height: 6),
        Text(
          count.toString(),
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            color: AppColors.mutedSteel,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildAlertCard(Map<String, dynamic> alert) {
    Color severityColor;
    Color bgColor;
    switch (alert['severity']) {
      case 'critical':
        severityColor = AppColors.threatRed;
        bgColor = AppColors.threatRed.withOpacity(0.05);
        break;
      case 'warning':
        severityColor = AppColors.warningAmber;
        bgColor = AppColors.warningAmber.withOpacity(0.05);
        break;
      case 'safe':
        severityColor = AppColors.safeGreen;
        bgColor = AppColors.safeGreen.withOpacity(0.05);
        break;
      default:
        severityColor = AppColors.mutedSteel;
        bgColor = AppColors.mutedSteel.withOpacity(0.05);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.trustWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: severityColor.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: severityColor.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Icon(
              alert['icon'],
              color: severityColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 14),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        alert['type'],
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: severityColor.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        alert['severity'].toUpperCase(),
                        style: TextStyle(
                          color: severityColor,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  alert['description'],
                  style: TextStyle(
                    color: AppColors.textPrimary.withOpacity(0.8),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      color: AppColors.mutedSteel,
                      size: 13,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      alert['timestamp'],
                      style: TextStyle(
                        color: AppColors.mutedSteel,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () => _showAlertDetails(alert),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Details',
                            style: TextStyle(
                              color: AppColors.brandCyan,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: AppColors.brandCyan,
                            size: 12,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showAlertDetails(Map<String, dynamic> alert) {
    Color severityColor;
    switch (alert['severity']) {
      case 'critical':
        severityColor = AppColors.threatRed;
        break;
      case 'warning':
        severityColor = AppColors.warningAmber;
        break;
      case 'safe':
        severityColor = AppColors.safeGreen;
        break;
      default:
        severityColor = AppColors.mutedSteel;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(alert['icon'], color: severityColor, size: 28),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Alert Details',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Type', alert['type']),
            const SizedBox(height: 12),
            _buildDetailRow('Description', alert['description']),
            const SizedBox(height: 12),
            _buildDetailRow('Timestamp', alert['timestamp']),
            const SizedBox(height: 12),
            _buildDetailRow('Severity', alert['severity'].toUpperCase()),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: severityColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: severityColor.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: severityColor, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'This alert was automatically generated by CyberShield AI threat detection system.',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Close',
              style: TextStyle(
                color: AppColors.mutedSteel,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Alert marked as reviewed'),
                  backgroundColor: AppColors.brandCyan,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.brandCyan,
              foregroundColor: AppColors.brandNavy,
            ),
            child: const Text('Mark Reviewed'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.mutedSteel,
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(Icons.filter_list, color: AppColors.brandCyan),
            const SizedBox(width: 12),
            Text(
              'Filter Alerts',
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
          children: [
            _buildFilterOption('All Alerts', true),
            _buildFilterOption('Critical Only', false),
            _buildFilterOption('Warnings Only', false),
            _buildFilterOption('Safe Only', false),
            _buildFilterOption('Last 24 Hours', false),
            _buildFilterOption('Last 7 Days', false),
          ],
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
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.brandCyan,
              foregroundColor: AppColors.brandNavy,
            ),
            child: const Text('Apply'),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterOption(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.brandCyan.withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected
                  ? AppColors.brandCyan
                  : AppColors.mutedSteel.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Icon(
                isSelected ? Icons.check_circle : Icons.circle_outlined,
                color: isSelected ? AppColors.brandCyan : AppColors.mutedSteel,
                size: 20,
              ),
              const SizedBox(width: 12),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? AppColors.brandCyan : AppColors.textPrimary,
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
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
