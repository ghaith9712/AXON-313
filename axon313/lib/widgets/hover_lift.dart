import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// A tappable surface that rises and gains shadow on hover or press.
class HoverLift extends StatefulWidget {
  const HoverLift({
    super.key,
    required this.builder,
    this.onTap,
    this.radius = 28,
    this.lift = 6,
    this.color = AppColors.surface,
  });

  final Widget Function(BuildContext context, bool hovered) builder;
  final VoidCallback? onTap;
  final double radius;
  final double lift;
  final Color color;

  @override
  State<HoverLift> createState() => _HoverLiftState();
}

class _HoverLiftState extends State<HoverLift> {
  bool _hovered = false;
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(widget.radius);
    final raised = _hovered && !_pressed;
    return AnimatedScale(
      scale: _pressed ? 0.985 : 1,
      duration: const Duration(milliseconds: 140),
      curve: Curves.easeOut,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0, raised ? -widget.lift : 0, 0),
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: radius,
          border: Border.all(
            color: raised
                ? AppColors.greenMid.withValues(alpha: 0.55)
                : AppColors.border,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.navy.withValues(alpha: raised ? 0.14 : 0.05),
              blurRadius: raised ? 36 : 18,
              offset: Offset(0, raised ? 18 : 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: radius,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.onTap,
              onHover: (value) => setState(() => _hovered = value),
              onHighlightChanged: (value) => setState(() => _pressed = value),
              child: widget.builder(context, _hovered),
            ),
          ),
        ),
      ),
    );
  }
}
