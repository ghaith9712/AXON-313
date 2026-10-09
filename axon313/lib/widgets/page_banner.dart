import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'aurora.dart';
import 'reveal.dart';

class PageBanner extends StatelessWidget {
  const PageBanner({
    super.key,
    required this.title,
    required this.subtitle,
    this.eyebrow,
    this.bottom,
  });

  final String title;
  final String subtitle;
  final String? eyebrow;
  final Widget? bottom;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final wide = MediaQuery.sizeOf(context).width >= 860;
    return Reveal(
      offset: 20,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(36),
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: AppColors.softGradient,
            borderRadius: BorderRadius.circular(36),
            border: Border.all(color: Colors.white, width: 1.5),
          ),
          child: Stack(
            children: [
              Aurora(
                size: 380,
                colors: [
                  AppColors.mint.withValues(alpha: 0.7),
                  AppColors.blueMid.withValues(alpha: 0.25),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(wide ? 44 : 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (eyebrow != null) ...[
                      Text(
                        eyebrow!,
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: AppColors.green,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                    Text(
                      title,
                      style: theme.textTheme.displaySmall?.copyWith(
                        color: AppColors.navy,
                        fontWeight: FontWeight.w900,
                        fontSize: wide ? 48 : 32,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 620),
                      child: Text(
                        subtitle,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: AppColors.muted,
                          height: 1.8,
                        ),
                      ),
                    ),
                    if (bottom != null) ...[
                      const SizedBox(height: 24),
                      bottom!,
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
