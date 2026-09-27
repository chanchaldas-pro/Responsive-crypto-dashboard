import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'frosted_search_bar.dart';
import 'theme_switch_button.dart';

class HeroBannerCard extends StatefulWidget {
  final ValueChanged<String>? onSearchChanged;
  final VoidCallback? onNewBiddingPressed;

  const HeroBannerCard({
    super.key,
    this.onSearchChanged,
    this.onNewBiddingPressed,
  });

  @override
  State<HeroBannerCard> createState() => _HeroBannerCardState();
}

class _HeroBannerCardState extends State<HeroBannerCard> {
  int _selectedTabIndex = 0;
  final List<String> _tabs = ['Overview', 'Account', 'Recent', 'Preview'];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        borderRadius: AppRadius.cardRadius,
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.35)
                : const Color(0x1A0F172A),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: AppRadius.cardRadius,
        child: Stack(
          children: [
            // Background Hero Image
            Positioned.fill(
              child: Image.asset(
                'assets/images/hero_bg.jpg',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: isDark
                            ? [const Color(0xFF0F1224), const Color(0xFF1E2342)]
                            : [const Color(0xFFE2E8F0), const Color(0xFFCBD5E1)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  );
                },
              ),
            ),

            // Theme-adaptive Gradient Mask for Readability & Contrast
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isDark
                        ? [
                            AppColors.darkBackground.withValues(alpha: 0.88),
                            AppColors.darkCard.withValues(alpha: 0.72),
                            const Color(0xFF14182C).withValues(alpha: 0.85),
                          ]
                        : [
                            Colors.white.withValues(alpha: 0.88),
                            const Color(0xFFF1F5F9).withValues(alpha: 0.80),
                            Colors.white.withValues(alpha: 0.82),
                          ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),

            // Content Container with LayoutBuilder
            LayoutBuilder(
              builder: (context, constraints) {
                final bannerWidth = constraints.maxWidth;
                final isMobile = bannerWidth < 680;
                final isCompactDesktop = bannerWidth >= 680 && bannerWidth < 980;

                return Padding(
                  padding: EdgeInsets.all(isMobile ? 16.0 : 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top Navigation & Action Controls
                      if (isMobile)
                        _buildMobileTopBar(isDark)
                      else if (isCompactDesktop)
                        _buildCompactDesktopTopBar(isDark, bannerWidth)
                      else
                        _buildFullDesktopTopBar(isDark),

                      SizedBox(height: isMobile ? 18 : 24),

                      // Dashboard Title & Welcome Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Dashboard',
                                      style: theme.textTheme.headlineMedium?.copyWith(
                                        fontWeight: FontWeight.w800,
                                        fontSize: isMobile ? 22 : 30,
                                        letterSpacing: -0.5,
                                        color: isDark ? Colors.white : AppColors.lightTextPrimary,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                      decoration: BoxDecoration(
                                        color: AppColors.vibrantCoral.withValues(alpha: 0.18),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: AppColors.vibrantCoral.withValues(alpha: 0.4),
                                          width: 1,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 6,
                                            height: 6,
                                            decoration: const BoxDecoration(
                                              color: AppColors.vibrantCoral,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          const Text(
                                            'Live Market',
                                            style: TextStyle(
                                              color: AppColors.vibrantCoral,
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Welcome Back! Manage your cryptocurrency portfolio and live bidding.',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    fontSize: isMobile ? 12 : 14,
                                    color: isDark
                                        ? Colors.white.withValues(alpha: 0.7)
                                        : AppColors.lightTextSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // Mobile Search bar below title if screen is small
                      if (isMobile) ...[
                        const SizedBox(height: 16),
                        FrostedSearchBar(
                          width: double.infinity,
                          hintText: 'Search crypto, tokens...',
                          onChanged: widget.onSearchChanged,
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFullDesktopTopBar(bool isDark) {
    return Row(
      children: [
        _buildDatePill(isDark),
        const Spacer(),
        _buildTabs(isDark),
        const SizedBox(width: 14),
        _buildNewBiddingButton(isDark),
        const SizedBox(width: 14),
        FrostedSearchBar(
          width: 200,
          hintText: 'Search',
          onChanged: widget.onSearchChanged,
        ),
        const SizedBox(width: 14),
        const ThemeSwitchButton(),
      ],
    );
  }

  Widget _buildCompactDesktopTopBar(bool isDark, double availableWidth) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildDatePill(isDark),
            Row(
              children: [
                _buildNewBiddingButton(isDark),
                const SizedBox(width: 10),
                const ThemeSwitchButton(),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _buildTabs(isDark),
            const Spacer(),
            FrostedSearchBar(
              width: 220,
              hintText: 'Search',
              onChanged: widget.onSearchChanged,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMobileTopBar(bool isDark) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildDatePill(isDark),
            Row(
              children: [
                const ThemeSwitchButton(compact: true),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: widget.onNewBiddingPressed ?? () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.vibrantCoral,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('+ Bid', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: _buildTabs(isDark),
        ),
      ],
    );
  }

  Widget _buildDatePill(bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withValues(alpha: 0.06) : Colors.black.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? Colors.white.withValues(alpha: 0.1) : Colors.black.withValues(alpha: 0.08),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.arrow_drop_down_rounded,
            size: 20,
            color: isDark ? Colors.white70 : Colors.black54,
          ),
          const SizedBox(width: 4),
          Text(
            'Today, 05 Aug 2022',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : AppColors.lightTextPrimary,
            ),
          ),
          const SizedBox(width: 4),
          Icon(
            Icons.arrow_drop_up_rounded,
            size: 20,
            color: isDark ? Colors.white70 : Colors.black54,
          ),
        ],
      ),
    );
  }

  Widget _buildTabs(bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.06)
            : Colors.black.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.08)
              : Colors.black.withValues(alpha: 0.06),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(_tabs.length, (index) {
          final isSelected = _selectedTabIndex == index;
          return GestureDetector(
            onTap: () => setState(() => _selectedTabIndex = index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: isSelected
                    ? (isDark ? const Color(0xFF282E4D) : Colors.white)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 4,
                        )
                      ]
                    : null,
              ),
              child: Text(
                _tabs[index],
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected
                      ? (isDark ? Colors.white : AppColors.vibrantCoral)
                      : (isDark ? Colors.white60 : Colors.black54),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildNewBiddingButton(bool isDark) {
    return ElevatedButton.icon(
      onPressed: widget.onNewBiddingPressed ?? () {},
      icon: const Icon(Icons.add_rounded, size: 16),
      label: const Text('+ New Bidding', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
      style: ElevatedButton.styleFrom(
        backgroundColor: isDark ? const Color(0xFF232842) : Colors.white,
        foregroundColor: AppColors.vibrantCoral,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: isDark
                ? const Color(0xFF333B60)
                : AppColors.vibrantCoral.withValues(alpha: 0.3),
          ),
        ),
      ),
    );
  }
}
