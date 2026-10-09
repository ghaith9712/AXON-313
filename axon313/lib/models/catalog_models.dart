import 'package:flutter/material.dart';

class ServiceOffering {
  const ServiceOffering({
    required this.id,
    required this.title,
    required this.summary,
    required this.description,
    required this.icon,
    required this.points,
  });

  final String id;
  final String title;
  final String summary;
  final String description;
  final IconData icon;
  final List<String> points;
}

class ShopCategory {
  const ShopCategory({required this.id, required this.label});

  final String id;
  final String label;
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
