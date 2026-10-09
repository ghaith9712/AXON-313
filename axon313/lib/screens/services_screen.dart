import 'package:flutter/material.dart';

import '../data/catalog.dart';
import '../widgets/cta_band.dart';
import '../widgets/page_banner.dart';
import '../widgets/page_scroll.dart';
import '../widgets/process_timeline.dart';
import '../widgets/reveal.dart';
import '../widgets/section_header.dart';
import '../widgets/service_card.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageScroll(
      children: [
        const SizedBox(height: 8),
        const PageBanner(
          eyebrow: 'خدماتنا',
          title: 'ما الذي نبنيه لك؟',
          subtitle: 'تصميم البرامج والأنظمة الرقمية، كاميرات المراقبة، والخدمات الرقمية. اختر الخدمة لترى التفاصيل وخطوات العمل.',
        ),
        const SizedBox(height: 28),
        for (var i = 0; i < services.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 26),
            child: Reveal(
              child: ServiceFeature(service: services[i], index: i),
            ),
          ),
        const SectionHeader(
          eyebrow: 'طريقتنا',
          title: 'كيف نعمل معك',
          subtitle:
              'نفس المسار الواضح لكل خدمة، بلا مفاجآت في السعر أو الموعد.',
        ),
        const Reveal(child: ProcessTimeline(steps: processSteps)),
        const CtaBand(),
      ],
    );
  }
}
