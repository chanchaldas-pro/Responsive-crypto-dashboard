import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'theme_switch_button.dart';

class MobileNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  const MobileNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final items = const [
      _MobileItem(icon: Icons.dashboard_rounded, label: 'Home'),
      _MobileItem(icon: Icons.account_balance_wallet_rounded, label: 'Wallet'),
      _MobileItem(icon: Icons.swap_horiz_rounded, label: 'Swap'),
      _MobileItem(icon: Icons.insights_rounded, label: 'Stats'),
      _MobileItem(icon: Icons.person_rounded, label: 'Profile'),
    ];

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.darkSidebar.withValues(alpha: 0.9)
                : AppColors.lightSidebar.withValues(alpha: 0.9),
            border: Border(
              top: BorderSide(
                color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                width: 1,
              ),
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: SafeArea(
            top: false,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(items.length, (index) {
                final item = items[index];
                final isSelected = selectedIndex == index;

                return InkWell(
                  onTap: () => onDestinationSelected(index),
                  borderRadius: BorderRadius.circular(16),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.vibrantCoral.withValues(alpha: 0.14)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          item.icon,
                          size: 22,
                          color: isSelected
                              ? AppColors.vibrantCoral
                              : (isDark ? Colors.white54 : AppColors.lightTextSecondary),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          item.label,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                            color: isSelected
                                ? AppColors.vibrantCoral
                                : (isDark ? Colors.white54 : AppColors.lightTextSecondary),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class MobileAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onOpenDrawer;

  const MobileAppBar({super.key, this.onOpenDrawer});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AppBar(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.menu_rounded),
        color: isDark ? Colors.white : AppColors.lightTextPrimary,
        onPressed: onOpenDrawer ?? () => Scaffold.of(context).openDrawer(),
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF38BDF8), AppColors.vibrantCoral],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Icon(Icons.token_rounded, color: Colors.white, size: 18),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'NEXUS',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.2,
              color: isDark ? Colors.white : AppColors.lightTextPrimary,
            ),
          ),
        ],
      ),
      centerTitle: true,
      actions: const [
        ThemeSwitchButton(compact: true),
        SizedBox(width: 8),
      ],
    );
  }
}

class _MobileItem {
  final IconData icon;
  final String label;

  const _MobileItem({required this.icon, required this.label});
}
