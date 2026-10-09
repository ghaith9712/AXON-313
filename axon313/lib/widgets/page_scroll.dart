import 'package:flutter/material.dart';

import 'site_footer.dart';

class PageScroll extends StatelessWidget {
  const PageScroll({super.key, required this.children, this.footer = true});

  final List<Widget> children;
  final bool footer;

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= 960;
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(wide ? 32 : 16, 12, wide ? 32 : 16, 28),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1180),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [...children, if (footer) const SiteFooter()],
          ),
        ),
      ),
    );
  }
}
