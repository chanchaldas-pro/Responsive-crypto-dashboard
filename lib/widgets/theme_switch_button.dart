import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../theme/theme_provider.dart';

class ThemeSwitchButton extends StatelessWidget {
  final bool compact;

  const ThemeSwitchButton({super.key, this.compact = false});

  @override
  Widget build(BuildContext context) {
    final themeProvider = ThemeScope.of(context);
    final isDark = themeProvider.isDarkMode;

    if (compact) {
      return IconButton(
        onPressed: themeProvider.toggleTheme,
        tooltip: isDark ? 'Switch to Light Mode' : 'Switch to Dark Mode',
        icon: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, anim) => RotationTransition(
            turns: anim,
            child: ScaleTransition(scale: anim, child: child),
          ),
          child: Icon(
            isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
            key: ValueKey(isDark),
            color: isDark ? const Color(0xFFFBBF24) : AppColors.vibrantCoral,
            size: 22,
          ),
        ),
      );
    }

    return InkWell(
      onTap: themeProvider.toggleTheme,
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        width: 76,
        height: 36,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isDark ? const Color(0xFF1B2035) : const Color(0xFFE2E8F0),
          border: Border.all(
            color: isDark ? const Color(0xFF2C3454) : const Color(0xFFCBD5E1),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: Icon(
                    Icons.dark_mode_rounded,
                    size: 15,
                    color: isDark ? Colors.white70 : Colors.black45,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: Icon(
                    Icons.light_mode_rounded,
                    size: 15,
                    color: isDark ? Colors.white38 : AppColors.vibrantCoral,
                  ),
                ),
              ],
            ),
            AnimatedAlign(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOutBack,
              alignment: isDark ? Alignment.centerLeft : Alignment.centerRight,
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: isDark
                        ? [const Color(0xFF38BDF8), const Color(0xFF818CF8)]
                        : [AppColors.vibrantCoral, const Color(0xFFFF9E7D)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: (isDark ? const Color(0xFF38BDF8) : AppColors.vibrantCoral)
                          .withValues(alpha: 0.4),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    isDark ? Icons.nightlight_round : Icons.wb_sunny_rounded,
                    size: 15,
                    color: Colors.white,
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
