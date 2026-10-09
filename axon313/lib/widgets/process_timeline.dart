import 'package:flutter/material.dart';

import '../models/catalog_models.dart';
import '../theme/app_colors.dart';
import 'reveal.dart';

class ProcessTimeline extends StatelessWidget {
  const ProcessTimeline({
    super.key,
    required this.steps,
    this.colors = const [AppColors.blue, AppColors.green],
    this.forceVertical = false,
  });

  final List<WorkStep> steps;
  final List<Color> colors;
  final bool forceVertical;

  @override
  Widget build(BuildContext context) {
    final horizontal =
        !forceVertical && MediaQuery.sizeOf(context).width >= 860;
    return horizontal ? _horizontal(context) : _vertical(context);
  }

  Widget _bubble(int index) {
    return Container(
      width: 44,
      height: 44,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: colors,
        ),
        boxShadow: [
          BoxShadow(
            color: colors.first.withValues(alpha: 0.3),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Text(
        '${index + 1}',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w900,
          fontSize: 17,
        ),
      ),
    );
  }

  Widget _texts(BuildContext context, WorkStep step) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          step.title,
          style: theme.textTheme.titleMedium?.copyWith(
            color: AppColors.navy,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          step.body,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: AppColors.muted,
            height: 1.65,
          ),
        ),
      ],
    );
  }

  Widget _horizontal(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < steps.length; i++)
          Expanded(
            child: Reveal(
              delay: Duration(milliseconds: 140 * i),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _bubble(i),
                      if (i != steps.length - 1)
                        Expanded(
                          child: Container(
                            height: 2,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  colors.first.withValues(alpha: 0.5),
                                  colors.last.withValues(alpha: 0.12),
                                ],
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 18),
                    child: _texts(context, steps[i]),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _vertical(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < steps.length; i++)
          Reveal(
            delay: Duration(milliseconds: 90 * i),
            offset: 20,
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    children: [
                      _bubble(i),
                      if (i != steps.length - 1)
                        Expanded(
                          child: Container(
                            width: 2,
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            color: colors.first.withValues(alpha: 0.2),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4, bottom: 22),
                      child: _texts(context, steps[i]),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
