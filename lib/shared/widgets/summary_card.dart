import 'package:flutter/material.dart';
import 'package:splitbill_ai/shared/theme/app_theme.dart';

/// Card untuk menampilkan ringkasan Hutang atau Piutang
/// Digunakan di dashboard sebagai horizontal scrollable card
class SummaryCard extends StatelessWidget {
  final String title;
  final String totalLabel;
  final String totalAmount;
  final String secondaryLabel;
  final String secondaryAmount;
  final LinearGradient gradient;
  final VoidCallback? onTap;

  const SummaryCard({
    super.key,
    required this.title,
    required this.totalLabel,
    required this.totalAmount,
    required this.secondaryLabel,
    required this.secondaryAmount,
    this.gradient = AppColors.cardGradient1,
    this.onTap,
  });

  /// Factory untuk card Hutang
  factory SummaryCard.hutang({
    required String totalAmount,
    required String personalAmount,
    VoidCallback? onTap,
  }) {
    return SummaryCard(
      title: 'Hutang',
      totalLabel: 'Total Hutang',
      totalAmount: totalAmount,
      secondaryLabel: 'Personal',
      secondaryAmount: personalAmount,
      gradient: AppColors.cardGradient1,
      onTap: onTap,
    );
  }

  /// Factory untuk card Piutang
  factory SummaryCard.piutang({
    required String totalAmount,
    required String personalAmount,
    VoidCallback? onTap,
  }) {
    return SummaryCard(
      title: 'Piutang',
      totalLabel: 'Total Piutang',
      totalAmount: totalAmount,
      secondaryLabel: 'Personal',
      secondaryAmount: personalAmount,
      gradient: AppColors.cardGradient2,
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 200,
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(AppRadius.xl),
          boxShadow: AppShadows.cardShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar placeholder + title row
            Row(
              children: [
                _AvatarCircle(size: 36),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppSpacing.md),

            // Double avatar row (teman yang hutang)
            const _AvatarRow(),

            const SizedBox(height: AppSpacing.md),

            // Amount section
            _AmountRow(
              label: totalLabel,
              amount: totalAmount,
            ),
            const SizedBox(height: AppSpacing.xs),
            _AmountRow(
              label: secondaryLabel,
              amount: secondaryAmount,
              isSecondary: true,
            ),
          ],
        ),
      ),
    );
  }
}

class _AvatarCircle extends StatelessWidget {
  final double size;
  final String? imageUrl;

  const _AvatarCircle({double size = 40, String? imageUrl})
      : this.size = size,
        this.imageUrl = imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.3),
        image: imageUrl != null
            ? DecorationImage(
                image: NetworkImage(imageUrl!),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: imageUrl == null
          ? Icon(
              Icons.person,
              size: size * 0.55,
              color: Colors.white.withOpacity(0.8),
            )
          : null,
    );
  }
}

class _AvatarRow extends StatelessWidget {
  const _AvatarRow();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 28,
      child: Stack(
        children: [
          _AvatarCircle(size: 28),
          Positioned(
            left: 18,
            child: _AvatarCircle(size: 28),
          ),
        ],
      ),
    );
  }
}

class _AmountRow extends StatelessWidget {
  final String label;
  final String amount;
  final bool isSecondary;

  const _AmountRow({
    required this.label,
    required this.amount,
    this.isSecondary = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.cardLabel,
        ),
        Text(
          amount,
          style: isSecondary
              ? AppTextStyles.amountSmall.copyWith(
                  color: Colors.white70,
                  fontSize: 12,
                )
              : AppTextStyles.amountSmall,
        ),
      ],
    );
  }
}