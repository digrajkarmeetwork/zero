import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

/// Custom card widget with ZERO styling
class ZeroCard extends StatelessWidget {
  const ZeroCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
    this.isHighlighted = false,
    this.highlightColor,
    this.gradient,
    this.borderRadius = 16,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final bool isHighlighted;
  final Color? highlightColor;
  final Gradient? gradient;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final effectiveHighlightColor = highlightColor ?? AppColors.primary;

    Widget card = Container(
      margin: margin,
      decoration: BoxDecoration(
        color: gradient == null ? AppColors.backgroundSecondary : null,
        gradient: gradient,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: isHighlighted
              ? effectiveHighlightColor.withValues(alpha: 0.3)
              : AppColors.borderLight,
          width: 1,
        ),
        boxShadow: isHighlighted
            ? [
                BoxShadow(
                  color: effectiveHighlightColor.withValues(alpha: 0.15),
                  blurRadius: 20,
                  spreadRadius: 0,
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(16),
          child: child,
        ),
      ),
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: card,
      );
    }

    return card;
  }
}

/// Card with left border accent
class ZeroAccentCard extends StatelessWidget {
  const ZeroAccentCard({
    super.key,
    required this.child,
    required this.accentColor,
    this.padding,
    this.margin,
    this.onTap,
  });

  final Widget child;
  final Color accentColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    Widget card = Container(
      margin: margin,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            accentColor.withValues(alpha: 0.1),
            Colors.transparent,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.borderLight,
          width: 1,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: accentColor,
              width: 3,
            ),
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(16),
          child: child,
        ),
      ),
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: card,
      );
    }

    return card;
  }
}
