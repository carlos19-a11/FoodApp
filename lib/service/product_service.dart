import 'package:flutter/material.dart';
import 'package:food_delivery/models/food.dart';

class FoodService with ChangeNotifier {
  final List<Food> _foodItems = [];

  List<Food> get foodItems => _foodItems;

  void addFood(Food food) {
    _foodItems.add(food);
    notifyListeners();
  }

  void removeFood(String id) {
    _foodItems.removeWhere((food) => food.id == id);
    notifyListeners();
  }
}
