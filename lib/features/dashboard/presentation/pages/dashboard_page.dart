import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_theme.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تكاتف')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          _DashboardCard(
            icon: Icons.groups_outlined,
            iconColor: AppTheme.seedColor,
            title: 'المستفيدون',
            subtitle: 'البيوت، الطلاب، الشيبان، والمتزوجون',
            onTap: () => context.push('/beneficiaries'),
          ),
          const SizedBox(height: AppSpacing.sm),
          _DashboardCard(
            icon: Icons.campaign_outlined,
            iconColor: AppTheme.accentColor,
            title: 'الحملات',
            subtitle: 'إنشاء حملات المساعدات وتوزيعها',
            onTap: () => context.push('/campaigns'),
          ),
          const SizedBox(height: AppSpacing.sm),
          _DashboardCard(
            icon: Icons.holiday_village_outlined,
            iconColor: AppTheme.accentColor,
            title: 'القرى',
            subtitle: 'إدارة قائمة القرى',
            onTap: () => context.push('/villages'),
          ),
          const SizedBox(height: AppSpacing.sm),
          _DashboardCard(
            icon: Icons.location_city_outlined,
            iconColor: AppTheme.seedColor,
            title: 'أماكن السكن',
            subtitle: 'إدارة قائمة أماكن السكن',
            onTap: () => context.push('/residence-places'),
          ),
          const SizedBox(height: AppSpacing.sm),
          _DashboardCard(
            icon: Icons.volunteer_activism_outlined,
            iconColor: AppTheme.accentColor,
            title: 'أنواع المساعدات',
            subtitle: 'إدارة أنواع المساعدات المتاحة',
            onTap: () => context.push('/aid-types'),
          ),
        ],
      ),
    );
  }
}

class _DashboardCard extends StatelessWidget {
  const _DashboardCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: .14),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_left),
            ],
          ),
        ),
      ),
    );
  }
}
