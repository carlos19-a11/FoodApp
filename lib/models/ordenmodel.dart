import 'package:flutter/material.dart';

class OrderModel extends ChangeNotifier {
  List<Map<String, dynamic>> _orders = [];

  List<Map<String, dynamic>> get orders => _orders;

  // Agregar un nuevo pedido
  void addOrder(Map<String, dynamic> order) {
    _orders.add(order);
    notifyListeners(); // Notificar a los listeners que la lista de pedidos ha cambiado
  }

  // Actualizar el estado de una orden
  void updateOrderStatus(int index, String newStatus) {
    _orders[index]['status'] = newStatus;
    notifyListeners();
  }
}
