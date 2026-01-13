import 'package:flutter/material.dart';
import 'package:cybershield_ai/constant/colors/colors.dart';

class ActivityLogPage extends StatefulWidget {
  const ActivityLogPage({Key? key}) : super(key: key);

  @override
  State<ActivityLogPage> createState() => _ActivityLogPageState();
}

class _ActivityLogPageState extends State<ActivityLogPage> {
  String _selectedUserFilter = 'All Users';
  String _selectedDateFilter = 'Last 7 Days';
  String _selectedActivityType = 'All Activities';
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _activityLogs = [
    {
      'user': 'admin@cybershield.ai',
      'action': 'Model Update',
      'description': 'Updated AI model to version 2.5.1',
      'timestamp': '2 mins ago',
      'type': 'safe',
      'icon': Icons.update,
    },
    {
      'user': 'john.doe@email.com',
      'action': 'User Registration',
      'description': 'New user account created',
      'timestamp': '15 mins ago',
      'type': 'safe',
      'icon': Icons.person_add,
    },
    {
      'user': 'system',
      'action': 'Security Alert',
      'description': 'Multiple failed login attempts detected',
      'timestamp': '1 hour ago',
      'type': 'critical',
      'icon': Icons.warning,
    },
    {
      'user': 'jane.smith@email.com',
      'action': 'Image Detection',
      'description': 'Analyzed image for authenticity',
      'timestamp': '2 hours ago',
      'type': 'safe',
      'icon': Icons.image,
    },
    {
      'user': 'admin@cybershield.ai',
      'action': 'User Ban',
      'description': 'Banned user for policy violation',
      'timestamp': '3 hours ago',
      'type': 'critical',
      'icon': Icons.block,
    },
    {
      'user': 'bob.johnson@email.com',
      'action': 'Suspicious Activity',
      'description': 'Unusual login pattern detected',
      'timestamp': '5 hours ago',
      'type': 'suspicious',
      'icon': Icons.flag,
    },
    {
      'user': 'alice.brown@email.com',
      'action': 'Call Detection',
      'description': 'Scam call blocked successfully',
      'timestamp': '6 hours ago',
      'type': 'safe',
      'icon': Icons.phone_disabled,
    },
    {
      'user': 'system',
      'action': 'Database Backup',
      'description': 'Automated backup completed',
      'timestamp': '8 hours ago',
      'type': 'safe',
      'icon': Icons.backup,
    },
    {
      'user': 'admin@cybershield.ai',
      'action': 'Permission Change',
      'description': 'Modified user role permissions',
      'timestamp': '10 hours ago',
      'type': 'suspicious',
      'icon': Icons.shield,
    },
    {
      'user': 'system',
      'action': 'Critical Error',
      'description': 'API service temporarily unavailable',
      'timestamp': '12 hours ago',
      'type': 'critical',
      'icon': Icons.error,
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
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
                        // Search Bar
                        _buildSearchBar(),
                        const SizedBox(height: 16),
                        // Filters
                        _buildFilters(),
                        const SizedBox(height: 20),
                        // Export Button
                        _buildExportButton(),
                        const SizedBox(height: 20),
                        // Activity Logs
                        _buildActivityLogsSection(),
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
                  'Activity Logs',
                  style: TextStyle(
                    color: AppColors.trustWhite,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3,
                  ),
                ),
                Text(
                  'System activity monitoring',
                  style: TextStyle(
                    color: AppColors.trustWhite.withOpacity(0.7),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          // Refresh button
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Activity logs refreshed'),
                  backgroundColor: AppColors.safeGreen,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            },
            icon: Icon(
              Icons.refresh,
              color: AppColors.brandCyan,
              size: 26,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.trustWhite,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        style: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: 'Search activity logs...',
          hintStyle: TextStyle(
            color: AppColors.mutedSteel.withOpacity(0.6),
            fontSize: 14,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: AppColors.brandCyan,
            size: 22,
          ),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      _searchController.clear();
                    });
                  },
                  icon: Icon(
                    Icons.clear,
                    color: AppColors.mutedSteel,
                    size: 20,
                  ),
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
        onChanged: (value) {
          setState(() {});
        },
      ),
    );
  }

  Widget _buildFilters() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Filters',
          style: TextStyle(
            color: AppColors.trustWhite,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildFilterDropdown(
                label: 'User',
                value: _selectedUserFilter,
                items: ['All Users', 'Admins', 'Regular Users', 'System'],
                onChanged: (value) {
                  setState(() {
                    _selectedUserFilter = value!;
                  });
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildFilterDropdown(
                label: 'Date',
                value: _selectedDateFilter,
                items: ['Last 7 Days', 'Last 30 Days', 'Last 3 Months', 'All Time'],
                onChanged: (value) {
                  setState(() {
                    _selectedDateFilter = value!;
                  });
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildFilterDropdown(
          label: 'Activity Type',
          value: _selectedActivityType,
          items: ['All Activities', 'Safe', 'Suspicious', 'Critical'],
          onChanged: (value) {
            setState(() {
              _selectedActivityType = value!;
            });
          },
        ),
      ],
    );
  }

  Widget _buildFilterDropdown({
    required String label,
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.trustWhite,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: Icon(
            Icons.arrow_drop_down,
            color: AppColors.brandCyan,
          ),
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildExportButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton.icon(
        onPressed: () {
          _showExportDialog();
        },
        icon: Icon(Icons.file_download_outlined, size: 20),
        label: Text(
          'Export Activity Logs',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.brandCyan,
          foregroundColor: AppColors.brandNavy,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          shadowColor: AppColors.brandCyan.withOpacity(0.3),
        ),
      ),
    );
  }

  Widget _buildActivityLogsSection() {
    return Container(
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
          // Header
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Recent Activity',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${_activityLogs.length} entries',
                      style: TextStyle(
                        color: AppColors.mutedSteel,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.brandCyan.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.brandCyan.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
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
                        'Live',
                        style: TextStyle(
                          color: AppColors.brandCyan,
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
          ),
          // Activity Log Entries
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _activityLogs.length,
            separatorBuilder: (context, index) => Divider(
              color: AppColors.mutedSteel.withOpacity(0.1),
              height: 1,
              indent: 20,
              endIndent: 20,
            ),
            itemBuilder: (context, index) {
              return _buildActivityLogItem(_activityLogs[index]);
            },
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildActivityLogItem(Map<String, dynamic> log) {
    Color getTypeColor(String type) {
      switch (type) {
        case 'safe':
          return AppColors.safeGreen;
        case 'suspicious':
          return AppColors.warningAmber;
        case 'critical':
          return AppColors.threatRed;
        default:
          return AppColors.mutedSteel;
      }
    }

    return InkWell(
      onTap: () {
        _showActivityDetails(log);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: getTypeColor(log['type']).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                log['icon'],
                color: getTypeColor(log['type']),
                size: 20,
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
                          log['action'],
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: getTypeColor(log['type']).withOpacity(0.15),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: getTypeColor(log['type']).withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          log['type'].toUpperCase(),
                          style: TextStyle(
                            color: getTypeColor(log['type']),
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    log['description'],
                    style: TextStyle(
                      color: AppColors.textPrimary.withOpacity(0.8),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.person_outline,
                        color: AppColors.mutedSteel,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        log['user'],
                        style: TextStyle(
                          color: AppColors.mutedSteel,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Icon(
                        Icons.access_time,
                        color: AppColors.mutedSteel,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        log['timestamp'],
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
            const SizedBox(width: 8),
            Icon(
              Icons.arrow_forward_ios,
              color: AppColors.mutedSteel.withOpacity(0.5),
              size: 14,
            ),
          ],
        ),
      ),
    );
  }

  void _showActivityDetails(Map<String, dynamic> log) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(
              log['icon'],
              color: AppColors.brandCyan,
              size: 24,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Activity Details',
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
            _buildDetailRow('Action', log['action']),
            const SizedBox(height: 12),
            _buildDetailRow('User', log['user']),
            const SizedBox(height: 12),
            _buildDetailRow('Description', log['description']),
            const SizedBox(height: 12),
            _buildDetailRow('Timestamp', log['timestamp']),
            const SizedBox(height: 12),
            _buildDetailRow('Type', log['type'].toUpperCase()),
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

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: TextStyle(
              color: AppColors.mutedSteel,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  void _showExportDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(
              Icons.file_download_outlined,
              color: AppColors.brandCyan,
              size: 24,
            ),
            const SizedBox(width: 12),
            Text(
              'Export Logs',
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
              'Select export format:',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            _buildExportOption('CSV', Icons.table_chart),
            const SizedBox(height: 12),
            _buildExportOption('PDF', Icons.picture_as_pdf),
            const SizedBox(height: 12),
            _buildExportOption('JSON', Icons.code),
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
        ],
      ),
    );
  }

  Widget _buildExportOption(String format, IconData icon) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Exporting logs as $format...'),
            backgroundColor: AppColors.brandCyan,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
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
              icon,
              color: AppColors.brandCyan,
              size: 24,
            ),
            const SizedBox(width: 12),
            Text(
              format,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: AppColors.mutedSteel,
              size: 16,
            ),
          ],
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
