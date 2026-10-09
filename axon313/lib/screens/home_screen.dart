import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/catalog.dart';
import '../models/catalog_models.dart';
import '../theme/app_colors.dart';
import '../utils/external_links.dart';
import '../widgets/aurora.dart';
import '../widgets/cta_band.dart';
import '../widgets/gradient_text.dart';
import '../widgets/hover_lift.dart';
import '../widgets/page_scroll.dart';
import '../widgets/process_timeline.dart';
import '../widgets/product_tile.dart';
import '../widgets/reveal.dart';
import '../widgets/responsive_cards.dart';
import '../widgets/section_header.dart';
import '../widgets/service_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageScroll(
      children: [
        const SizedBox(height: 8),
        const _Hero(),
        SectionHeader(
          eyebrow: 'ما نقدمه',
          title: 'ثلاث خدمات، مسار واحد واضح',
          subtitle:
              'من الفكرة إلى التركيب والتسليم، كل خدمة لها طريقتها وخطواتها.',
          trailing: TextButton.icon(
            onPressed: () => context.go('/services'),
            icon: const Icon(Icons.arrow_back_rounded, size: 18),
            label: const Text('كل الخدمات'),
          ),
        ),
        ResponsiveCards(
          minTileWidth: 320,
          children: [
            for (var i = 0; i < services.length; i++)
              ServiceCard(service: services[i], index: i),
          ],
        ),
        const SectionHeader(
          eyebrow: 'لماذا AXON-313',
          title: 'عمل مرتب، وتواصل مباشر',
        ),
        const ResponsiveCards(
          minTileWidth: 250,
          maxColumns: 4,
          children: [
            _Benefit(
              icon: Icons.location_on_rounded,
              title: 'تنفيذ حسب المكان',
              body: 'العدد والمواصفات تُحدد بعد رؤية الموقع.',
            ),
            _Benefit(
              icon: Icons.translate_rounded,
              title: 'واجهات عربية',
              body: 'البرامج مصممة من اليمين إلى اليسار.',
            ),
            _Benefit(
              icon: Icons.forum_rounded,
              title: 'تواصل مباشر',
              body: 'الهاتف وواتساب خلال أوقات العمل.',
            ),
            _Benefit(
              icon: Icons.verified_rounded,
              title: 'سعر قبل العمل',
              body: 'يصلك السعر النهائي قبل أي تنفيذ.',
            ),
          ],
        ),
        const SectionHeader(
          eyebrow: 'طريقتنا',
          title: 'من الفكرة إلى التسليم في أربع خطوات',
        ),
        const Reveal(
          child: _Panel(child: ProcessTimeline(steps: processSteps)),
        ),
        SectionHeader(
          eyebrow: 'السوق',
          title: 'مختارات من السوق',
          subtitle: 'أسعار تقديرية. الطلب يُؤكد قبل الدفع والتوصيل.',
          trailing: TextButton.icon(
            onPressed: () => context.go('/shop'),
            icon: const Icon(Icons.arrow_back_rounded, size: 18),
            label: const Text('كل المنتجات'),
          ),
        ),
        ResponsiveCards(
          children: [
            for (final product in products.take(3))
              ProductTile(product: product),
          ],
        ),
        const SectionHeader(eyebrow: 'المعرض', title: 'من أعمالنا'),
        ResponsiveCards(
          children: [
            for (final work in galleryWorks.take(3)) _WorkTile(work: work),
          ],
        ),
        CtaBand(
          secondaryLabel: 'واتساب',
          onSecondary: () => openExternal(whatsAppUri('مرحباً AXON-313')),
        ),
      ],
    );
  }
}

