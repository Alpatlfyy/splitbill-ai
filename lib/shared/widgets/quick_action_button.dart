import 'package:flutter/material.dart';
import 'package:splitbill_ai/shared/theme/app_theme.dart';

/// Quick action button untuk shortcut fitur utama di dashboard
class QuickActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback? onTap;
  final Color? iconColor;
  final Color? backgroundColor;

  const QuickActionButton({
    super.key,
    required this.label,
    required this.icon,
    this.onTap,
    this.iconColor,
    this.backgroundColor,
  });

  /// Preset factory constructors untuk tiap aksi
  factory QuickActionButton.scanNota({VoidCallback? onTap}) {
    return QuickActionButton(
      label: 'Scan Nota',
      icon: Icons.document_scanner_outlined,
      iconColor: AppColors.primaryPurple,
      backgroundColor: AppColors.softPurple,
      onTap: onTap,
    );
  }

  factory QuickActionButton.addExpense({VoidCallback? onTap}) {
    return QuickActionButton(
      label: 'Tambah',
      icon: Icons.add_circle_outline,
      iconColor: AppColors.successGreen,
      backgroundColor: const Color(0xFFE8F5EE),
      onTap: onTap,
    );
  }

  factory QuickActionButton.reminder({VoidCallback? onTap}) {
    return QuickActionButton(
      label: 'Reminder',
      icon: Icons.notifications_outlined,
      iconColor: AppColors.warningOrange,
      backgroundColor: const Color(0xFFFFF3EB),
      onTap: onTap,
    );
  }

  factory QuickActionButton.summary({VoidCallback? onTap}) {
    return QuickActionButton(
      label: 'Ringkasan',
      icon: Icons.bar_chart_outlined,
      iconColor: AppColors.accentViolet,
      backgroundColor: AppColors.softPurple,
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: backgroundColor ?? AppColors.softPurple,
              borderRadius: BorderRadius.circular(AppRadius.lg),
              boxShadow: AppShadows.softShadow,
            ),
            child: Icon(
              icon,
              size: 26,
              color: iconColor ?? AppColors.primaryPurple,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textMedium,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

/// Row of quick actions — tempatkan di dashboard
class QuickActionsRow extends StatelessWidget {
  final VoidCallback? onScanNota;
  final VoidCallback? onAddExpense;
  final VoidCallback? onReminder;
  final VoidCallback? onSummary;

  const QuickActionsRow({
    super.key,
    this.onScanNota,
    this.onAddExpense,
    this.onReminder,
    this.onSummary,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        QuickActionButton.scanNota(onTap: onScanNota),
        QuickActionButton.addExpense(onTap: onAddExpense),
        QuickActionButton.reminder(onTap: onReminder),
        QuickActionButton.summary(onTap: onSummary),
      ],
    );
  }
}