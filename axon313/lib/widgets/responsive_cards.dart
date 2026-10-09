import 'package:flutter/material.dart';

import 'reveal.dart';

class ResponsiveCards extends StatelessWidget {
  const ResponsiveCards({
    super.key,
    required this.children,
    this.minTileWidth = 300,
    this.maxColumns = 3,
    this.gap = 18,
    this.animate = true,
  });

  final List<Widget> children;
  final double minTileWidth;
  final int maxColumns;
  final double gap;
  final bool animate;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = ((constraints.maxWidth + gap) / (minTileWidth + gap))
            .floor()
            .clamp(1, maxColumns);
        return Column(
          children: [
            for (var index = 0; index < children.length; index += columns)
              Padding(
                padding: EdgeInsets.only(
                  bottom: index + columns < children.length ? gap : 0,
                ),
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (var column = 0; column < columns; column++)
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(
                              start: column == 0 ? 0 : gap,
                            ),
                            child: index + column < children.length
                                ? (animate
                                      ? Reveal(
                                          delay: Duration(
                                            milliseconds: 110 * column,
                                          ),
                                          child: children[index + column],
                                        )
                                      : children[index + column])
                                : const SizedBox.shrink(),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