class _Panel extends StatelessWidget {
  const _Panel({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= 860;
    return Container(
      padding: EdgeInsets.all(wide ? 36 : 22),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.navy.withValues(alpha: 0.05),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _Hero extends StatelessWidget {
  const _Hero();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final wide = MediaQuery.sizeOf(context).width >= 900;
    final titleStyle = theme.textTheme.displaySmall?.copyWith(
      fontSize: wide ? 62 : 38,
      fontWeight: FontWeight.w900,
      height: 1.18,
      color: AppColors.navy,
    );

    final copy = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Reveal(
          offset: 16,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.85),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.mint),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: AppColors.greenMid,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.greenMid.withValues(alpha: 0.7),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    'استوديو رقمي · كربلاء',
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: AppColors.green,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Reveal(
          delay: const Duration(milliseconds: 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('نصنع حلولك الرقمية', style: titleStyle),
              GradientText('بدقة وأناقة', style: titleStyle),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Reveal(
          delay: const Duration(milliseconds: 240),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Text(
              'برامج وأنظمة رقمية، كاميرات مراقبة، وخدمات شبكات. اختر من السوق ونؤكد لك السعر على واتساب.',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: AppColors.muted,
                height: 1.85,
                fontSize: 17,
              ),
            ),
          ),
        ),
        const SizedBox(height: 26),
        Reveal(
          delay: const Duration(milliseconds: 360),
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              FilledButton.icon(
                onPressed: () => context.go('/services'),
                icon: const Icon(Icons.arrow_back_rounded, size: 20),
                label: const Text('اكتشف خدماتنا'),
              ),
              OutlinedButton(
                onPressed: () => context.go('/shop'),
                child: const Text('تسوق الآن'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 26),
        const Reveal(
          delay: Duration(milliseconds: 480),
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _MiniBadge(
                icon: Icons.devices_rounded,
                label: 'ويب · ويندوز · هاتف',
              ),
              _MiniBadge(icon: Icons.translate_rounded, label: 'واجهة عربية'),
              _MiniBadge(icon: Icons.handyman_rounded, label: 'تركيب وصيانة'),
            ],
          ),
        ),
      ],
    );

    final visual = Reveal(
      delay: const Duration(milliseconds: 200),
      offset: 40,
      child: _HeroVisual(height: wide ? 500 : 360),
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(40),
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: AppColors.softGradient,
          border: Border.all(color: Colors.white, width: 1.5),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Stack(
          children: [
            Aurora(
              size: 480,
              colors: [
                AppColors.mint.withValues(alpha: 0.75),
                AppColors.blueMid.withValues(alpha: 0.28),
                Colors.white.withValues(alpha: 0.9),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(wide ? 52 : 22),
              child: wide
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(flex: 6, child: copy),
                        const SizedBox(width: 40),
                        Expanded(flex: 5, child: visual),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [copy, const SizedBox(height: 30), visual],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MiniBadge extends StatelessWidget {
  const _MiniBadge({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppColors.blue),
          const SizedBox(width: 6),
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium
                ?.copyWith(color: AppColors.navy, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

class _HeroVisual extends StatelessWidget {
  const _HeroVisual({required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(44),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.navy.withValues(alpha: 0.16),
                    blurRadius: 50,
                    offset: const Offset(0, 28),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(36),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset('assets/images/camera.webp', fit: BoxFit.cover),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.center,
                          colors: [
                            AppColors.navy.withValues(alpha: 0.45),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          PositionedDirectional(
            top: 28,
            end: -10,
            child: FloatBob(
              child: _FloatCard(
                icon: Icons.videocam_rounded,
                colors: const [AppColors.green, AppColors.greenMid],
                title: 'مراقبة عن بعد',
                subtitle: 'من هاتفك مباشرة',
              ),
            ),
          ),
          PositionedDirectional(
            bottom: 32,
            start: -10,
            child: FloatBob(
              phase: 0.5,
              child: _FloatCard(
                icon: Icons.code_rounded,
                colors: const [AppColors.blue, AppColors.blueMid],
                title: 'أنظمة مخصصة',
                subtitle: 'ويب · ويندوز · هاتف',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FloatCard extends StatelessWidget {
  const _FloatCard({
    required this.icon,
    required this.colors,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final List<Color> colors;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 12, 16, 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: AppColors.navy.withValues(alpha: 0.16),
            blurRadius: 30,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              gradient: LinearGradient(colors: colors),
            ),
            child: Icon(icon, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: theme.textTheme.titleSmall?.copyWith(
                  color: AppColors.navy,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                subtitle,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: AppColors.muted,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Benefit extends StatelessWidget {
  const _Benefit({required this.icon, required this.title, required this.body});

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: AppColors.greenLight,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: AppColors.green, size: 24),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              color: AppColors.navy,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            body,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.muted,
              height: 1.65,
            ),
          ),
        ],
      ),
    );
  }
}

class _WorkTile extends StatelessWidget {
  const _WorkTile({required this.work});

  final GalleryWork work;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return HoverLift(
      radius: 28,
      onTap: () => context.go('/gallery'),
      builder: (context, hovered) {
        return SizedBox(
          height: 250,
          child: Stack(
            fit: StackFit.expand,
            children: [
              AnimatedScale(
                scale: hovered ? 1.08 : 1,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOutCubic,
                child: Image.asset(work.asset, fit: BoxFit.cover),
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.center,
                    colors: [
                      AppColors.navy.withValues(alpha: 0.8),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
              PositionedDirectional(
                start: 20,
                end: 20,
                bottom: 18,
                child: Text(
                  work.title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
