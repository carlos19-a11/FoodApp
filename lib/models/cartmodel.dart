import 'package:flutter/material.dart';
import 'package:food_delivery/models/food.dart';

class CartModel extends ChangeNotifier {
  final List<Food> _items = []; // Lista de productos en el carrito

  List<Food> get items => _items;

  // Método para agregar un producto al carrito
  void addItem(Food food) {
    _items.add(food);
    notifyListeners(); // Notifica a los listeners cuando hay un cambio
  }

  // Método para eliminar un producto del carrito
  void removeItem(Food food) {
    _items.remove(food); // Eliminar el producto
    notifyListeners(); // Notificar a los listeners
  }

  // Método para contar la cantidad total de productos
  int get itemCount => _items.length;

  void clearCart() {}
}
