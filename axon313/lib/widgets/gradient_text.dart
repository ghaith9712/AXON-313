import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class GradientText extends StatelessWidget {
  const GradientText(this.text, {super.key, this.style});

  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => const LinearGradient(
        colors: [AppColors.blueMid, AppColors.blue, AppColors.green],
      ).createShader(bounds),
      child: Text(text, style: style?.copyWith(color: Colors.white)),
    );
  }
}
