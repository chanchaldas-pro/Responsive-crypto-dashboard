import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../models/crypto_data.dart';
import '../theme/app_theme.dart';

class WalletPanel extends StatelessWidget {
  final VoidCallback? onSendPressed;
  final VoidCallback? onAddNewPressed;

  const WalletPanel({
    super.key,
    this.onSendPressed,
    this.onAddNewPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSidebar : AppColors.lightSidebar,
        borderRadius: AppRadius.cardRadius,
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black.withValues(alpha: 0.25) : const Color(0x100F172A),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Header
            _buildUserHeader(isDark),

            const SizedBox(height: 20),

            // Wallet Section Header
            Text(
              'Wallet',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: isDark ? Colors.white : AppColors.lightTextPrimary,
              ),
            ),

            const SizedBox(height: 12),

            // Top Card with + Add New & Crypto Tokens
            _buildWalletCard(isDark),

            const SizedBox(height: 16),

            // Community & Product Quick Links
            _buildCommunityAndProduct(isDark),

            const SizedBox(height: 20),

            // Gauges Row (75% BTC & 57% ETH) and Amount Send Card
            _buildGaugesAndSendSection(isDark),

            const SizedBox(height: 20),

            // Donut Chart Allocation Card
            _buildAllocationDonutCard(isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildUserHeader(bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [AppColors.vibrantCoral, Color(0xFF818CF8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(
                  color: isDark ? Colors.white24 : Colors.black12,
                  width: 1.5,
                ),
              ),
              child: const Icon(
                Icons.person_rounded,
                size: 22,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'William Smith',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: isDark ? Colors.white : AppColors.lightTextPrimary,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: AppColors.successGreen,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Verified Pro',
                      style: TextStyle(
                        fontSize: 11,
                        color: isDark ? Colors.white60 : AppColors.lightTextSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        // Window Controls (minimize, expand, close)
        Row(
          children: [
            Icon(Icons.remove_rounded, size: 16, color: isDark ? Colors.white54 : Colors.black45),
            const SizedBox(width: 8),
            Icon(Icons.crop_square_rounded, size: 14, color: isDark ? Colors.white54 : Colors.black45),
            const SizedBox(width: 8),
            Icon(Icons.close_rounded, size: 16, color: isDark ? Colors.white54 : Colors.black45),
          ],
        ),
      ],
    );
  }

  Widget _buildWalletCard(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCardInner.withValues(alpha: 0.6) : AppColors.lightCardInner,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
        ),
      ),
      child: Column(
        children: [
          // Add New Dotted Button
          InkWell(
            onTap: onAddNewPressed ?? () {},
            borderRadius: BorderRadius.circular(14),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isDark ? const Color(0xFF3B4468) : const Color(0xFFCBD5E1),
                  style: BorderStyle.solid,
                  width: 1.2,
                ),
                color: isDark ? Colors.white.withValues(alpha: 0.02) : Colors.black.withValues(alpha: 0.02),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.add_circle_outline_rounded,
                    size: 22,
                    color: isDark ? Colors.white70 : AppColors.lightTextSecondary,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '+ Add New',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white70 : AppColors.lightTextSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Quick Token Buttons Grid
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildTokenIcon(Icons.currency_bitcoin_rounded, const Color(0xFFF59E0B), isDark),
              _buildTokenIcon(Icons.diamond_rounded, const Color(0xFF3B82F6), isDark),
              _buildTokenIcon(Icons.toll_rounded, const Color(0xFF10B981), isDark),
              _buildTokenIcon(Icons.close_rounded, AppColors.vibrantCoral, isDark),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTokenIcon(IconData icon, Color color, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, size: 18, color: color),
    );
  }

  Widget _buildCommunityAndProduct(bool isDark) {
    final communityItems = MockCryptoRepository.getCommunityItems();
    final productItems = MockCryptoRepository.getProductItems();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Community
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Community',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white70 : AppColors.lightTextPrimary,
                ),
              ),
              const SizedBox(height: 8),
              ...communityItems.map((item) => Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      children: [
                        Icon(item.icon, size: 13, color: isDark ? Colors.white54 : AppColors.lightTextSecondary),
                        const SizedBox(width: 5),
                        Text(
                          item.title,
                          style: TextStyle(
                            fontSize: 11,
                            color: isDark ? Colors.white60 : AppColors.lightTextSecondary,
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),

        const SizedBox(width: 10),

        // Product
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Product',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white70 : AppColors.lightTextPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: productItems.map((item) => Text(
                  item.title,
                  style: TextStyle(
                    fontSize: 11,
                    color: isDark ? Colors.white60 : AppColors.lightTextSecondary,
                  ),
                )).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGaugesAndSendSection(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCardInner.withValues(alpha: 0.6) : AppColors.lightCardInner,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              // 75% BTC Gauge
              Expanded(
                child: _buildArcGaugeCard(
                  percentage: 0.75,
                  percentageText: '75%',
                  amount: '5.2547',
                  changeText: '-0.75%',
                  isPositive: false,
                  symbol: 'BTC',
                  color: const Color(0xFFFBBF24),
                  isDark: isDark,
                ),
              ),
              const SizedBox(width: 10),

              // 57% ETH Gauge
              Expanded(
                child: _buildArcGaugeCard(
                  percentage: 0.57,
                  percentageText: '57%',
                  amount: '7.8741',
                  changeText: '1.57%',
                  isPositive: true,
                  symbol: 'ETH',
                  color: const Color(0xFF38BDF8),
                  isDark: isDark,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Amount & Send Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Amount',
                    style: TextStyle(
                      fontSize: 11,
                      color: isDark ? Colors.white54 : AppColors.lightTextSecondary,
                    ),
                  ),
                  Text(
                    '26,247.00',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: isDark ? Colors.white : AppColors.lightTextPrimary,
                    ),
                  ),
                  Text(
                    'BKASD',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white38 : AppColors.lightTextSecondary,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: onSendPressed ?? () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.vibrantCoral,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Send',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildArcGaugeCard({
    required double percentage,
    required String percentageText,
    required String amount,
    required String changeText,
    required bool isPositive,
    required String symbol,
    required Color color,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF161A2D) : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? AppColors.darkBorder.withValues(alpha: 0.5) : AppColors.lightBorder,
        ),
      ),
      child: Column(
        children: [
          // Circular Arc Gauge
          SizedBox(
            width: 54,
            height: 54,
            child: CustomPaint(
              painter: ArcGaugePainter(
                progress: percentage,
                strokeColor: color,
                isDark: isDark,
              ),
              child: Center(
                child: Text(
                  percentageText,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: isDark ? Colors.white : AppColors.lightTextPrimary,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            amount,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : AppColors.lightTextPrimary,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isPositive ? Icons.arrow_drop_up_rounded : Icons.arrow_drop_down_rounded,
                size: 14,
                color: isPositive ? AppColors.successGreen : AppColors.warningRed,
              ),
              Text(
                changeText,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: isPositive ? AppColors.successGreen : AppColors.warningRed,
                ),
              ),
            ],
          ),
          Text(
            symbol,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white54 : AppColors.lightTextSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAllocationDonutCard(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCardInner.withValues(alpha: 0.6) : AppColors.lightCardInner,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
        ),
      ),
      child: Row(
        children: [
          // Donut Chart with +12% Total Center
          SizedBox(
            width: 86,
            height: 86,
            child: CustomPaint(
              painter: AllocationDonutPainter(isDark: isDark),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '+12%',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: isDark ? Colors.white : AppColors.lightTextPrimary,
                      ),
                    ),
                    Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: isDark ? Colors.white54 : AppColors.lightTextSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(width: 16),

          // Legend breakdown
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLegendItem(
                  color: const Color(0xFF3B82F6),
                  label: 'Bitcoin',
                  percentage: '31.78%',
                  isDark: isDark,
                ),
                const SizedBox(height: 8),
                _buildLegendItem(
                  color: AppColors.vibrantCoral,
                  label: 'Ethereum',
                  percentage: '27.15%',
                  isDark: isDark,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem({
    required Color color,
    required String label,
    required String percentage,
    required bool isDark,
  }) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.white70 : AppColors.lightTextPrimary,
            ),
          ),
        ),
        Text(
          percentage,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: isDark ? Colors.white : AppColors.lightTextPrimary,
          ),
        ),
      ],
    );
  }
}

