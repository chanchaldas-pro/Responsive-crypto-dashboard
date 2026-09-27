import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class FrostedSearchBar extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final String hintText;
  final double width;

  const FrostedSearchBar({
    super.key,
    this.onChanged,
    this.onSubmitted,
    this.hintText = 'Search assets, orders, transactions...',
    this.width = 300,
  });

  @override
  State<FrostedSearchBar> createState() => _FrostedSearchBarState();
}

class _FrostedSearchBarState extends State<FrostedSearchBar> {
  late final TextEditingController _controller;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Focus(
      onFocusChange: (focused) => setState(() => _isFocused = focused),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 14.0, sigmaY: 14.0),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width: widget.width,
            height: 48,
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withValues(alpha: _isFocused ? 0.14 : 0.08)
                  : Colors.white.withValues(alpha: _isFocused ? 0.85 : 0.65),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: _isFocused
                    ? AppColors.vibrantCoral
                    : (isDark
                        ? Colors.white.withValues(alpha: 0.2)
                        : Colors.black.withValues(alpha: 0.12)),
                width: _isFocused ? 1.5 : 1.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: _isFocused
                      ? AppColors.vibrantCoral.withValues(alpha: 0.25)
                      : Colors.black.withValues(alpha: 0.08),
                  blurRadius: _isFocused ? 16 : 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              children: [
                Icon(
                  Icons.search_rounded,
                  size: 20,
                  color: _isFocused
                      ? AppColors.vibrantCoral
                      : (isDark
                          ? Colors.white.withValues(alpha: 0.7)
                          : Colors.black.withValues(alpha: 0.6)),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onChanged: widget.onChanged,
                    onSubmitted: widget.onSubmitted,
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black87,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      filled: false,
                      contentPadding: EdgeInsets.zero,
                      hintText: widget.hintText,
                      hintStyle: TextStyle(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.5)
                            : Colors.black.withValues(alpha: 0.45),
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                if (_controller.text.isNotEmpty)
                  GestureDetector(
                    onTap: () {
                      _controller.clear();
                      widget.onChanged?.call('');
                      setState(() {});
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: Icon(
                        Icons.close_rounded,
                        size: 16,
                        color: isDark ? Colors.white70 : Colors.black54,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
