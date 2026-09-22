import 'package:flutter/material.dart';
import 'package:splitbill_ai/shared/theme/app_theme.dart';

/// Horizontal week calendar untuk filter transaksi di dashboard
class WeekCalendarPicker extends StatefulWidget {
  final DateTime selectedDate;
  final DateTime? focusedMonth;
  final ValueChanged<DateTime>? onDateSelected;
  final ValueChanged<DateTime>? onMonthChanged;

  const WeekCalendarPicker({
    super.key,
    required this.selectedDate,
    this.focusedMonth,
    this.onDateSelected,
    this.onMonthChanged,
  });

  @override
  State<WeekCalendarPicker> createState() => _WeekCalendarPickerState();
}

class _WeekCalendarPickerState extends State<WeekCalendarPicker> {
  late DateTime _focusedMonth;
  late List<DateTime> _weekDays;

  final List<String> _dayLabels = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
  final List<String> _months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December',
  ];

  @override
  void initState() {
    super.initState();
    _focusedMonth = widget.focusedMonth ?? widget.selectedDate;
    _weekDays = _getWeekDays(widget.selectedDate);
  }

  List<DateTime> _getWeekDays(DateTime date) {
    // Get start of week (Sunday)
    final startOfWeek = date.subtract(Duration(days: date.weekday % 7));
    return List.generate(7, (i) => startOfWeek.add(Duration(days: i)));
  }

  void _previousWeek() {
    final newDate = _weekDays.first.subtract(const Duration(days: 7));
    setState(() {
      _weekDays = _getWeekDays(newDate);
      _focusedMonth = newDate;
    });
    widget.onMonthChanged?.call(newDate);
  }

  void _nextWeek() {
    final newDate = _weekDays.last.add(const Duration(days: 1));
    setState(() {
      _weekDays = _getWeekDays(newDate);
      _focusedMonth = newDate;
    });
    widget.onMonthChanged?.call(newDate);
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  bool _isToday(DateTime date) => _isSameDay(date, DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        boxShadow: AppShadows.softShadow,
      ),
      child: Column(
        children: [
          // Month header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${_months[_focusedMonth.month - 1]} ${_focusedMonth.year}',
                style: AppTextStyles.heading3,
              ),
              Row(
                children: [
                  _NavButton(
                    icon: Icons.chevron_left,
                    onTap: _previousWeek,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  _NavButton(
                    icon: Icons.chevron_right,
                    onTap: _nextWeek,
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.md),

          // Day labels row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _dayLabels.map((label) {
              return SizedBox(
                width: 36,
                child: Center(
                  child: Text(
                    label,
                    style: AppTextStyles.bodySmall.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: AppSpacing.sm),

          // Week days row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _weekDays.map((date) {
              final isSelected = _isSameDay(date, widget.selectedDate);
              final isToday = _isToday(date);

              return GestureDetector(
                onTap: () => widget.onDateSelected?.call(date),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    gradient: isSelected ? AppColors.primaryGradient : null,
                    color: isToday && !isSelected
                        ? AppColors.softPurple
                        : null,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${date.day}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: isSelected || isToday
                            ? FontWeight.w700
                            : FontWeight.w400,
                        color: isSelected
                            ? Colors.white
                            : isToday
                                ? AppColors.primaryPurple
                                : AppColors.textDark,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _NavButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: AppColors.softPurple,
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        child: Icon(icon, size: 18, color: AppColors.primaryPurple),
      ),
    );
  }
}