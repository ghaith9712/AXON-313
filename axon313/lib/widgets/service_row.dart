import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/catalog_models.dart';
import '../theme/app_colors.dart';

class ServiceRow extends StatelessWidget {
  const ServiceRow({super.key, required this.service, required this.index});

  final ServiceOffering service;
  final int index;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final number = (index + 1).toString().padLeft(2, '0');
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => context.go('/services/${service.id}'),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 22),
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: AppColors.border)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 52,
                child: Text(
                  number,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: AppColors.greenMid,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service.title,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: AppColors.blue,
                        fontWeight: FontWeight.w800,
                        height: 1.35,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      service.summary,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: AppColors.muted,
                        height: 1.7,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              const Padding(
                padding: EdgeInsets.only(top: 6),
                child: Icon(Icons.arrow_back, color: AppColors.blue, size: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
