import 'package:flutter/material.dart';
import '../../../shared/theme/app_theme.dart';
import '../../../shared/widgets/summary_card.dart';
import '../../../shared/widgets/week_calendar_picker.dart';
import '../../../shared/widgets/quick_action_button.dart';
import '../../../shared/widgets/section_header.dart';
import '../widgets/group_card.dart';
import '../../groups/screens/group_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // App Bar
            SliverToBoxAdapter(child: _buildAppBar()),

            // Content
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const SizedBox(height: AppSpacing.md),

                  // 1. Hutang & Piutang cards (horizontal scroll)
                  _buildSummaryCards(),

                  const SizedBox(height: AppSpacing.md),

                  // 2. Week calendar
                  WeekCalendarPicker(
                    selectedDate: _selectedDate,
                    onDateSelected: (date) =>
                        setState(() => _selectedDate = date),
                  ),

                  const SizedBox(height: AppSpacing.lg),

                  // 3. Quick Actions
                  const SectionHeader(title: 'Quick Action'),
                  const SizedBox(height: AppSpacing.md),
                  QuickActionsRow(
                    onScanNota: () {
                      // TODO: navigate to scan nota
                    },
                    onAddExpense: () {
                      // TODO: navigate to add expense
                    },
                    onReminder: () {
                      // TODO: show reminders
                    },
                    onSummary: () {
                      // TODO: show summary
                    },
                  ),

                  const SizedBox(height: AppSpacing.lg),

                  // 4. Your Groups
                 SectionHeader(
                        title: 'Your Groups',
                        onActionTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const GroupScreen()),
                          );
                        },
                      ),
                  const SizedBox(height: AppSpacing.md),
                  _buildYourGroups(),

                  const SizedBox(height: AppSpacing.lg),

                  // 5. Other Groups
                SectionHeader(
                            title: 'Other Groups',
                            onActionTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => const GroupScreen()),
                              );
                            },
                          ),
                  const SizedBox(height: AppSpacing.md),
                  _buildOtherGroups(),

                  const SizedBox(height: AppSpacing.xl),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('SPLITBILL', style: AppTextStyles.heading1),
          Row(
            children: [
              // Notification bell
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.cardWhite,
                  shape: BoxShape.circle,
                  boxShadow: AppShadows.softShadow,
                ),
                child: const Icon(
                  Icons.notifications_outlined,
                  size: 20,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              // Profile avatar
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.softPurple,
                  boxShadow: AppShadows.softShadow,
                ),
                child: const Icon(
                  Icons.person,
                  size: 22,
                  color: AppColors.primaryPurple,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCards() {
    return SizedBox(
      height: 180,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          SummaryCard.hutang(
            totalAmount: 'Rp. 100.000',
            personalAmount: 'Rp. 10.000',
            onTap: () {
              // TODO: navigate to hutang detail
            },
          ),
          const SizedBox(width: AppSpacing.md),
          SummaryCard.piutang(
            totalAmount: 'Rp. 100.000',
            personalAmount: 'Rp. 10.000',
            onTap: () {
              // TODO: navigate to piutang detail
            },
          ),
        ],
      ),
    );
  }

  Widget _buildYourGroups() {
    // Dummy data — ganti dengan provider/state management
    final groups = [
      {'name': 'Goes To Bali', 'isLeader': true, 'isActive': true},
      {'name': 'Flying Solo', 'isLeader': true, 'isActive': true},
      {'name': 'Project Kantor', 'isLeader': true, 'isActive': false},
    ];

    final gradients = [
      AppColors.cardGradient1,
      AppColors.cardGradient2,
    ];

    return SizedBox(
      height: 180,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: groups.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.md),
        itemBuilder: (context, index) {
          final group = groups[index];
          return GroupCard(
            groupName: group['name'] as String,
            isLeader: group['isLeader'] as bool,
            isActive: group['isActive'] as bool,
            gradient: gradients[index % gradients.length],
            onTap: () {
              // TODO: navigate to group detail
            },
            onSettingsTap: () {
              // TODO: show group settings
            },
            onToggle: () {
              // TODO: toggle group active state
            },
          );
        },
      ),
    );
  }

  Widget _buildOtherGroups() {
    // Dummy data — grup yang user ikut tapi bukan leader
    final otherGroups = [
      {'name': 'Arisan RT 07', 'subtitle': '8 members', 'isActive': true},
      {'name': 'Makan Bareng', 'subtitle': '5 members', 'isActive': false},
      {'name': 'Kosan Project', 'subtitle': '12 members', 'isActive': true},
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        boxShadow: AppShadows.softShadow,
      ),
      child: Column(
        children: List.generate(otherGroups.length, (index) {
          final group = otherGroups[index];
          final isLast = index == otherGroups.length - 1;

          return Column(
            children: [
              _OtherGroupListTile(
                name: group['name'] as String,
                subtitle: group['subtitle'] as String,
                isActive: group['isActive'] as bool,
                onTap: () {
                  // TODO: navigate to group detail
                },
              ),
              if (!isLast)
                Divider(
                  height: 1,
                  thickness: 1,
                  indent: AppSpacing.md,
                  endIndent: AppSpacing.md,
                  color: AppColors.dividerColor,
                ),
            ],
          );
        }),
      ),
    );
  }
}

class _OtherGroupListTile extends StatelessWidget {
  final String name;
  final String subtitle;
  final bool isActive;
  final VoidCallback? onTap;

  const _OtherGroupListTile({
    required this.name,
    required this.subtitle,
    required this.isActive,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.softPurple,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.groups_rounded,
                color: AppColors.primaryPurple,
                size: 24,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: AppTextStyles.heading3,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textGrey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isActive
                    ? AppColors.successGreen
                    : AppColors.textGrey.withOpacity(0.4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}