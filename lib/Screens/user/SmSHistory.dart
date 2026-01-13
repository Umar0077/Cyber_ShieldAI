import 'package:flutter/material.dart';
import 'package:cybershield_ai/constant/colors/colors.dart';
import 'package:cybershield_ai/Screens/user/MainNavigation.dart';

class SMSHistoryScreen extends StatefulWidget {
  const SMSHistoryScreen({Key? key}) : super(key: key);

  @override
  State<SMSHistoryScreen> createState() => _SMSHistoryScreenState();
}

class _SMSHistoryScreenState extends State<SMSHistoryScreen> {
  bool _isDetectionActive = true;
  final TextEditingController _manualCheckController = TextEditingController();
  bool _isCheckingMessage = false;
  Set<int> _selectedIndices = {};

  final List<Map<String, dynamic>> _smsLogs = [
    {
      'sender': 'Unknown',
      'number': '+1 (555) 111-2222',
      'message':
          'URGENT! Your bank account has been compromised. Click here immediately to secure: http://fakepbank.com/secure',
      'time': '10:45 AM',
      'date': 'Today',
      'isScam': true,
    },
    {
      'sender': 'John Smith',
      'number': '+1 (555) 987-6543',
      'message': 'Hey! Are we still meeting for lunch at 1pm?',
      'time': '9:30 AM',
      'date': 'Today',
      'isScam': false,
    },
    {
      'sender': 'Prize Alert',
      'number': '+1 (555) 999-8888',
      'message':
          'Congratulations! You have won \$5000. Claim your prize now by providing your credit card details.',
      'time': '8:15 AM',
      'date': 'Today',
      'isScam': true,
    },
    {
      'sender': 'Sarah Johnson',
      'number': '+1 (555) 234-5678',
      'message': 'Thanks for the meeting notes! See you tomorrow.',
      'time': '5:20 PM',
      'date': 'Yesterday',
      'isScam': false,
    },
    {
      'sender': 'Delivery Service',
      'number': '+1 (555) 777-6666',
      'message':
          'Your package delivery failed. Update your address and payment info at: http://fake-delivery.com',
      'time': '2:10 PM',
      'date': 'Yesterday',
      'isScam': true,
    },
    {
      'sender': 'Mom',
      'number': '+1 (555) 345-6789',
      'message': 'Don\'t forget to call your grandmother today!',
      'time': '11:00 AM',
      'date': 'Yesterday',
      'isScam': false,
    },
    {
      'sender': 'Tax Department',
      'number': '+1 (555) 444-3333',
      'message':
          'You owe \$2500 in back taxes. Pay immediately or face legal action. Reply with SSN to verify.',
      'time': '3:45 PM',
      'date': '2 days ago',
      'isScam': true,
    },
  ];

