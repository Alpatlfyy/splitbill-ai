import 'package:flutter/material.dart';
import 'package:splitbill_ai/features/dashboard/screens/dashboard_screen.dart';
import 'package:splitbill_ai/shared/theme/app_theme.dart';

class BottomNavShell extends StatefulWidget {
  const BottomNavShell({super.key});

  @override
  State<BottomNavShell> createState() => _BottomNavShellState();
}

class _BottomNavShellState extends State<BottomNavShell> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    DashboardScreen(),
    _ActivityScreen(),
    _AddScreen(),
    _GroupsScreen(),
    _ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: _pages[_selectedIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onItemTapped(2),
        backgroundColor: AppColors.primaryPurple,
        child: const Icon(Icons.add, size: 28, color: Colors.white),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        elevation: 8,
        color: AppColors.cardWhite,
        child: SizedBox(
          height: 64,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Left side: Home + Activity
                Row(
                  children: [
                    _NavItem(
                      icon: Icons.home_outlined,
                      label: 'Home',
                      isSelected: _selectedIndex == 0,
                      onTap: () => _onItemTapped(0),
                    ),
                    const SizedBox(width: 12),
                    _NavItem(
                      icon: Icons.history_toggle_off,
                      label: 'Activity',
                      isSelected: _selectedIndex == 1,
                      onTap: () => _onItemTapped(1),
                    ),
                  ],
                ),

                // Right side: Groups + Profile
                Row(
                  children: [
                    _NavItem(
                      icon: Icons.group_outlined,
                      label: 'Groups',
                      isSelected: _selectedIndex == 3,
                      onTap: () => _onItemTapped(3),
                    ),
                    const SizedBox(width: 12),
                    _NavItem(
                      icon: Icons.person_outline,
                      label: 'Profile',
                      isSelected: _selectedIndex == 4,
                      onTap: () => _onItemTapped(4),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? AppColors.primaryPurple : AppColors.textGrey;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: 64,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(height: 4),
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  label,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: isSelected ? AppColors.primaryPurple : AppColors.textGrey,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Simple placeholder pages for tabs. Replace with real screens later.
class _ActivityScreen extends StatelessWidget {
  const _ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        backgroundColor: AppColors.cardWhite,
        elevation: 0,
        title: const Text('Activity'),
        titleTextStyle: AppTextStyles.heading2,
        iconTheme: const IconThemeData(color: AppColors.textDark),
      ),
      body: const Center(child: Text('Activity content')),
    );
  }
}

class _AddScreen extends StatelessWidget {
  const _AddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        backgroundColor: AppColors.cardWhite,
        elevation: 0,
        title: const Text('Add'),
        titleTextStyle: AppTextStyles.heading2,
        iconTheme: const IconThemeData(color: AppColors.textDark),
      ),
      body: const Center(child: Text('Create new item (Add)')),
    );
  }
}

class _GroupsScreen extends StatelessWidget {
  const _GroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        backgroundColor: AppColors.cardWhite,
        elevation: 0,
        title: const Text('Groups'),
        titleTextStyle: AppTextStyles.heading2,
        iconTheme: const IconThemeData(color: AppColors.textDark),
      ),
      body: const Center(child: Text('Groups list')),
    );
  }
}

class _ProfileScreen extends StatelessWidget {
  const _ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        backgroundColor: AppColors.cardWhite,
        elevation: 0,
        title: const Text('Profile'),
        titleTextStyle: AppTextStyles.heading2,
        iconTheme: const IconThemeData(color: AppColors.textDark),
      ),
      body: const Center(child: Text('User profile')),
    );
  }
}
