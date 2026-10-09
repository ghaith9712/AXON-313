import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Slowly drifting soft color orbs, used behind hero and call-to-action areas.
class Aurora extends StatefulWidget {
  const Aurora({super.key, required this.colors, this.size = 360});

  final List<Color> colors;
  final double size;

  @override
  State<Aurora> createState() => _AuroraState();
}

class _AuroraState extends State<Aurora> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 16),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: RepaintBoundary(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              final t = _controller.value * 2 * math.pi;
              return Stack(
                children: [
                  for (var i = 0; i < widget.colors.length; i++)
                    Align(
                      alignment: Alignment(
                        math.sin(t + i * 2.1) * 0.85,
                        math.cos(t * 0.8 + i * 1.7) * 0.8,
                      ),
                      child: Container(
                        width: widget.size,
                        height: widget.size,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              widget.colors[i],
                              widget.colors[i].withValues(alpha: 0),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class FloatBob extends StatefulWidget {
  const FloatBob({
    super.key,
    required this.child,
    this.distance = 8,
    this.period = const Duration(seconds: 4),
    this.phase = 0,
  });

  final Widget child;
  final double distance;
  final Duration period;
  final double phase;

  @override
  State<FloatBob> createState() => _FloatBobState();
}

class _FloatBobState extends State<FloatBob>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.period,
    value: widget.phase,
  )..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (context, child) {
        final value = Curves.easeInOut.transform(_controller.value);
        return Transform.translate(
          offset: Offset(0, (value - 0.5) * 2 * widget.distance),
          child: child,
        );
      },
    );
  }
}
