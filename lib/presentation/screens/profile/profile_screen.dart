import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../widgets/common/zero_card.dart';

/// Profile and settings screen
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.transparent,
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          final user = state.user;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // User info
                ZeroCard(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      // Avatar
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.primary.withValues(alpha: 0.3),
                            width: 2,
                          ),
                        ),
                        child: user.avatarUrl != null
                            ? ClipOval(
                                child: Image.network(
                                  user.avatarUrl!,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : const Icon(
                                Icons.person,
                                size: 32,
                                color: AppColors.primary,
                              ),
                      ),

                      const SizedBox(width: 16),

                      // Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.displayName ?? 'Adventurer',
                              style: AppTypography.titleLarge,
                            ),
                            Text(
                              user.email,
                              style: AppTypography.bodySmall,
                            ),
                          ],
                        ),
                      ),

                      IconButton(
                        icon: const Icon(Icons.edit_outlined),
                        color: AppColors.textSecondary,
                        onPressed: () {
                          // TODO: Edit profile
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Settings sections
                _SettingsSection(
                  title: 'Preferences',
                  items: [
                    _SettingsItem(
                      icon: Icons.notifications_outlined,
                      title: 'Notifications',
                      onTap: () {},
                    ),
                    _SettingsItem(
                      icon: Icons.palette_outlined,
                      title: 'Appearance',
                      subtitle: 'Dark mode',
                      onTap: () {},
                    ),
                    _SettingsItem(
                      icon: Icons.health_and_safety_outlined,
                      title: 'Health Integrations',
                      onTap: () {},
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                _SettingsSection(
                  title: 'Account',
                  items: [
                    _SettingsItem(
                      icon: Icons.workspace_premium_outlined,
                      title: 'Upgrade to Premium',
                      subtitle: 'Unlock all features',
                      onTap: () {},
                      accentColor: AppColors.secondary,
                    ),
                    _SettingsItem(
                      icon: Icons.download_outlined,
                      title: 'Export Data',
                      onTap: () {},
                    ),
                    _SettingsItem(
                      icon: Icons.privacy_tip_outlined,
                      title: 'Privacy',
                      onTap: () {},
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                _SettingsSection(
                  title: 'Support',
                  items: [
                    _SettingsItem(
                      icon: Icons.help_outline,
                      title: 'Help & FAQ',
                      onTap: () {},
                    ),
                    _SettingsItem(
                      icon: Icons.feedback_outlined,
                      title: 'Send Feedback',
                      onTap: () {},
                    ),
                    _SettingsItem(
                      icon: Icons.info_outline,
                      title: 'About ZERO',
                      onTap: () {},
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Sign out button
                ZeroCard(
                  onTap: () {
                    context.read<AuthBloc>().add(const AuthSignOutRequested());
                  },
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.logout,
                        color: AppColors.error,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Sign Out',
                        style: AppTypography.labelLarge.copyWith(
                          color: AppColors.error,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Version
                Text(
                  'ZERO v1.0.0',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),

                const SizedBox(height: 100),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  const _SettingsSection({
    required this.title,
    required this.items,
  });

  final String title;
  final List<_SettingsItem> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            title,
            style: AppTypography.labelMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
        ZeroCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return Column(
                children: [
                  if (index > 0)
                    const Divider(
                      color: AppColors.border,
                      height: 1,
                    ),
                  item,
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _SettingsItem extends StatelessWidget {
  const _SettingsItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.subtitle,
    this.accentColor,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final Color? accentColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              icon,
              color: accentColor ?? AppColors.textSecondary,
              size: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.bodyLarge.copyWith(
                      color: accentColor,
                    ),
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      style: AppTypography.bodySmall,
                    ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: AppColors.textTertiary,
            ),
          ],
        ),
      ),
    );
  }
}