  @override
  void dispose() {
    _manualCheckController.dispose();
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
                // Detection Toggle
                _buildDetectionToggle(),
                // Manual Check Card
                _buildManualCheckCard(),
                // Bulk Actions Bar
                if (_selectedIndices.isNotEmpty) _buildBulkActionsBar(),
                // SMS Logs
                Expanded(
                  child: _buildSMSLogs(),
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
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MainNavigationScreen()),
              );
            },
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
                  'SMS History',
                  style: TextStyle(
                    color: AppColors.trustWhite,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3,
                  ),
                ),
                Text(
                  '${_smsLogs.length} messages',
                  style: TextStyle(
                    color: AppColors.trustWhite.withOpacity(0.7),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetectionToggle() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.brandCyan.withOpacity(0.15),
            AppColors.brandCyan.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.brandCyan.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.brandCyan.withOpacity(0.1),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _isDetectionActive
                  ? AppColors.brandCyan.withOpacity(0.1)
                  : AppColors.mutedSteel.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              _isDetectionActive ? Icons.shield : Icons.shield_outlined,
              color: _isDetectionActive
                  ? AppColors.brandCyan
                  : AppColors.mutedSteel,
              size: 24,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SMS Scam Detection',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  _isDetectionActive ? 'Active & Scanning' : 'Paused',
                  style: TextStyle(
                    color: _isDetectionActive
                        ? AppColors.safeGreen
                        : AppColors.mutedSteel,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          // Toggle Switch
          Switch(
            value: _isDetectionActive,
            onChanged: (value) {
              setState(() {
                _isDetectionActive = value;
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

  Widget _buildManualCheckCard() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.safeGreen.withOpacity(0.12),
            AppColors.safeGreen.withOpacity(0.04),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.safeGreen.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.safeGreen.withOpacity(0.1),
            blurRadius: 16,
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
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.brandCyan.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.search,
                  color: AppColors.brandCyan,
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'Manual SMS Check',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          TextFormField(
            controller: _manualCheckController,
            maxLines: 3,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintText: 'Paste SMS text here to check for scams...',
              hintStyle: TextStyle(
                color: AppColors.mutedSteel.withOpacity(0.6),
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.all(14),
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
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: _isCheckingMessage ? null : _handleCheckSMS,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.brandCyan,
                foregroundColor: AppColors.brandNavy,
                disabledBackgroundColor: AppColors.mutedSteel.withOpacity(0.3),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: _isCheckingMessage
                  ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.brandNavy,
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.security, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          'Check SMS',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulkActionsBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.brandCyan.withOpacity(0.2),
            AppColors.brandCyan.withOpacity(0.12),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.brandCyan.withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.brandCyan.withOpacity(0.15),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            Icons.check_circle,
            color: AppColors.brandCyan,
            size: 22,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              '${_selectedIndices.length} selected',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          OutlinedButton.icon(
            onPressed: _handleBulkReport,
            icon: Icon(Icons.flag_outlined, size: 16),
            label: Text('Report All'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.warningAmber,
              side: BorderSide(color: AppColors.warningAmber, width: 1.5),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: () {
              setState(() {
                _selectedIndices.clear();
              });
            },
            icon: Icon(Icons.close, color: AppColors.mutedSteel),
            style: IconButton.styleFrom(
              backgroundColor: AppColors.mutedSteel.withOpacity(0.1),
              padding: const EdgeInsets.all(8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSMSLogs() {
    if (_smsLogs.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.message_outlined,
              color: AppColors.mutedSteel.withOpacity(0.5),
              size: 64,
            ),
            const SizedBox(height: 16),
            Text(
              'No messages found',
              style: TextStyle(
                color: AppColors.trustWhite.withOpacity(0.7),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      itemCount: _smsLogs.length,
      itemBuilder: (context, index) {
        final sms = _smsLogs[index];
        final isSelected = _selectedIndices.contains(index);
        return _buildSMSLogCard(sms, index, isSelected);
      },
    );
  }

  Widget _buildSMSLogCard(Map<String, dynamic> sms, int index, bool isSelected) {
    final isScam = sms['isScam'] as bool;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isSelected
              ? [
                  AppColors.brandCyan.withOpacity(0.2),
                  AppColors.brandCyan.withOpacity(0.1),
                ]
              : (isScam
                  ? [
                      AppColors.threatRed.withOpacity(0.15),
                      AppColors.threatRed.withOpacity(0.05),
                    ]
                  : [
                      AppColors.safeGreen.withOpacity(0.12),
                      AppColors.safeGreen.withOpacity(0.04),
                    ]),
        ),
        borderRadius: BorderRadius.circular(16),
        border: isSelected
            ? Border.all(color: AppColors.brandCyan, width: 2)
            : Border.all(
                color: isScam
                    ? AppColors.threatRed.withOpacity(0.3)
                    : AppColors.safeGreen.withOpacity(0.3),
                width: 1,
              ),
        boxShadow: [
          BoxShadow(
            color: isSelected
                ? AppColors.brandCyan.withOpacity(0.2)
                : (isScam
                    ? AppColors.threatRed.withOpacity(0.12)
                    : AppColors.safeGreen.withOpacity(0.12)),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with checkbox and status
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: Row(
              children: [
                // Checkbox
                Checkbox(
                  value: isSelected,
                  onChanged: (value) {
                    setState(() {
                      if (value == true) {
                        _selectedIndices.add(index);
                      } else {
                        _selectedIndices.remove(index);
                      }
                    });
                  },
                  activeColor: AppColors.brandCyan,
                  checkColor: AppColors.brandNavy,
                  side: BorderSide(
                    color: AppColors.mutedSteel,
                    width: 1.5,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 8),
                // Status Icon
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isScam
                        ? AppColors.threatRed.withOpacity(0.1)
                        : AppColors.safeGreen.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    isScam
                        ? Icons.shield_outlined
                        : Icons.check_circle_outline,
                    color: isScam ? AppColors.threatRed : AppColors.safeGreen,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                // Sender Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              sms['sender'],
                              style: TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          if (isScam)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.threatRed.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                'SCAM',
                                style: TextStyle(
                                  color: AppColors.threatRed,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        sms['number'],
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
          ),
          // Message Preview
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isScam
                    ? AppColors.threatRed.withOpacity(0.05)
                    : AppColors.mutedSteel.withOpacity(0.05),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isScam
                      ? AppColors.threatRed.withOpacity(0.2)
                      : AppColors.mutedSteel.withOpacity(0.15),
                  width: 1,
                ),
              ),
              child: Text(
                sms['message'],
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  height: 1.4,
                ),
              ),
            ),
          ),
          // Time and Actions
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Row(
              children: [
                Icon(
                  Icons.access_time,
                  color: AppColors.mutedSteel,
                  size: 14,
                ),
                const SizedBox(width: 6),
                Text(
                  '${sms['time']} • ${sms['date']}',
                  style: TextStyle(
                    color: AppColors.mutedSteel,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                // View Full Button
                TextButton(
                  onPressed: () {
                    _showFullMessageDialog(sms);
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.brandCyan,
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    'View Full',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (isScam) ...[
                  const SizedBox(width: 12),
                  OutlinedButton.icon(
                    onPressed: () {
                      _showReportDialog(sms);
                    },
                    icon: Icon(Icons.flag_outlined, size: 14),
                    label: Text('Report'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.warningAmber,
                      side: BorderSide(
                        color: AppColors.warningAmber,
                        width: 1.5,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleCheckSMS() async {
    if (_manualCheckController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please enter SMS text to check'),
          backgroundColor: AppColors.warningAmber,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
      return;
    }

    setState(() {
      _isCheckingMessage = true;
    });

    // Simulate AI checking
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isCheckingMessage = false;
    });

    // Show result
    final isScam = _manualCheckController.text.toLowerCase().contains('urgent') ||
        _manualCheckController.text.toLowerCase().contains('click') ||
        _manualCheckController.text.toLowerCase().contains('prize');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(
              isScam ? Icons.warning : Icons.check_circle,
              color: isScam ? AppColors.threatRed : AppColors.safeGreen,
              size: 28,
            ),
            const SizedBox(width: 10),
            Text(
              isScam ? 'Scam Detected!' : 'Message Safe',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Text(
          isScam
              ? 'This message contains suspicious content and may be a scam attempt.'
              : 'No scam indicators detected in this message.',
          style: TextStyle(
            color: AppColors.mutedSteel,
            fontSize: 14,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _manualCheckController.clear();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showFullMessageDialog(Map<String, dynamic> sms) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    sms['sender'],
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (sms['isScam'])
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.threatRed.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'SCAM',
                      style: TextStyle(
                        color: AppColors.threatRed,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              sms['number'],
              style: TextStyle(
                color: AppColors.mutedSteel,
                fontSize: 13,
              ),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Text(
            sms['message'],
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showReportDialog(Map<String, dynamic> sms) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.report_outlined, color: AppColors.warningAmber),
            const SizedBox(width: 10),
            Text(
              'Report SMS',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Text(
          'Report this message as spam or scam to help improve our detection system.',
          style: TextStyle(
            color: AppColors.mutedSteel,
            fontSize: 14,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Message reported successfully'),
                  backgroundColor: AppColors.safeGreen,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.warningAmber,
              foregroundColor: AppColors.brandNavy,
            ),
            child: Text('Report'),
          ),
        ],
      ),
    );
  }

  void _handleBulkReport() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.report_outlined, color: AppColors.warningAmber),
            const SizedBox(width: 10),
            Text(
              'Bulk Report',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Text(
          'Report ${_selectedIndices.length} selected messages as spam/scam?',
          style: TextStyle(
            color: AppColors.mutedSteel,
            fontSize: 14,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _selectedIndices.clear();
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Messages reported successfully'),
                  backgroundColor: AppColors.safeGreen,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.warningAmber,
              foregroundColor: AppColors.brandNavy,
            ),
            child: Text('Report All'),
          ),
        ],
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
