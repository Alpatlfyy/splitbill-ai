import 'package:flutter/material.dart';
import 'package:splitbill_ai/shared/theme/app_theme.dart';

/// Card untuk menampilkan ringkasan Hutang atau Piutang
/// Digunakan di dashboard sebagai horizontal scrollable card
class SummaryCard extends StatelessWidget {
  final String title;
  final IconData titleIcon;
  final String totalLabel;
  final String totalAmount;
  final String secondaryLabel;
  final String secondaryAmount;
  final LinearGradient gradient;
  final VoidCallback? onTap;
  final List<String> groupAvatars;
  final List<String> personalAvatars;

  const SummaryCard({
    super.key,
    required this.title,
    required this.titleIcon,
    required this.totalLabel,
    required this.totalAmount,
    required this.secondaryLabel,
    required this.secondaryAmount,
    this.gradient = AppColors.cardGradient1,
    this.onTap,
    this.groupAvatars = const [],
    this.personalAvatars = const [],
  });

  /// Factory untuk card Hutang
  factory SummaryCard.hutang({
    required String totalAmount,
    required String personalAmount,
    VoidCallback? onTap,
    List<String> groupAvatars = const [],
    List<String> personalAvatars = const [],
  }) {
    return SummaryCard(
      title: 'Hutang',
      titleIcon: Icons.account_balance_wallet_outlined,
      totalLabel: 'Total Hutang',
      totalAmount: totalAmount,
      secondaryLabel: 'Personal',
      secondaryAmount: personalAmount,
      gradient: AppColors.cardGradient1,
      onTap: onTap,
      groupAvatars: groupAvatars,
      personalAvatars: personalAvatars,
    );
  }

  /// Factory untuk card Piutang
  factory SummaryCard.piutang({
    required String totalAmount,
    required String personalAmount,
    VoidCallback? onTap,
    List<String> groupAvatars = const [],
    List<String> personalAvatars = const [],
  }) {
    return SummaryCard(
      title: 'Piutang',
      titleIcon: Icons.account_balance_wallet_outlined,
      totalLabel: 'Total Piutang',
      totalAmount: totalAmount,
      secondaryLabel: 'Personal',
      secondaryAmount: personalAmount,
      gradient: AppColors.cardGradient2,
      onTap: onTap,
      groupAvatars: groupAvatars,
      personalAvatars: personalAvatars,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 192,
        height: 134,
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(AppRadius.xl),
          boxShadow: AppShadows.cardShadow,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.xl),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 10, 10),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.22),
                          ),
                          child: Icon(
                            titleIcon,
                            size: 22,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 10),
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

                    const SizedBox(height: 8),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _ProfileStackLabel(
                          label: 'Group',
                          avatars: groupAvatars,
                        ),
                        _ProfileStackLabel(
                          label: 'Personal',
                          avatars: personalAvatars,
                        ),
                      ],
                    ),

                    const Spacer(),

                    _AmountBlock(
                      label: totalLabel,
                      amount: totalAmount,
                      accentLabel: 'Group',
                    ),
                    const SizedBox(height: 6),
                    _AmountBlock(
                      label: secondaryLabel,
                      amount: secondaryAmount,
                      accentLabel: 'Personal',
                      isSecondary: true,
                    ),
                  ],
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: _DetailButton(onTap: onTap),
                ),
              ],
            ),
          ),
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

class _ProfileStackLabel extends StatelessWidget {
  final String label;
  final List<String> avatars;

  const _ProfileStackLabel({required this.label, required this.avatars});

  @override
  Widget build(BuildContext context) {
    final avatarCount = avatars.isEmpty ? 2 : avatars.length;
    final visibleCount = avatarCount.clamp(2, 3).toInt();
    final avatarWidth = 22.0 + ((visibleCount - 1) * 8.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 24,
          width: avatarWidth + 4,
          child: Stack(
            clipBehavior: Clip.none,
            children: List.generate(visibleCount, (index) {
              return Positioned(
                left: index * 8.0,
                child: _AvatarCircle(size: 24),
              );
            }),
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: AppTextStyles.cardLabel.copyWith(color: Colors.white70)),
      ],
    );
  }
}

class _DetailButton extends StatelessWidget {
  final VoidCallback? onTap;

  const _DetailButton({this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 22,
        height: 22,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.18),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.chevron_right,
          size: 14,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _AmountBlock extends StatelessWidget {
  final String label;
  final String amount;
  final String accentLabel;
  final bool isSecondary;

  const _AmountBlock({
    required this.label,
    required this.amount,
    required this.accentLabel,
    this.isSecondary = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: AppTextStyles.cardLabel.copyWith(
                fontSize: 9,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 1),
            Text(
              accentLabel,
              style: AppTextStyles.cardLabel.copyWith(
                fontSize: 8,
                color: Colors.white54,
              ),
            ),
          ],
        ),
        Text(
          amount,
          style: isSecondary
              ? AppTextStyles.amountSmall.copyWith(
                  color: Colors.white,
                  fontSize: 11,
                )
              : AppTextStyles.amountSmall.copyWith(
                  color: Colors.white,
                  fontSize: 12,
                ),
        ),
      ],
    );
  }
}