import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/company.dart';
import '../theme/app_colors.dart';
import '../widgets/axon_card.dart';
import '../widgets/page_scroll.dart';
import '../widgets/section_header.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PageScroll(
      children: [
        const SectionHeader(title: 'عن AXON-313', subtitle: Company.tagline),
        Text(
          Company.about,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: AppColors.muted,
            height: 1.8,
          ),
        ),
        const SizedBox(height: 16),
        AxonCard(
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 220,
                child: Image.asset(
                  'assets/images/network.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18),
                child: Text(
                  'البنية الرقمية والكاميرات والبرامج تُعامل كمشروع واحد عندما يحتاج الموقع إلى ذلك.',
                  style: theme.textTheme.bodyLarge?.copyWith(height: 1.7),
                ),
              ),
            ],
          ),
        ),
        const SectionHeader(title: 'أين نجدك'),
        const AxonCard(
          child: Column(
            children: [
              _Fact(
                icon: Icons.place_outlined,
                title: 'الموقع',
                value: Company.city,
              ),
              _Fact(
                icon: Icons.call_outlined,
                title: 'الهاتف',
                value: Company.phoneDisplay,
              ),
              _Fact(
                icon: Icons.mail_outline,
                title: 'البريد',
                value: Company.email,
              ),
              _Fact(
                icon: Icons.schedule_outlined,
                title: 'أوقات العمل',
                value: Company.hours,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        FilledButton.icon(
          onPressed: () => context.go('/contact'),
          icon: const Icon(Icons.arrow_forward),
          label: const Text('ابدأ مشروعك معنا'),
        ),
      ],
    );
  }
}

class _Fact extends StatelessWidget {
  const _Fact({required this.icon, required this.title, required this.value});

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: AppColors.gold),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.labelLarge
                      ?.copyWith(color: AppColors.muted),
                ),
                Text(value),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
