import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theme/app_colors.dart';
import 'aurora.dart';
import 'reveal.dart';

class CtaBand extends StatelessWidget {
  const CtaBand({
    super.key,
    this.title = 'ابدأ بوصف مختصر لما تحتاجه',
    this.body = 'برنامج، كاميرات، أو شبكة. نرد عليك لنحدد الخطوة التالية ونعطيك سعراً واضحاً قبل العمل.',
    this.primaryLabel = 'تواصل معنا',
    this.onPrimary,
    this.secondaryLabel,
    this.onSecondary,
  });

  final String title;
  final String body;
  final String primaryLabel;
  final VoidCallback? onPrimary;
  final String? secondaryLabel;
  final VoidCallback? onSecondary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final wide = MediaQuery.sizeOf(context).width >= 860;
    final buttons = Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: AppColors.navy,
          ),
          onPressed: onPrimary ?? () => context.go('/contact'),
          child: Text(primaryLabel),
        ),
        if (secondaryLabel != null)
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: BorderSide(color: Colors.white.withValues(alpha: 0.7)),
            ),
            onPressed: onSecondary,
            child: Text(secondaryLabel!),
          ),
      ],
    );
    final copy = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.headlineMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: wide ? 34 : 26,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          body,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: Colors.white.withValues(alpha: 0.82),
            height: 1.75,
          ),
        ),
      ],
    );
    return Padding(
      padding: EdgeInsets.only(top: wide ? 76 : 52),
      child: Reveal(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(34),
          child: DecoratedBox(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [AppColors.navy, AppColors.blue],
              ),
            ),
            child: Stack(
              children: [
                Aurora(
                  size: 420,
                  colors: [
                    AppColors.greenMid.withValues(alpha: 0.5),
                    AppColors.blueMid.withValues(alpha: 0.45),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(wide ? 48 : 26),
                  child: wide
                      ? Row(
                          children: [
                            Expanded(flex: 6, child: copy),
                            const SizedBox(width: 32),
                            Expanded(
                              flex: 3,
                              child: Align(
                                alignment: AlignmentDirectional.centerEnd,
                                child: buttons,
                              ),
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [copy, const SizedBox(height: 22), buttons],
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
