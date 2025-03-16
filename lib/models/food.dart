import 'package:flutter/material.dart';

// Modelo de Comida (Food)
class Food {
  final String id;
  final String name;
  final String description;
  final String imagPhat;
  final double price;
  final FoodCategory category;
  List<Addon> availableAddons;

  Food({
    required this.id,
    required this.name,
    required this.description,
    required this.imagPhat,
    required this.price,
    required this.category,
    required this.availableAddons,
  });
}

// Categorías de comida
enum FoodCategory {
  hamburguesa,
  sandwich,
  helado,
  pizza,
  bebidas,
}

// Modelo de Addon (Extras)
class Addon {
  final String name;
  final double price;

  Addon({required this.name, required this.price});
}
