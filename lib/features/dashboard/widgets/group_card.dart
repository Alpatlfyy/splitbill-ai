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
  final int imageCount;
  final int memberCount;
  final List<String> memberAvatars;
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
    this.imageCount = 4,
    this.memberCount = 4,
    this.memberAvatars = const [],
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

            _LeaderAndMembersRow(
              isLeader: isLeader,
              memberCount: memberCount,
              memberAvatars: memberAvatars,
            ),

            const Spacer(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _ActiveToggle(
                  isActive: isActive,
                  onToggle: onToggle,
                ),
                _ImageInfoChip(count: imageCount),
              ],
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

class _LeaderAndMembersRow extends StatelessWidget {
  final bool isLeader;
  final int memberCount;
  final List<String> memberAvatars;

  const _LeaderAndMembersRow({
    required this.isLeader,
    required this.memberCount,
    required this.memberAvatars,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (isLeader) const _LeaderBadge(),
        _MemberStack(
          memberCount: memberCount,
          memberAvatars: memberAvatars,
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

class _MemberStack extends StatelessWidget {
  final int memberCount;
  final List<String> memberAvatars;

  const _MemberStack({required this.memberCount, required this.memberAvatars});

  @override
  Widget build(BuildContext context) {
    final avatarTotal = memberAvatars.isEmpty ? memberCount : memberAvatars.length;
    final visibleCount = avatarTotal.clamp(2, 4).toInt();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 24,
          width: (visibleCount * 12.0) + 8,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              for (var index = 0; index < visibleCount; index++)
                Positioned(
                  left: index * 12.0,
                  child: _MiniAvatar(size: 24),
                ),
              if (avatarTotal > visibleCount)
                Positioned(
                  left: visibleCount * 12.0,
                  child: _CountBubble(count: avatarTotal - visibleCount),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MiniAvatar extends StatelessWidget {
  final double size;

  const _MiniAvatar({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.28),
        border: Border.all(
          color: Colors.white.withOpacity(0.34),
          width: 1,
        ),
      ),
      child: Icon(
        Icons.person,
        size: size * 0.5,
        color: Colors.white.withOpacity(0.85),
      ),
    );
  }
}

class _CountBubble extends StatelessWidget {
  final int count;

  const _CountBubble({required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.18),
        border: Border.all(color: Colors.white.withOpacity(0.30)),
      ),
      child: Center(
        child: Text(
          '+$count',
          style: const TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class _ImageInfoChip extends StatelessWidget {
  final int count;

  const _ImageInfoChip({required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.16),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.photo_library_outlined,
            size: 11,
            color: Colors.white.withOpacity(0.9),
          ),
          const SizedBox(width: 4),
          Text(
            '$count images',
            style: const TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}