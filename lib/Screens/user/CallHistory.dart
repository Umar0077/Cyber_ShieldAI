import 'package:flutter/material.dart';
import 'package:cybershield_ai/constant/colors/colors.dart';
import 'package:cybershield_ai/Screens/user/MainNavigation.dart';

class CallHistoryScreen extends StatefulWidget {
  const CallHistoryScreen({Key? key}) : super(key: key);

  @override
  State<CallHistoryScreen> createState() => _CallHistoryScreenState();
}

class _CallHistoryScreenState extends State<CallHistoryScreen> {
  bool _isDetectionActive = true;
  String _selectedDateFilter = 'All Time';
  String _selectedScamFilter = 'All Calls';

  final List<Map<String, dynamic>> _callLogs = [
    {
      'name': 'Unknown Caller',
      'number': '+1 (555) 123-4567',
      'duration': '0:15',
      'time': '10:30 AM',
      'date': 'Today',
      'isScam': true,
      'hasRecording': true,
      'callType': 'incoming',
    },
    {
      'name': 'John Smith',
      'number': '+1 (555) 987-6543',
      'duration': '5:42',
      'time': '9:15 AM',
      'date': 'Today',
      'isScam': false,
      'hasRecording': true,
      'callType': 'outgoing',
    },
    {
      'name': 'Scam Alert',
      'number': '+1 (555) 666-7777',
      'duration': '0:08',
      'time': '8:45 AM',
      'date': 'Today',
      'isScam': true,
      'hasRecording': true,
      'callType': 'incoming',
    },
    {
      'name': 'Sarah Johnson',
      'number': '+1 (555) 234-5678',
      'duration': '12:30',
      'time': '2:20 PM',
      'date': 'Yesterday',
      'isScam': false,
      'hasRecording': false,
      'callType': 'incoming',
    },
    {
      'name': 'Unknown',
      'number': '+1 (555) 888-9999',
      'duration': '0:05',
      'time': '11:30 AM',
      'date': 'Yesterday',
      'isScam': true,
      'hasRecording': true,
      'callType': 'missed',
    },
    {
      'name': 'Michael Brown',
      'number': '+1 (555) 345-6789',
      'duration': '8:15',
      'time': '4:45 PM',
      'date': '2 days ago',
      'isScam': false,
      'hasRecording': true,
      'callType': 'outgoing',
    },
    {
      'name': 'Spam Risk',
      'number': '+1 (555) 111-2222',
      'duration': '0:12',
      'time': '3:10 PM',
      'date': '2 days ago',
      'isScam': true,
      'hasRecording': true,
      'callType': 'incoming',
    },
  ];

