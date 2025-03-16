import 'dart:io';
import 'package:flutter/material.dart';
import 'package:food_delivery/models/food.dart';

class FoodDetailPage extends StatelessWidget {
  final Food food;

  const FoodDetailPage({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(food.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  File(food.imagPhat),
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildInfoRow(Icons.fastfood, "Nombre", food.name),
            _buildInfoRow(Icons.description, "Descripción", food.description),
            _buildInfoRow(Icons.category, "Categoría", food.category.name),
            _buildInfoRow(Icons.attach_money, "Precio", "\$${food.price}"),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 28, color: Colors.orange),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              "$label: $value",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
