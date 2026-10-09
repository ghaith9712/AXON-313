import 'package:flutter/material.dart';

import '../data/catalog.dart';
import '../widgets/page_scroll.dart';
import '../widgets/section_header.dart';
import '../widgets/service_row.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageScroll(
      children: [
        const SectionHeader(
          title: 'خدماتنا',
          subtitle: 'تصميم البرامج والأنظمة الرقمية، كاميرات المراقبة، والخدمات الرقمية.',
        ),
        for (var i = 0; i < services.length; i++)
          ServiceRow(service: services[i], index: i),
      ],
    );
  }
}
