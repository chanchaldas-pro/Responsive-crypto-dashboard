import 'package:flutter/material.dart';
import '../models/crypto_data.dart';
import '../theme/app_theme.dart';

class CryptoCard extends StatefulWidget {
  final CryptoAsset asset;
  final VoidCallback? onTap;

  const CryptoCard({
    super.key,
    required this.asset,
    this.onTap,
  });

  @override
  State<CryptoCard> createState() => _CryptoCardState();
}

class _CryptoCardState extends State<CryptoCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final asset = widget.asset;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.02 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: AppRadius.cardRadius,
          child: Container(
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkCard : AppColors.lightCard,
              borderRadius: AppRadius.cardRadius,
              border: Border.all(
                color: _isHovered
                    ? asset.primaryColor.withValues(alpha: 0.6)
                    : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
                width: _isHovered ? 1.5 : 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: _isHovered
                      ? asset.primaryColor.withValues(alpha: 0.18)
                      : (isDark
                          ? Colors.black.withValues(alpha: 0.2)
                          : const Color(0x100F172A)),
                  blurRadius: _isHovered ? 16 : 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: AppRadius.cardRadius,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Top Title & Icon
                  Padding(
                    padding: const EdgeInsets.only(left: 18, right: 18, top: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          asset.name,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: isDark ? Colors.white : AppColors.lightTextPrimary,
                            fontSize: 16,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: asset.primaryColor.withValues(alpha: 0.12),
                          ),
                          child: Icon(
                            asset.icon,
                            size: 18,
                            color: asset.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Sparkline Chart Section
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      child: CustomPaint(
                        size: Size.infinite,
                        painter: SparklineChartPainter(
                          points: asset.sparklineData,
                          primaryColor: asset.primaryColor,
                          secondaryColor: asset.secondaryColor,
                          isDark: isDark,
                        ),
                      ),
                    ),
                  ),

                  // Bottom Price & Percentage Badge
                  Padding(
                    padding: const EdgeInsets.only(left: 18, right: 18, bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '\$${asset.price.toStringAsFixed(asset.price > 100 ? 2 : 3)}',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                            fontSize: 18,
                            letterSpacing: -0.3,
                            color: isDark ? Colors.white : AppColors.lightTextPrimary,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: (asset.isPositive
                                    ? AppColors.successGreen
                                    : AppColors.warningRed)
                                .withValues(alpha: 0.14),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: (asset.isPositive
                                      ? AppColors.successGreen
                                      : AppColors.warningRed)
                                  .withValues(alpha: 0.3),
                              width: 0.8,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                asset.isPositive
                                    ? Icons.arrow_drop_up_rounded
                                    : Icons.arrow_drop_down_rounded,
                                size: 16,
                                color: asset.isPositive
                                    ? AppColors.successGreen
                                    : AppColors.warningRed,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                '${asset.isPositive ? '+' : ''}${asset.changePercentage.toStringAsFixed(2)}%',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: asset.isPositive
                                      ? AppColors.successGreen
                                      : AppColors.warningRed,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SparklineChartPainter extends CustomPainter {
  final List<double> points;
  final Color primaryColor;
  final Color secondaryColor;
  final bool isDark;

  SparklineChartPainter({
    required this.points,
    required this.primaryColor,
    required this.secondaryColor,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (points.length < 2) return;

    final double minVal = points.reduce((a, b) => a < b ? a : b);
    final double maxVal = points.reduce((a, b) => a > b ? a : b);
    final double range = (maxVal - minVal) == 0 ? 1.0 : (maxVal - minVal);

    final double stepX = size.width / (points.length - 1);
    final List<Offset> offsets = [];

    for (int i = 0; i < points.length; i++) {
      final double normalizedY = (points[i] - minVal) / range;
      final double y = size.height - (normalizedY * (size.height * 0.72) + (size.height * 0.14));
      final double x = i * stepX;
      offsets.add(Offset(x, y));
    }

    final Path strokePath = Path();
    strokePath.moveTo(offsets[0].dx, offsets[0].dy);

    for (int i = 0; i < offsets.length - 1; i++) {
      final p0 = offsets[i];
      final p1 = offsets[i + 1];
      final controlPoint1 = Offset(p0.dx + (p1.dx - p0.dx) / 2, p0.dy);
      final controlPoint2 = Offset(p0.dx + (p1.dx - p0.dx) / 2, p1.dy);
      strokePath.cubicTo(
        controlPoint1.dx,
        controlPoint1.dy,
        controlPoint2.dx,
        controlPoint2.dy,
        p1.dx,
        p1.dy,
      );
    }

    // Fill Path with Gradient
    final Path fillPath = Path.from(strokePath);
    fillPath.lineTo(size.width, size.height);
    fillPath.lineTo(0, size.height);
    fillPath.close();

    final fillPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          primaryColor.withValues(alpha: isDark ? 0.35 : 0.25),
          secondaryColor.withValues(alpha: 0.0),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    canvas.drawPath(fillPath, fillPaint);

    // Stroke line
    final strokePaint = Paint()
      ..shader = LinearGradient(
        colors: [primaryColor, secondaryColor],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.4
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(strokePath, strokePaint);

    // Highlight dot on peak or key point
    int peakIndex = 0;
    double highest = points[0];
    for (int i = 1; i < points.length; i++) {
      if (points[i] > highest) {
        highest = points[i];
        peakIndex = i;
      }
    }
    final peakOffset = offsets[peakIndex];

    // Outer glow
    final glowPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.4)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
    canvas.drawCircle(peakOffset, 6, glowPaint);

    // Inner white dot
    final dotPaint = Paint()..color = Colors.white;
    canvas.drawCircle(peakOffset, 3.5, dotPaint);

    // Outline
    final outlinePaint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawCircle(peakOffset, 3.5, outlinePaint);
  }

  @override
  bool shouldRepaint(covariant SparklineChartPainter oldDelegate) {
    return oldDelegate.points != points ||
        oldDelegate.primaryColor != primaryColor ||
        oldDelegate.isDark != isDark;
  }
}
