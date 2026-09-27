import 'package:flutter/material.dart';
import '../models/crypto_data.dart';
import '../theme/app_theme.dart';

class CheckoutChartCard extends StatefulWidget {
  const CheckoutChartCard({super.key});

  @override
  State<CheckoutChartCard> createState() => _CheckoutChartCardState();
}

class _CheckoutChartCardState extends State<CheckoutChartCard> {
  String _selectedTimeframe = 'Day';
  final List<String> _timeframes = ['Day', 'Week', 'Month', 'Year'];
  int? _hoveredIndex;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final points = MockCryptoRepository.getCheckoutPoints(_selectedTimeframe);

    return Container(
      padding: const EdgeInsets.all(22),
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
          // Header: Title & Timeframe Selector
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Checkout',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: isDark ? Colors.white : AppColors.lightTextPrimary,
                ),
              ),

              // Filter Tabs (Day, Week, Month, Year)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.05)
                      : Colors.black.withValues(alpha: 0.04),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: _timeframes.map((tf) {
                    final isSelected = _selectedTimeframe == tf;
                    return GestureDetector(
                      onTap: () => setState(() {
                        _selectedTimeframe = tf;
                        _hoveredIndex = null;
                      }),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? (isDark ? const Color(0xFF282E4D) : Colors.white)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.06),
                                    blurRadius: 3,
                                  ),
                                ]
                              : null,
                        ),
                        child: Text(
                          tf,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                            color: isSelected
                                ? (isDark ? Colors.white : AppColors.vibrantCoral)
                                : (isDark ? Colors.white54 : Colors.black54),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Wave Chart Area with Tooltip Overlay
          SizedBox(
            height: 190,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return MouseRegion(
                  onHover: (event) {
                    final boxWidth = constraints.maxWidth;
                    final stepX = boxWidth / (points.length - 1);
                    final index = (event.localPosition.dx / stepX).round().clamp(0, points.length - 1);
                    if (_hoveredIndex != index) {
                      setState(() => _hoveredIndex = index);
                    }
                  },
                  onExit: (_) => setState(() => _hoveredIndex = null),
                  child: Stack(
                    children: [
                      // Smooth Bezier Curve Canvas
                      Positioned.fill(
                        child: CustomPaint(
                          painter: CheckoutWavePainter(
                            points: points,
                            hoveredIndex: _hoveredIndex,
                            isDark: isDark,
                          ),
                        ),
                      ),

                      // Tooltip marker for default highlight or hover point
                      ..._buildTooltipMarkers(points, constraints.maxWidth, constraints.maxHeight, isDark),
                    ],
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 12),

          // Bottom Labels
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: points.map((p) {
              return Text(
                p.label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.white38 : AppColors.lightTextSecondary,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildTooltipMarkers(
    List<CheckoutPoint> points,
    double width,
    double height,
    bool isDark,
  ) {
    if (points.isEmpty) return [];

    final double stepX = width / (points.length - 1);
    final double minVal = points.map((p) => p.value).reduce((a, b) => a < b ? a : b);
    final double maxVal = points.map((p) => p.value).reduce((a, b) => a > b ? a : b);
    final double range = (maxVal - minVal) == 0 ? 1.0 : (maxVal - minVal);

    final List<Widget> widgets = [];

    for (int i = 0; i < points.length; i++) {
      final p = points[i];
      final isHovered = _hoveredIndex == i;
      final isDefaultHighlight = _hoveredIndex == null && p.isHighlight;

      if (isHovered || isDefaultHighlight) {
        final double normalizedY = (p.value - minVal) / range;
        final double y = height - (normalizedY * (height * 0.55) + (height * 0.22));
        final double x = i * stepX;

        final text = p.highlightText.isNotEmpty
            ? p.highlightText
            : '${p.value.toInt()} Checkouts';

        widgets.add(
          Positioned(
            left: (x - 55).clamp(0.0, width - 110),
            top: (y - 48).clamp(0.0, height - 30),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: 1.0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF282E4D) : const Color(0xFF0F172A),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: const Color(0xFF5E6FEE),
                        width: 1.2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF5E6FEE).withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      text,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 2),
                  // Small indicator square under pill
                  Container(
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(
                      color: const Color(0xFF818CF8),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    }

    return widgets;
  }
}

class CheckoutWavePainter extends CustomPainter {
  final List<CheckoutPoint> points;
  final int? hoveredIndex;
  final bool isDark;

  CheckoutWavePainter({
    required this.points,
    required this.hoveredIndex,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (points.length < 2) return;

    final double minVal = points.map((p) => p.value).reduce((a, b) => a < b ? a : b);
    final double maxVal = points.map((p) => p.value).reduce((a, b) => a > b ? a : b);
    final double range = (maxVal - minVal) == 0 ? 1.0 : (maxVal - minVal);

    final double stepX = size.width / (points.length - 1);
    final List<Offset> offsets = [];

    for (int i = 0; i < points.length; i++) {
      final double normalizedY = (points[i].value - minVal) / range;
      final double y = size.height - (normalizedY * (size.height * 0.55) + (size.height * 0.22));
      final double x = i * stepX;
      offsets.add(Offset(x, y));
    }

    // Smooth Bezier Curve Path
    final Path wavePath = Path();
    wavePath.moveTo(offsets[0].dx, offsets[0].dy);

    for (int i = 0; i < offsets.length - 1; i++) {
      final p0 = offsets[i];
      final p1 = offsets[i + 1];
      final controlPoint1 = Offset(p0.dx + (p1.dx - p0.dx) / 2, p0.dy);
      final controlPoint2 = Offset(p0.dx + (p1.dx - p0.dx) / 2, p1.dy);
      wavePath.cubicTo(
        controlPoint1.dx,
        controlPoint1.dy,
        controlPoint2.dx,
        controlPoint2.dy,
        p1.dx,
        p1.dy,
      );
    }

    // Shadow & Gradient Fill
    final Path fillPath = Path.from(wavePath);
    fillPath.lineTo(size.width, size.height);
    fillPath.lineTo(0, size.height);
    fillPath.close();

    final fillPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          const Color(0xFF6366F1).withValues(alpha: isDark ? 0.35 : 0.18),
          const Color(0xFF38BDF8).withValues(alpha: 0.0),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    canvas.drawPath(fillPath, fillPaint);

    // Main Stroke Line
    final strokePaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF5E6FEE), Color(0xFF60A5FA), Color(0xFF818CF8)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.6
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(wavePath, strokePaint);

    // Draw active or highlight node
    for (int i = 0; i < offsets.length; i++) {
      final isHovered = hoveredIndex == i;
      final isDefaultHighlight = hoveredIndex == null && points[i].isHighlight;

      if (isHovered || isDefaultHighlight) {
        final nodeOffset = offsets[i];

        // Glow circle
        final glow = Paint()
          ..color = const Color(0xFF818CF8).withValues(alpha: 0.4)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);
        canvas.drawCircle(nodeOffset, 12, glow);

        // Solid node circle
        final node = Paint()..color = const Color(0xFF5E6FEE);
        canvas.drawCircle(nodeOffset, 6, node);

        final center = Paint()..color = Colors.white;
        canvas.drawCircle(nodeOffset, 3, center);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CheckoutWavePainter oldDelegate) {
    return oldDelegate.points != points ||
        oldDelegate.hoveredIndex != hoveredIndex ||
        oldDelegate.isDark != isDark;
  }
}
