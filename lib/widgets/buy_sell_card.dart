import 'package:flutter/material.dart';
import '../models/crypto_data.dart';
import '../theme/app_theme.dart';

class BuySellCard extends StatelessWidget {
  final VoidCallback? onSupportPressed;

  const BuySellCard({super.key, this.onSupportPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final items = MockCryptoRepository.getBuySellItems();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightCard,
        borderRadius: AppRadius.cardRadius,
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black.withValues(alpha: 0.2) : const Color(0x100F172A),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Buy/Sell',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 17,
                  color: isDark ? Colors.white : AppColors.lightTextPrimary,
                ),
              ),
              Icon(
                Icons.more_vert_rounded,
                size: 20,
                color: isDark ? Colors.white54 : AppColors.lightTextSecondary,
              ),
            ],
          ),

          const SizedBox(height: 14),

          // List of items
          ...items.map((item) => _buildItemRow(item, isDark, theme)),

          const SizedBox(height: 16),

          // Support Button
          Center(
            child: InkWell(
              onTap: onSupportPressed ?? () {},
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.06)
                      : Colors.black.withValues(alpha: 0.04),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.1)
                        : Colors.black.withValues(alpha: 0.08),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.support_agent_rounded,
                      size: 16,
                      color: isDark ? Colors.white70 : AppColors.lightTextSecondary,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Support',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : AppColors.lightTextPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemRow(BuySellItem item, bool isDark, ThemeData theme) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.darkCardInner.withValues(alpha: 0.5)
            : AppColors.lightCardInner,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark
              ? AppColors.darkBorder.withValues(alpha: 0.6)
              : AppColors.lightBorder,
        ),
      ),
      child: Row(
        children: [
          // Token Icon
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: item.iconColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              item.icon,
              size: 18,
              color: item.iconColor,
            ),
          ),
          const SizedBox(width: 10),

          // Name and Crypto Amount
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : AppColors.lightTextPrimary,
                  ),
                ),
                Text(
                  item.cryptoAmount.toStringAsFixed(7),
                  style: TextStyle(
                    fontSize: 11,
                    color: isDark ? Colors.white54 : AppColors.lightTextSecondary,
                  ),
                ),
              ],
            ),
          ),

          // Currency Dropdown & Rate
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Text(
                        'USD',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.white70 : AppColors.lightTextPrimary,
                        ),
                      ),
                      const SizedBox(width: 2),
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 14,
                        color: isDark ? Colors.white54 : AppColors.lightTextSecondary,
                      ),
                    ],
                  ),
                  Text(
                    '\$${item.usdRate.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: isDark ? Colors.white : AppColors.lightTextPrimary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
