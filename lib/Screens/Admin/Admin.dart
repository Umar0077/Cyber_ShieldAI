import 'package:flutter/material.dart';
import 'package:cybershield_ai/constant/colors/colors.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Map<String, dynamic>> users = [
    {'name': 'John Doe', 'email': 'john.doe@email.com', 'role': 'Premium', 'status': true},
    {'name': 'Jane Smith', 'email': 'jane.smith@email.com', 'role': 'Free', 'status': true},
    {'name': 'Bob Johnson', 'email': 'bob.j@email.com', 'role': 'Premium', 'status': false},
    {'name': 'Alice Brown', 'email': 'alice.b@email.com', 'role': 'Admin', 'status': true},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
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
                // Admin Header
                _buildAdminHeader(),
                // Tab Bar
                _buildTabBar(),
                // Tab Views
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildOverviewTab(),
                      _buildUsersTab(),
                      _buildAnalyticsTab(),
                      _buildSettingsTab(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdminHeader() {
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
                width: 40,
                height: 40,
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
                  'CyberShield AI',
                  style: TextStyle(
                    color: AppColors.trustWhite,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.brandCyan.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: AppColors.brandCyan.withOpacity(0.5),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    'ADMIN PANEL',
                    style: TextStyle(
                      color: AppColors.brandCyan,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Notifications
          IconButton(
            onPressed: () {},
            icon: Stack(
              children: [
                Icon(
                  Icons.notifications_outlined,
                  color: AppColors.trustWhite,
                  size: 26,
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: AppColors.threatRed,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.brandNavy,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Settings
          IconButton(
            onPressed: () {},
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

  Widget _buildTabBar() {
    return Container(
      color: AppColors.brandNavy,
      child: TabBar(
        controller: _tabController,
        indicatorColor: AppColors.brandCyan,
        indicatorWeight: 3,
        labelColor: AppColors.brandCyan,
        unselectedLabelColor: AppColors.mutedSteel,
        labelStyle: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
        tabs: const [
          Tab(text: 'OVERVIEW'),
          Tab(text: 'USERS'),
          Tab(text: 'ANALYTICS'),
          Tab(text: 'SETTINGS'),
        ],
      ),
    );
  }

  // OVERVIEW TAB
  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // System Stats
          _buildSystemStats(),
          const SizedBox(height: 20),
          // Real-time Monitoring
          _buildRealTimeMonitoring(),
          const SizedBox(height: 20),
          // Model Management
          _buildModelManagement(),
          const SizedBox(height: 20),
          // Recent Activity
          _buildActivityLogs(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSystemStats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'System Overview',
          style: TextStyle(
            color: AppColors.trustWhite,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                icon: Icons.people_outline,
                label: 'Total Users',
                value: '1,234',
                color: AppColors.brandCyan,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                icon: Icons.shield_outlined,
                label: 'Threats Blocked',
                value: '45,678',
                color: AppColors.safeGreen,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                icon: Icons.warning_amber_outlined,
                label: 'Pending Reviews',
                value: '23',
                color: AppColors.warningAmber,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                icon: Icons.trending_up,
                label: 'Accuracy',
                value: '98.5%',
                color: AppColors.brandCyan,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
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
          color: AppColors.brandCyan.withOpacity(0.25),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.brandCyan.withOpacity(0.15),
            blurRadius: 16,
            offset: const Offset(0, 4),
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: color,
            size: 28,
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: AppColors.mutedSteel,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRealTimeMonitoring() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.safeGreen.withOpacity(0.12),
            AppColors.safeGreen.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.safeGreen.withOpacity(0.25),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.safeGreen.withOpacity(0.12),
            blurRadius: 16,
            offset: const Offset(0, 4),
            spreadRadius: 2,
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
                  Icons.monitor_heart_outlined,
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
                      'Real-Time Monitoring',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Server health & performance',
                      style: TextStyle(
                        color: AppColors.mutedSteel,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildServerHealthItem(
            label: 'API Server',
            status: 'Healthy',
            percentage: 98,
            isHealthy: true,
          ),
          const SizedBox(height: 12),
          _buildServerHealthItem(
            label: 'Database',
            status: 'Healthy',
            percentage: 95,
            isHealthy: true,
          ),
          const SizedBox(height: 12),
          _buildServerHealthItem(
            label: 'AI Model',
            status: 'Optimal',
            percentage: 99,
            isHealthy: true,
          ),
          const SizedBox(height: 12),
          _buildServerHealthItem(
            label: 'Cache Server',
            status: 'Warning',
            percentage: 75,
            isHealthy: false,
          ),
        ],
      ),
    );
  }

  Widget _buildServerHealthItem({
    required String label,
    required String status,
    required int percentage,
    required bool isHealthy,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: isHealthy ? AppColors.safeGreen : AppColors.warningAmber,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Text(
              status,
              style: TextStyle(
                color: isHealthy ? AppColors.safeGreen : AppColors.warningAmber,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: LinearProgressIndicator(
            value: percentage / 100,
            backgroundColor: AppColors.mutedSteel.withOpacity(0.2),
            valueColor: AlwaysStoppedAnimation<Color>(
              isHealthy ? AppColors.safeGreen : AppColors.warningAmber,
            ),
            minHeight: 6,
          ),
        ),
      ],
    );
  }

  Widget _buildModelManagement() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.warningAmber.withOpacity(0.12),
            AppColors.warningAmber.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.warningAmber.withOpacity(0.25),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.warningAmber.withOpacity(0.12),
            blurRadius: 16,
            offset: const Offset(0, 4),
            spreadRadius: 2,
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
                  Icons.psychology_outlined,
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
                      'AI Model Management',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Version 2.5.1 • Last updated: 2 days ago',
                      style: TextStyle(
                        color: AppColors.mutedSteel,
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.update, size: 18),
                  label: Text('Update Model'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.brandCyan,
                    foregroundColor: AppColors.brandNavy,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.auto_fix_high, size: 18),
                  label: Text('Retrain'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.brandCyan,
                    side: BorderSide(color: AppColors.brandCyan, width: 1.5),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.analytics_outlined, size: 18),
              label: Text('View Performance Metrics'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.textPrimary,
                side: BorderSide(color: AppColors.mutedSteel.withOpacity(0.4), width: 1.5),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityLogs() {
    final logs = [
      {'action': 'User registered', 'user': 'john.doe@email.com', 'time': '2 mins ago', 'type': 'info'},
      {'action': 'Model updated', 'user': 'admin', 'time': '1 hour ago', 'type': 'success'},
      {'action': 'Security alert', 'user': 'system', 'time': '3 hours ago', 'type': 'warning'},
      {'action': 'User banned', 'user': 'admin', 'time': '5 hours ago', 'type': 'danger'},
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.brandCyan.withOpacity(0.12),
            AppColors.brandCyan.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.brandCyan.withOpacity(0.25),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.brandCyan.withOpacity(0.12),
            blurRadius: 16,
            offset: const Offset(0, 4),
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Activity Logs',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'View All',
                  style: TextStyle(
                    color: AppColors.brandCyan,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...logs.map((log) => _buildActivityLogItem(
                action: log['action']!,
                user: log['user']!,
                time: log['time']!,
                type: log['type']!,
              )),
        ],
      ),
    );
  }

  Widget _buildActivityLogItem({
    required String action,
    required String user,
    required String time,
    required String type,
  }) {
    Color getTypeColor() {
      switch (type) {
        case 'success':
          return AppColors.safeGreen;
        case 'warning':
          return AppColors.warningAmber;
        case 'danger':
          return AppColors.threatRed;
        default:
          return AppColors.brandCyan;
      }
    }

    IconData getTypeIcon() {
      switch (type) {
        case 'success':
          return Icons.check_circle;
        case 'warning':
          return Icons.warning_amber_rounded;
        case 'danger':
          return Icons.error;
        default:
          return Icons.info;
      }
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: getTypeColor().withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              getTypeIcon(),
              color: getTypeColor(),
              size: 16,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  action,
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '$user • $time',
                  style: TextStyle(
                    color: AppColors.mutedSteel,
                    fontSize: 11,
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

  // USERS TAB
  Widget _buildUsersTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search and Filter
          _buildUserSearchBar(),
          const SizedBox(height: 20),
          // User Stats
          _buildUserStats(),
          const SizedBox(height: 20),
          // User Management
          _buildUserManagement(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildUserSearchBar() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.brandCyan.withOpacity(0.15),
            AppColors.brandCyan.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.brandCyan.withOpacity(0.25),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.brandCyan.withOpacity(0.12),
            blurRadius: 16,
            offset: const Offset(0, 4),
            spreadRadius: 2,
          ),
        ],
      ),
      child: TextField(
        style: TextStyle(
          color: AppColors.trustWhite,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        cursorColor: AppColors.brandCyan,
        decoration: InputDecoration(
          hintText: 'Search users...',
          hintStyle: TextStyle(
            color: AppColors.trustWhite.withOpacity(0.6),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: AppColors.trustWhite,
            size: 22,
          ),
          suffixIcon: Icon(
            Icons.filter_list,
            color: AppColors.trustWhite.withOpacity(0.8),
            size: 22,
          ),
          filled: false,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }

  Widget _buildUserStats() {
    return Row(
      children: [
        Expanded(
          child: _buildUserStatCard(
            label: 'Active',
            count: '1,156',
            color: AppColors.safeGreen,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildUserStatCard(
            label: 'Inactive',
            count: '78',
            color: AppColors.mutedSteel,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildUserStatCard(
            label: 'Banned',
            count: '12',
            color: AppColors.threatRed,
          ),
        ),
      ],
    );
  }

  Widget _buildUserStatCard({
    required String label,
    required String count,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            color.withOpacity(0.15),
            color.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.25),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.12),
            blurRadius: 16,
            offset: const Offset(0, 4),
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            count,
            style: TextStyle(
              color: color,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: AppColors.mutedSteel,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserManagement() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'User Management',
          style: TextStyle(
            color: AppColors.trustWhite,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 14),
        ...users.asMap().entries.map((entry) {
          final index = entry.key;
          final user = entry.value;
          return _buildUserCard(
            name: user['name'] as String,
            email: user['email'] as String,
            role: user['role'] as String,
            isActive: user['status'] as bool,
            onToggle: (value) {
              setState(() {
                users[index]['status'] = value;
              });
            },
          );
        }),
      ],
    );
  }

  Widget _buildUserCard({
    required String name,
    required String email,
    required String role,
    required bool isActive,
    required Function(bool) onToggle,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.brandCyan.withOpacity(0.12),
            AppColors.brandCyan.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.brandCyan.withOpacity(0.25),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.brandCyan.withOpacity(0.12),
            blurRadius: 16,
            offset: const Offset(0, 4),
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.brandCyan.withOpacity(0.1),
            child: Icon(
              Icons.person,
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
                  name,
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  email,
                  style: TextStyle(
                    color: AppColors.mutedSteel,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: _getRoleColor(role).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: _getRoleColor(role).withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    role,
                    style: TextStyle(
                      color: _getRoleColor(role),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Switch(
                value: isActive,
                onChanged: onToggle,
                activeColor: AppColors.brandCyan,
                inactiveThumbColor: AppColors.mutedSteel,
              ),
              Text(
                isActive ? 'Active' : 'Inactive',
                style: TextStyle(
                  color: isActive ? AppColors.safeGreen : AppColors.mutedSteel,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getRoleColor(String role) {
    switch (role) {
      case 'Admin':
        return AppColors.threatRed;
      case 'Premium':
        return AppColors.brandCyan;
      default:
        return AppColors.mutedSteel;
    }
  }

  // ANALYTICS TAB
  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Data Analytics Header
          Text(
            'Data Analytics',
            style: TextStyle(
              color: AppColors.trustWhite,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 14),
          // Detection Stats
          _buildDetectionStats(),
          const SizedBox(height: 20),
          // User Feedback Review
          _buildUserFeedbackReview(),
          const SizedBox(height: 20),
          // Performance Chart
          _buildPerformanceChart(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildDetectionStats() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.brandCyan.withOpacity(0.12),
            AppColors.brandCyan.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.brandCyan.withOpacity(0.25),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.brandCyan.withOpacity(0.12),
            blurRadius: 16,
            offset: const Offset(0, 4),
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Detection Statistics',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          _buildDetectionStatItem(
            icon: Icons.phone,
            label: 'Call Detections',
            count: '15,234',
            percentage: 68,
            color: AppColors.brandCyan,
          ),
          const SizedBox(height: 16),
          _buildDetectionStatItem(
            icon: Icons.sms,
            label: 'SMS Detections',
            count: '8,456',
            percentage: 45,
            color: AppColors.warningAmber,
          ),
          const SizedBox(height: 16),
          _buildDetectionStatItem(
            icon: Icons.image,
            label: 'Image Detections',
            count: '3,789',
            percentage: 32,
            color: AppColors.safeGreen,
          ),
        ],
      ),
    );
  }

  Widget _buildDetectionStatItem({
    required IconData icon,
    required String label,
    required String count,
    required int percentage,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            Text(
              count,
              style: TextStyle(
                color: color,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: LinearProgressIndicator(
            value: percentage / 100,
            backgroundColor: AppColors.mutedSteel.withOpacity(0.2),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 8,
          ),
        ),
      ],
    );
  }

  Widget _buildUserFeedbackReview() {
    final feedbacks = [
      {'user': 'john.doe@email.com', 'message': 'Detection was incorrect', 'status': 'pending'},
      {'user': 'jane.smith@email.com', 'message': 'Great accuracy!', 'status': 'resolved'},
      {'user': 'bob.j@email.com', 'message': 'False positive alert', 'status': 'pending'},
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.warningAmber.withOpacity(0.12),
            AppColors.warningAmber.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.warningAmber.withOpacity(0.25),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.warningAmber.withOpacity(0.12),
            blurRadius: 16,
            offset: const Offset(0, 4),
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'User Feedback Review',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.warningAmber.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '2 Pending',
                  style: TextStyle(
                    color: AppColors.warningAmber,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...feedbacks.map((feedback) => _buildFeedbackItem(
                user: feedback['user']!,
                message: feedback['message']!,
                isPending: feedback['status'] == 'pending',
              )),
        ],
      ),
    );
  }

  Widget _buildFeedbackItem({
    required String user,
    required String message,
    required bool isPending,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isPending
            ? AppColors.warningAmber.withOpacity(0.05)
            : AppColors.safeGreen.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isPending
              ? AppColors.warningAmber.withOpacity(0.3)
              : AppColors.safeGreen.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            isPending ? Icons.flag_outlined : Icons.check_circle_outline,
            color: isPending ? AppColors.warningAmber : AppColors.safeGreen,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user,
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  message,
                  style: TextStyle(
                    color: AppColors.mutedSteel,
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          if (isPending)
            TextButton(
              onPressed: () {},
              child: Text(
                'Review',
                style: TextStyle(
                  color: AppColors.brandCyan,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPerformanceChart() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.safeGreen.withOpacity(0.12),
            AppColors.safeGreen.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.safeGreen.withOpacity(0.25),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.safeGreen.withOpacity(0.12),
            blurRadius: 16,
            offset: const Offset(0, 4),
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Weekly Performance',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 150,
            child: _buildBarChart(),
          ),
        ],
      ),
    );
  }

  Widget _buildBarChart() {
    final data = [65, 78, 82, 70, 88, 92, 85];
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate(7, (index) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: (data[index] / 100) * 120,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        AppColors.brandCyan,
                        AppColors.brandCyan.withOpacity(0.6),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  days[index],
                  style: TextStyle(
                    color: AppColors.mutedSteel,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  // SETTINGS TAB
  Widget _buildSettingsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Security Settings
          _buildSecuritySettings(),
          const SizedBox(height: 20),
          // Data Privacy Compliance
          _buildDataPrivacyCompliance(),
          const SizedBox(height: 20),
          // System Configuration
          _buildSystemConfiguration(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSecuritySettings() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.brandCyan.withOpacity(0.12),
            AppColors.brandCyan.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.brandCyan.withOpacity(0.25),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.brandCyan.withOpacity(0.12),
            blurRadius: 16,
            offset: const Offset(0, 4),
            spreadRadius: 2,
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
                  Icons.security,
                  color: AppColors.brandCyan,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Security Settings',
                style: TextStyle(
                  color: AppColors.trustWhite,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildSecuritySettingItem(
            label: 'Two-Factor Authentication',
            isEnabled: true,
          ),
          const SizedBox(height: 12),
          _buildSecuritySettingItem(
            label: 'Role-Based Access Control',
            isEnabled: true,
          ),
          const SizedBox(height: 12),
          _buildSecuritySettingItem(
            label: 'Audit Logs',
            isEnabled: true,
          ),
          const SizedBox(height: 12),
          _buildSecuritySettingItem(
            label: 'IP Whitelist',
            isEnabled: false,
          ),
        ],
      ),
    );
  }

  Widget _buildSecuritySettingItem({
    required String label,
    required bool isEnabled,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.trustWhite,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        Switch(
          value: isEnabled,
          onChanged: (value) {},
          activeColor: AppColors.brandCyan,
          inactiveThumbColor: AppColors.mutedSteel,
        ),
      ],
    );
  }

  Widget _buildDataPrivacyCompliance() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.safeGreen.withOpacity(0.12),
            AppColors.safeGreen.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.safeGreen.withOpacity(0.25),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.safeGreen.withOpacity(0.12),
            blurRadius: 16,
            offset: const Offset(0, 4),
            spreadRadius: 2,
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
                  Icons.lock_outline,
                  color: AppColors.brandCyan,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Data Privacy Compliance',
                  style: TextStyle(
                    color: AppColors.trustWhite,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.safeGreen.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'COMPLIANT',
                  style: TextStyle(
                    color: AppColors.safeGreen,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildComplianceItem(
            label: 'GDPR Compliance',
            status: 'Active',
            isCompliant: true,
          ),
          const SizedBox(height: 12),
          _buildComplianceItem(
            label: 'CCPA Compliance',
            status: 'Active',
            isCompliant: true,
          ),
          const SizedBox(height: 12),
          _buildComplianceItem(
            label: 'Data Encryption',
            status: 'AES-256',
            isCompliant: true,
          ),
          const SizedBox(height: 12),
          _buildComplianceItem(
            label: 'Data Retention',
            status: '90 days',
            isCompliant: true,
          ),
        ],
      ),
    );
  }

  Widget _buildComplianceItem({
    required String label,
    required String status,
    required bool isCompliant,
  }) {
    return Row(
      children: [
        Icon(
          isCompliant ? Icons.check_circle : Icons.warning_amber_rounded,
          color: isCompliant ? AppColors.safeGreen : AppColors.warningAmber,
          size: 20,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              color: AppColors.trustWhite,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Text(
          status,
          style: TextStyle(
            color: AppColors.trustWhite.withOpacity(0.8),
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildSystemConfiguration() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.brandCyan.withOpacity(0.12),
            AppColors.brandCyan.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.brandCyan.withOpacity(0.25),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.brandCyan.withOpacity(0.12),
            blurRadius: 16,
            offset: const Offset(0, 4),
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'System Configuration',
            style: TextStyle(
              color: AppColors.trustWhite,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildConfigItem(
            icon: Icons.dns_outlined,
            label: 'API Endpoint',
            value: 'api.cybershield.ai',
          ),
          const SizedBox(height: 12),
          _buildConfigItem(
            icon: Icons.storage_outlined,
            label: 'Database',
            value: 'PostgreSQL 14.2',
          ),
          const SizedBox(height: 12),
          _buildConfigItem(
            icon: Icons.cloud_outlined,
            label: 'Cloud Provider',
            value: 'AWS us-east-1',
          ),
          const SizedBox(height: 12),
          _buildConfigItem(
            icon: Icons.memory_outlined,
            label: 'Cache Server',
            value: 'Redis 7.0',
          ),
        ],
      ),
    );
  }

  Widget _buildConfigItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.brandCyan,
          size: 20,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              color: AppColors.trustWhite,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: AppColors.trustWhite.withOpacity(0.8),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
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
