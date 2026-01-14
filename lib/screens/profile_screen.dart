import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:task_flow/providers/auth_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: GoogleFonts.inter(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(EvaIcons.edit2Outline),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          _buildProfileHeader(),
          const SizedBox(height: 30),
          _buildStats(),
          const SizedBox(height: 30),
          _buildSettingsGroup(
            title: 'ACCOUNT',
            children: [
              _buildSettingsTile(
                icon: EvaIcons.shieldOutline,
                title: 'Account Security',
                onTap: () {},
              ),
              _buildSettingsTile(
                icon: EvaIcons.personOutline,
                title: 'Personal Information',
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 30),
          _buildSettingsGroup(
            title: 'PREFERENCES',
            children: [
              _buildSettingsTile(
                icon: EvaIcons.bellOutline,
                title: 'Notifications',
                onTap: () {},
              ),
              _buildSettingsTile(
                icon: EvaIcons.moonOutline,
                title: 'Dark Mode',
                trailing: Switch(
                  value: true, // Assuming dark mode is always on
                  onChanged: (value) {},
                  activeColor: const Color(0xFF3D7BFF),
                ),
              ),
              _buildSettingsTile(
                icon: EvaIcons.globe,
                title: 'Language',
                trailing: Text(
                  'English',
                  style: GoogleFonts.inter(
                    color: Colors.white.withOpacity(0.6),
                  ),
                ),
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 30),
          _buildSettingsGroup(
            title: 'SUPPORT',
            children: [
              _buildSettingsTile(
                icon: EvaIcons.questionMarkCircleOutline,
                title: 'Help & Support',
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 40),
          ElevatedButton.icon(
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false).logout();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/login', (route) => false);
            },
            icon: const Icon(EvaIcons.logOutOutline, color: Colors.red),
            label: Text(
              'Sign Out',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.withOpacity(0.1),
              minimumSize: const Size(double.infinity, 56),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Text(
              'TASKFLOW V2.4.0 (API V4)',
              style: GoogleFonts.inter(
                color: Colors.white.withOpacity(0.4),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        const CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage(
              'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?w=100&h=100&fit=crop'),
        ),
        const SizedBox(height: 16),
        Text(
          'Alex Rivera',
          style: GoogleFonts.inter(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'alex.rivera@taskflow.io',
          style: GoogleFonts.inter(
            fontSize: 16,
            color: Colors.white.withOpacity(0.6),
          ),
        ),
        const SizedBox(height: 16),
        Chip(
          avatar: const Icon(EvaIcons.star, color: Color(0xFF3D7BFF)),
          label: Text(
            'Pro Plan Member',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF3D7BFF),
            ),
          ),
          backgroundColor: const Color(0xFF3D7BFF).withOpacity(0.1),
        ),
      ],
    );
  }

  Widget _buildStats() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard('128', 'TASKS DONE'),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard('14', 'PROJECTS'),
        ),
      ],
    );
  }

  Widget _buildStatCard(String value, String label) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.inter(
              color: Colors.white.withOpacity(0.6),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsGroup(
      {required String title, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            color: Colors.white.withOpacity(0.6),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white.withOpacity(0.8)),
      title: Text(
        title,
        style: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: trailing ??
          const Icon(
            EvaIcons.arrowIosForwardOutline,
            color: Colors.white,
          ),
      onTap: onTap,
    );
  }
}