import 'package:flutter/material.dart';

class WorkStep {
  const WorkStep({required this.title, required this.body});

  final String title;
  final String body;
}

class ServiceOffering {
  const ServiceOffering({
    required this.id,
    required this.title,
    required this.shortTitle,
    required this.tag,
    required this.summary,
    required this.description,
    required this.icon,
    required this.points,
    required this.imageAsset,
    required this.accent,
    required this.accentLight,
    required this.steps,
  });

  final String id;
  final String title;
  final String shortTitle;
  final String tag;
  final String summary;
  final String description;
  final IconData icon;
  final List<String> points;
  final String imageAsset;
  final Color accent;
  final Color accentLight;
  final List<WorkStep> steps;

  List<Color> get gradient => [accent, accentLight];
}

class ShopCategory {
  const ShopCategory({
    required this.id,
    required this.label,
    required this.icon,
  });

  final String id;
  final String label;
  final IconData icon;
}

class Product {
  const Product({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.summary,
    required this.description,
    required this.priceIqd,
    required this.icon,
    required this.imageAsset,
  });

  final String id;
  final String name;
  final String categoryId;
  final String summary;
  final String description;
  final int priceIqd;
  final IconData icon;
  final String imageAsset;
}

class GalleryWork {
  const GalleryWork({
    required this.asset,
    required this.title,
    required this.caption,
  });

  final String asset;
  final String title;
  final String caption;
}