class ArcGaugePainter extends CustomPainter {
  final double progress;
  final Color strokeColor;
  final bool isDark;

  ArcGaugePainter({
    required this.progress,
    required this.strokeColor,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 4;

    // Background track
    final bgPaint = Paint()
      ..color = isDark ? const Color(0xFF282E4D) : const Color(0xFFE2E8F0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi * 0.75,
      math.pi * 1.5,
      false,
      bgPaint,
    );

    // Active progress arc
    final progressPaint = Paint()
      ..color = strokeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi * 0.75,
      (math.pi * 1.5) * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant ArcGaugePainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.strokeColor != strokeColor ||
        oldDelegate.isDark != isDark;
  }
}

class AllocationDonutPainter extends CustomPainter {
  final bool isDark;

  AllocationDonutPainter({required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 6;

    final sections = [
      {'color': const Color(0xFF38BDF8), 'sweep': math.pi * 0.65},
      {'color': AppColors.vibrantCoral, 'sweep': math.pi * 0.55},
      {'color': const Color(0xFFA855F7), 'sweep': math.pi * 0.45},
      {'color': const Color(0xFF10B981), 'sweep': math.pi * 0.35},
    ];

    double startAngle = -math.pi / 2;

    for (var sec in sections) {
      final sweep = sec['sweep'] as double;
      final color = sec['color'] as Color;

      final paint = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 8.0
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweep - 0.1,
        false,
        paint,
      );

      startAngle += sweep;
    }
  }

  @override
  bool shouldRepaint(covariant AllocationDonutPainter oldDelegate) {
    return oldDelegate.isDark != isDark;
  }
}
