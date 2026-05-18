import 'package:flutter/material.dart';
import 'package:splitbill_ai/shared/theme/app_theme.dart';

/// Card untuk menampilkan grup patungan di dashboard
/// Bisa digunakan di "Your Groups" dan "Other Groups" section
class GroupCard extends StatelessWidget {
  final String groupName;
  final String? groupDescription;
  final String? imageUrl;
  final bool isLeader;
  final bool isActive;
  final LinearGradient gradient;
  final VoidCallback? onTap;
  final VoidCallback? onSettingsTap;
  final VoidCallback? onToggle;

  const GroupCard({
    super.key,
    required this.groupName,
    this.groupDescription,
    this.imageUrl,
    this.isLeader = false,
    this.isActive = true,
    this.gradient = AppColors.cardGradient1,
    this.onTap,
    this.onSettingsTap,
    this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160,
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(AppRadius.xl),
          boxShadow: AppShadows.cardShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row: avatar + settings icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _GroupAvatar(imageUrl: imageUrl),
                GestureDetector(
                  onTap: onSettingsTap,
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.settings,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppSpacing.sm),

            // Group name
            Text(
              groupName,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                height: 1.2,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: AppSpacing.xs),

            // Leader badge
            if (isLeader) const _LeaderBadge(),

            const Spacer(),

            // Toggle switch
            _ActiveToggle(
              isActive: isActive,
              onToggle: onToggle,
            ),
          ],
        ),
      ),
    );
  }
}

class _GroupAvatar extends StatelessWidget {
  final String? imageUrl;

  const _GroupAvatar({this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
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
          ? const Icon(
              Icons.group,
              size: 26,
              color: Colors.white,
            )
          : null,
    );
  }
}

class _LeaderBadge extends StatelessWidget {
  const _LeaderBadge();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.emoji_events,
          size: 12,
          color: Colors.amber.shade300,
        ),
        const SizedBox(width: 3),
        Text(
          'Leader',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Colors.amber.shade200,
          ),
        ),
      ],
    );
  }
}

class _ActiveToggle extends StatelessWidget {
  final bool isActive;
  final VoidCallback? onToggle;

  const _ActiveToggle({required this.isActive, this.onToggle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      child: Container(
        width: 44,
        height: 24,
        decoration: BoxDecoration(
          color: isActive
              ? Colors.white.withOpacity(0.4)
              : Colors.black.withOpacity(0.2),
          borderRadius: BorderRadius.circular(AppRadius.full),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          alignment:
              isActive ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 18,
            height: 18,
            margin: const EdgeInsets.symmetric(horizontal: 3),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}