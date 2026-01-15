import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:task_flow/providers/auth_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
          _buildProfileHeader(context),
          const SizedBox(height: 30),
          _buildStats(context),
          const SizedBox(height: 30),
          _buildSettingsGroup(
            context,
            title: 'ACCOUNT',
            children: [
              _buildSettingsTile(
                context,
                icon: EvaIcons.shieldOutline,
                title: 'Account Security',
                onTap: () {},
              ),
              _buildSettingsTile(
                context,
                icon: EvaIcons.personOutline,
                title: 'Personal Information',
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 30),
          _buildSettingsGroup(
            context,
            title: 'PREFERENCES',
            children: [
              _buildSettingsTile(
                context,
                icon: EvaIcons.bellOutline,
                title: 'Notifications',
                onTap: () {},
              ),
              // _buildSettingsTile(
              //   context,
              //   icon: EvaIcons.moonOutline,
              //   title: 'Dark Mode',
              //   trailing: Switch(
              //     value: theme.brightness == Brightness.dark,
              //     onChanged: (value) {},
              //     activeColor: theme.colorScheme.primary,
              //   ),
              // ),
              _buildSettingsTile(
                context,
                icon: EvaIcons.globe2Outline,
                title: 'Language',
                trailing: Text(
                  'English',
                  style: GoogleFonts.inter(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 30),
          _buildSettingsGroup(
            context,
            title: 'SUPPORT',
            children: [
              _buildSettingsTile(
                context,
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
            icon: Icon(EvaIcons.logOutOutline, color: theme.colorScheme.error),
            label: Text(
              'Sign Out',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.error,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.error.withValues(alpha: 0.1),
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
                color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    final theme = Theme.of(context);
    final authProvider = Provider.of<AuthProvider>(context);
    return Column(
      children: [
        const CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage('assets/profile.jpg'),
        ),
        const SizedBox(height: 16),
        Text(
          authProvider.username ?? 'Alex Rivera',
          style: GoogleFonts.inter(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          authProvider.email ?? 'alex.rivera@taskflow.io',
          style: GoogleFonts.inter(
            fontSize: 16,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
        const SizedBox(height: 16),
        Chip(
          avatar: Icon(EvaIcons.star, color: theme.colorScheme.primary),
          label: Text(
            'Pro Plan Member',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
        ),
      ],
    );
  }

  Widget _buildStats(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(context, '128', 'TASKS DONE'),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(context, '14', 'PROJECTS'),
        ),
      ],
    );
  }

  Widget _buildStatCard(BuildContext context, String value, String label) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
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
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsGroup(
      BuildContext context, {
        required String title,
        required List<Widget> children,
      }) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsTile(
      BuildContext context, {
        required IconData icon,
        required String title,
        Widget? trailing,
        VoidCallback? onTap,
      }) {
    final theme = Theme.of(context);
    return ListTile(
      leading: Icon(icon, color: theme.colorScheme.onSurface.withValues(alpha: 0.8)),
      title: Text(
        title,
        style: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: trailing ??
          Icon(
            EvaIcons.arrowIosForwardOutline,
            color: theme.colorScheme.onSurface,
          ),
      onTap: onTap,
    );
  }
}
