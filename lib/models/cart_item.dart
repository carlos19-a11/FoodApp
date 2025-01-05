import 'package:food_delivery/models/food.dart';
import 'package:intl/intl.dart';

class CartItem {
  Food food;
  List<Addon> selectedAddons;
  int quantity;

  CartItem({
    required this.food,
    required this.selectedAddons,
    this.quantity = 1,
  });

  // Formateador de moneda
  static final NumberFormat currencyFormatter =
      NumberFormat.simpleCurrency(locale: 'es_CO');

  // Obtener precio total
  double get totalPrice {
    double addonsPrice =
        selectedAddons.fold(0, (sum, addon) => sum + addon.price);
    return (food.price + addonsPrice) * quantity;
  }

  // Precio total formateado
  String get formattedTotalPrice {
    return currencyFormatter.format(totalPrice);
  }

  // Métodos para incrementar y decrementar la cantidad
  void incrementQuantity() {
    quantity++;
  }

  void decrementQuantity() {
    if (quantity > 1) {
      quantity--;
    }
  }
}
