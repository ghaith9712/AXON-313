import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class BrandMark extends StatelessWidget {
  const BrandMark({super.key, this.size = 36});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size * 0.32),
        gradient: const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [AppColors.blueMid, AppColors.blue, AppColors.green],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.blue.withValues(alpha: 0.28),
            blurRadius: size * 0.4,
            offset: Offset(0, size * 0.16),
          ),
        ],
      ),
      child: Text(
        'A',
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w900,
          fontSize: size * 0.5,
          height: 1,
        ),
      ),
    );
  }
}