  List<Map<String, dynamic>> get _filteredCallLogs {
    return _callLogs.where((call) {
      // Filter by scam status
      if (_selectedScamFilter == 'Scam Only' && !call['isScam']) return false;
      if (_selectedScamFilter == 'Safe Only' && call['isScam']) return false;

      // Filter by date
      if (_selectedDateFilter == 'Today' && call['date'] != 'Today') return false;
      if (_selectedDateFilter == 'Yesterday' && call['date'] != 'Yesterday')
        return false;

      return true;
    }).toList();
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
                // Detection Toggle and Stats
                _buildDetectionToggle(),
                // Filters
                _buildFilters(),
                // Call Logs
                Expanded(
                  child: _buildCallLogs(),
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
                  'Call History',
                  style: TextStyle(
                    color: AppColors.trustWhite,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3,
                  ),
                ),
                Text(
                  '${_filteredCallLogs.length} calls',
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
      margin: const EdgeInsets.all(20),
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
                  'Scam Detection',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  _isDetectionActive ? 'Active & Monitoring' : 'Paused',
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

  Widget _buildFilters() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Filter By',
            style: TextStyle(
              color: AppColors.trustWhite,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                // Date Filters
                _buildFilterChip(
                  label: 'All Time',
                  isSelected: _selectedDateFilter == 'All Time',
                  onTap: () {
                    setState(() {
                      _selectedDateFilter = 'All Time';
                    });
                  },
                ),
                const SizedBox(width: 10),
                _buildFilterChip(
                  label: 'Today',
                  isSelected: _selectedDateFilter == 'Today',
                  onTap: () {
                    setState(() {
                      _selectedDateFilter = 'Today';
                    });
                  },
                ),
                const SizedBox(width: 10),
                _buildFilterChip(
                  label: 'Yesterday',
                  isSelected: _selectedDateFilter == 'Yesterday',
                  onTap: () {
                    setState(() {
                      _selectedDateFilter = 'Yesterday';
                    });
                  },
                ),
                const SizedBox(width: 20),
                // Divider
                Container(
                  width: 1,
                  height: 30,
                  color: AppColors.mutedSteel.withOpacity(0.3),
                ),
                const SizedBox(width: 20),
                // Scam Filters
                _buildFilterChip(
                  label: 'All Calls',
                  isSelected: _selectedScamFilter == 'All Calls',
                  onTap: () {
                    setState(() {
                      _selectedScamFilter = 'All Calls';
                    });
                  },
                ),
                const SizedBox(width: 10),
                _buildFilterChip(
                  label: 'Scam Only',
                  isSelected: _selectedScamFilter == 'Scam Only',
                  onTap: () {
                    setState(() {
                      _selectedScamFilter = 'Scam Only';
                    });
                  },
                  icon: Icons.warning_outlined,
                ),
                const SizedBox(width: 10),
                _buildFilterChip(
                  label: 'Safe Only',
                  isSelected: _selectedScamFilter == 'Safe Only',
                  onTap: () {
                    setState(() {
                      _selectedScamFilter = 'Safe Only';
                    });
                  },
                  icon: Icons.check_circle_outline,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildFilterChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    IconData? icon,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.brandCyan,
                    AppColors.brandCyan.withOpacity(0.9),
                  ],
                )
              : LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.trustWhite.withOpacity(0.15),
                    AppColors.trustWhite.withOpacity(0.08),
                  ],
                ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? AppColors.brandCyan
                : AppColors.mutedSteel.withOpacity(0.3),
            width: 1.5,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.brandCyan.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 3),
                  ),
                ]
              : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 16,
                color: isSelected ? AppColors.brandNavy : AppColors.mutedSteel,
              ),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppColors.brandNavy : AppColors.mutedSteel,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCallLogs() {
    if (_filteredCallLogs.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.phone_disabled_outlined,
              color: AppColors.mutedSteel.withOpacity(0.5),
              size: 64,
            ),
            const SizedBox(height: 16),
            Text(
              'No calls found',
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
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: _filteredCallLogs.length,
      itemBuilder: (context, index) {
        final call = _filteredCallLogs[index];
        return _buildCallLogCard(call);
      },
    );
  }

  Widget _buildCallLogCard(Map<String, dynamic> call) {
    final isScam = call['isScam'] as bool;
    final hasRecording = call['hasRecording'] as bool;
    final callType = call['callType'] as String;

    IconData callTypeIcon;
    switch (callType) {
      case 'incoming':
        callTypeIcon = Icons.call_received;
        break;
      case 'outgoing':
        callTypeIcon = Icons.call_made;
        break;
      case 'missed':
        callTypeIcon = Icons.call_missed;
        break;
      default:
        callTypeIcon = Icons.phone;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isScam
              ? [
                  AppColors.threatRed.withOpacity(0.15),
                  AppColors.threatRed.withOpacity(0.05),
                ]
              : [
                  AppColors.safeGreen.withOpacity(0.12),
                  AppColors.safeGreen.withOpacity(0.04),
                ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isScam
              ? AppColors.threatRed.withOpacity(0.3)
              : AppColors.safeGreen.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isScam
                ? AppColors.threatRed.withOpacity(0.12)
                : AppColors.safeGreen.withOpacity(0.12),
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
                  isScam ? Icons.warning_outlined : Icons.check_circle_outline,
                  color: isScam ? AppColors.threatRed : AppColors.safeGreen,
                  size: 24,
                ),
              ),
              const SizedBox(width: 14),
              // Call Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            call['name'],
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
                    Row(
                      children: [
                        Icon(
                          callTypeIcon,
                          color: AppColors.mutedSteel,
                          size: 14,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          call['number'],
                          style: TextStyle(
                            color: AppColors.mutedSteel,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Play Recording Button
              if (hasRecording)
                IconButton(
                  onPressed: () {
                    _showPlayRecordingDialog(call);
                  },
                  icon: Icon(
                    Icons.play_circle_outline,
                    color: AppColors.brandCyan,
                    size: 28,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          // Call Details
          Row(
            children: [
              _buildCallDetail(
                icon: Icons.access_time,
                text: call['time'],
              ),
              const SizedBox(width: 16),
              _buildCallDetail(
                icon: Icons.calendar_today,
                text: call['date'],
              ),
              const SizedBox(width: 16),
              _buildCallDetail(
                icon: Icons.timer_outlined,
                text: call['duration'],
              ),
            ],
          ),
          if (isScam) ...[
            const SizedBox(height: 12),
            // Report Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  _showReportDialog(call);
                },
                icon: Icon(Icons.flag_outlined, size: 16),
                label: Text('Report this call'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.warningAmber,
                  side: BorderSide(
                    color: AppColors.warningAmber,
                    width: 1.5,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCallDetail({required IconData icon, required String text}) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.mutedSteel,
          size: 14,
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            color: AppColors.mutedSteel,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  void _showPlayRecordingDialog(Map<String, dynamic> call) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.headset, color: AppColors.brandCyan),
            const SizedBox(width: 10),
            Text(
              'Play Recording',
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
              'Call from: ${call['name']}',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              call['number'],
              style: TextStyle(
                color: AppColors.mutedSteel,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.brandCyan.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.play_circle_filled,
                      color: AppColors.brandCyan, size: 32),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Recording ready',
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Duration: ${call['duration']}',
                          style: TextStyle(
                            color: AppColors.mutedSteel,
                            fontSize: 12,
                          ),
                        ),
                      ],
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
            child: Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement play recording
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.brandCyan,
              foregroundColor: AppColors.brandNavy,
            ),
            child: Text('Play'),
          ),
        ],
      ),
    );
  }

  void _showReportDialog(Map<String, dynamic> call) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.report_outlined, color: AppColors.warningAmber),
            const SizedBox(width: 10),
            Text(
              'Report Call',
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
            Text(
              'Report this call as spam or scam to help improve our detection system.',
              style: TextStyle(
                color: AppColors.mutedSteel,
                fontSize: 14,
              ),
            ),
          ],
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
                  content: Text('Call reported successfully'),
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
