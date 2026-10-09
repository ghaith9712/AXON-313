import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/catalog_models.dart';
import '../theme/app_colors.dart';
import 'hover_lift.dart';

class ServiceIconTile extends StatelessWidget {
  const ServiceIconTile({super.key, required this.service, this.size = 56});

  final ServiceOffering service;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size * 0.34),
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: service.gradient,
        ),
        boxShadow: [
          BoxShadow(
            color: service.accent.withValues(alpha: 0.35),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Icon(service.icon, color: Colors.white, size: size * 0.5),
    );
  }
}

class _ServiceImage extends StatelessWidget {
  const _ServiceImage({required this.service, required this.hovered});

  final ServiceOffering service;
  final bool hovered;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'service-image-${service.id}',
      child: SizedBox(
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            AnimatedScale(
              scale: hovered ? 1.08 : 1,
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOutCubic,
              child: Image.asset(service.imageAsset, fit: BoxFit.cover),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    service.accent.withValues(alpha: 0.78),
                    service.accent.withValues(alpha: 0.12),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TagPill extends StatelessWidget {
  const _TagPill(this.tag);

  final String tag;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        tag,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: AppColors.navy,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.4,
        ),
      ),
    );
  }
}

class _MoreLink extends StatelessWidget {
  const _MoreLink({required this.hovered, required this.color, this.label});

  final bool hovered;
  final Color color;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label ?? 'تفاصيل الخدمة',
          style: Theme.of(context).textTheme.titleSmall
              ?.copyWith(color: color, fontWeight: FontWeight.w800),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 260),
          curve: Curves.easeOutCubic,
          transform: Matrix4.translationValues(hovered ? -6 : 0, 0, 0),
          margin: const EdgeInsetsDirectional.only(start: 8),
          child: Icon(Icons.arrow_back_rounded, color: color, size: 20),
        ),
      ],
    );
  }
}

/// Compact service card used in grids on the home page and detail pages.
class ServiceCard extends StatelessWidget {
  const ServiceCard({super.key, required this.service, required this.index});

  final ServiceOffering service;
  final int index;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return HoverLift(
      radius: 30,
      onTap: () => context.push('/services/${service.id}'),
      builder: (context, hovered) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 190,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned.fill(
                    child: _ServiceImage(service: service, hovered: hovered),
                  ),
                  PositionedDirectional(
                    top: 16,
                    start: 16,
                    child: _TagPill(service.tag),
                  ),
                  PositionedDirectional(
                    end: 20,
                    bottom: -28,
                    child: ServiceIconTile(service: service, size: 60),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 22, 22, 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '0${index + 1}',
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: service.accentLight,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    service.title,
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: AppColors.navy,
                      fontWeight: FontWeight.w900,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    service.summary,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.muted,
                      height: 1.75,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final point in service.points.take(2))
                        _PointChip(label: point, color: service.accent),
                    ],
                  ),
                  const SizedBox(height: 18),
                  _MoreLink(hovered: hovered, color: service.accent),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _PointChip extends StatelessWidget {
  const _PointChip({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_rounded, size: 15, color: color),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              label,
              style: Theme.of(context).textTheme.labelMedium
                  ?.copyWith(color: color, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}

/// Large editorial service block used on the services page.
class ServiceFeature extends StatelessWidget {
  const ServiceFeature({super.key, required this.service, required this.index});

  final ServiceOffering service;
  final int index;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final wide = MediaQuery.sizeOf(context).width >= 860;
    final number = '0${index + 1}';

    return HoverLift(
      radius: 36,
      onTap: () => context.push('/services/${service.id}'),
      builder: (context, hovered) {
        final media = Stack(
          children: [
            Positioned.fill(
              child: _ServiceImage(service: service, hovered: hovered),
            ),
            PositionedDirectional(
              top: 20,
              start: 20,
              child: _TagPill(service.tag),
            ),
            PositionedDirectional(
              bottom: 8,
              end: 22,
              child: Text(
                number,
                style: theme.textTheme.displayLarge?.copyWith(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontWeight: FontWeight.w900,
                  fontSize: wide ? 96 : 64,
                  height: 1,
                ),
              ),
            ),
          ],
        );

        final content = Padding(
          padding: EdgeInsets.all(wide ? 36 : 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ServiceIconTile(service: service, size: 54),
              const SizedBox(height: 18),
              Text(
                service.title,
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: AppColors.navy,
                  fontWeight: FontWeight.w900,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                service.summary,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: AppColors.muted,
                  height: 1.8,
                ),
              ),
              const SizedBox(height: 18),
              for (final point in service.points)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 2),
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: service.accent.withValues(alpha: 0.12),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.check_rounded,
                          size: 14,
                          color: service.accent,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          point,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            height: 1.6,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 12),
              _MoreLink(
                hovered: hovered,
                color: service.accent,
                label: 'اكتشف الخدمة',
              ),
            ],
          ),
        );

        if (!wide) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 210, child: media),
              content,
            ],
          );
        }

        final mediaPane = Expanded(
          flex: 5,
          child: SizedBox(height: 460, child: media),
        );
        final textPane = Expanded(flex: 6, child: content);
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: index.isEven
              ? [mediaPane, textPane]
              : [textPane, mediaPane],
        );
      },
    );
  }
}
