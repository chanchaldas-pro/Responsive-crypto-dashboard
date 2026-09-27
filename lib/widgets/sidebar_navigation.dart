import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'theme_switch_button.dart';

class SidebarNavigation extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final bool isCollapsed;

  const SidebarNavigation({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
    this.isCollapsed = false,
  });

  @override
  State<SidebarNavigation> createState() => _SidebarNavigationState();
}

class _SidebarNavigationState extends State<SidebarNavigation> {
  final List<_NavItem> _items = const [
    _NavItem(icon: Icons.dashboard_rounded, label: 'Dashboard'),
    _NavItem(icon: Icons.account_balance_wallet_rounded, label: 'Wallet'),
    _NavItem(icon: Icons.payments_rounded, label: 'Transactions'),
    _NavItem(icon: Icons.schedule_rounded, label: 'History'),
    _NavItem(icon: Icons.swap_horiz_rounded, label: 'Exchange'),
    _NavItem(icon: Icons.insights_rounded, label: 'Analytics'),
    _NavItem(icon: Icons.settings_rounded, label: 'Settings'),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      width: widget.isCollapsed ? 80 : 210,
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSidebar : AppColors.lightSidebar,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(AppRadius.card),
          bottomRight: Radius.circular(AppRadius.card),
        ),
        border: Border(
          right: BorderSide(
            color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
            width: 1.2,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
      child: Column(
        children: [
          // Logo Section (3D Cube / Hexagon)
          _buildLogo(isDark),

          const SizedBox(height: 36),

          // Nav Items
          Expanded(
            child: ListView.separated(
              itemCount: _items.length,
              separatorBuilder: (_, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final item = _items[index];
                final isSelected = widget.selectedIndex == index;

                return _buildNavButton(
                  item: item,
                  isSelected: isSelected,
                  isDark: isDark,
                  index: index,
                );
              },
            ),
          ),

          // Bottom Theme Switcher & Mini Info
          if (!widget.isCollapsed) ...[
            const Divider(),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                      size: 16,
                      color: isDark ? Colors.white70 : AppColors.lightTextSecondary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      isDark ? 'Dark Mode' : 'Light Mode',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white70 : AppColors.lightTextPrimary,
                      ),
                    ),
                  ],
                ),
                const ThemeSwitchButton(),
              ],
            ),
          ] else
            const ThemeSwitchButton(compact: true),
        ],
      ),
    );
  }

  Widget _buildLogo(bool isDark) {
    return Row(
      mainAxisAlignment: widget.isCollapsed ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF38BDF8), AppColors.vibrantCoral],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: AppColors.vibrantCoral.withValues(alpha: 0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Center(
            child: Icon(
              Icons.token_rounded,
              color: Colors.white,
              size: 26,
            ),
          ),
        ),
        if (!widget.isCollapsed) ...[
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'NEXUS',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.5,
                  color: isDark ? Colors.white : AppColors.lightTextPrimary,
                ),
              ),
              Text(
                'Crypto Wallet',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.white54 : AppColors.lightTextSecondary,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildNavButton({
    required _NavItem item,
    required bool isSelected,
    required bool isDark,
    required int index,
  }) {
    return InkWell(
      onTap: () => widget.onDestinationSelected(index),
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: widget.isCollapsed ? 0 : 14,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark ? const Color(0xFF282E4D) : const Color(0xFFEFF6FF))
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: isSelected
              ? Border.all(
                  color: isDark
                      ? const Color(0xFF3C4573)
                      : AppColors.vibrantCoral.withValues(alpha: 0.2),
                  width: 1.0,
                )
              : null,
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: (isDark ? const Color(0xFF282E4D) : Colors.black12)
                        .withValues(alpha: 0.3),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  )
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: widget.isCollapsed
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: [
            Icon(
              item.icon,
              size: 22,
              color: isSelected
                  ? (isDark ? Colors.white : AppColors.vibrantCoral)
                  : (isDark ? Colors.white54 : AppColors.lightTextSecondary),
            ),
            if (!widget.isCollapsed) ...[
              const SizedBox(width: 14),
              Text(
                item.label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected
                      ? (isDark ? Colors.white : AppColors.vibrantCoral)
                      : (isDark ? Colors.white60 : AppColors.lightTextSecondary),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;

  const _NavItem({required this.icon, required this.label});
}
