// ignore_for_file: non_constant_identifier_names

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/models/cart_item.dart';
import 'package:intl/intl.dart';

import 'food.dart';

class Restaurant extends ChangeNotifier {
  // list of food menu
  final List<Food> _menu = [
    //burgers
    Food(
      name: "Corral Queso",
      description:
          "Jugosa carne 100% de res de 125 g, con una deliciosa tajada de queso tipo mozzarella, tomate en rodajas, cebolla en rodajas, lechuga, salsa blanca, salsa de tomate y mostaza en pan ajonjolí..",
      imagPhat: "assets/images/burgers/corral-queso.png",
      price: 13000,
      category: FoodCategory.hamburguesa,
      availableAddons: [
        Addon(name: "Queso Extra", price: 5000),
        Addon(name: "Tocino", price: 5000),
        Addon(name: "Carne", price: 7000),
      ],
    ),
    Food(
      name: "Todoterreno Callejera",
      description:
          "Dos carnes 100% de res de 125 g a la parrilla cada una, con salsa BBQ, tocineta, papas callejeras, una tajada de queso tipo mozzarella, mostaza y salsa blanca en pan ajonjolí..",
      imagPhat: "assets/images/burgers/todoterreno-callejera.png",
      price: 15000,
      category: FoodCategory.hamburguesa,
      availableAddons: [
        Addon(name: "Queso Extra", price: 5000),
        Addon(name: "Tocino", price: 5000),
        Addon(name: "Carne", price: 7000),
      ],
    ),
    Food(
      name: "Callejera",
      description:
          "Jugosa carne 100% de res de 125 g, una tajada de queso tipo mozzarella, papas callejeras, salsa blanca, salsa de tomate y mostaza en pan ajonjolí..",
      imagPhat: "assets/images/burgers/hamburguesas-callejera.png",
      price: 13000,
      category: FoodCategory.hamburguesa,
      availableAddons: [
        Addon(name: "Queso Extra", price: 5000),
        Addon(name: "Tocino", price: 5000),
        Addon(name: "Carne", price: 7000),
      ],
    ),
    Food(
      name: "Corral Mexinaca",
      description:
          "Jugosa carne 100% de res de 125 g, con una taja de queso tipo mozzarella, increíble guacamole, fríjol refrito, tomate en rodajas, cebolla en rodajas, lechuga fresca y salsa blanca en pan ajonjolí.",
      imagPhat: "assets/images/burgers/hamburguesas-corral-mexicana.png",
      price: 14000,
      category: FoodCategory.hamburguesa,
      availableAddons: [
        Addon(name: "Queso Extra", price: 5000),
        Addon(name: "Tocino", price: 5000),
        Addon(name: "Carne", price: 7000),
      ],
    ),
    Food(
      name: "Pollo Parrillero",
      description:
          "Jugosa pechuga de pollo de 154 g a la parrilla con salsa BBQ, pepinillos, tocineta, una taja de queso tipo mozzarella, pepinillos, cebolla en rodajas, lechuga y miel mostaza en pan ajonjolí.",
      imagPhat: "assets/images/burgers/pollo-parrillero.png",
      price: 14000,
      category: FoodCategory.hamburguesa,
      availableAddons: [
        Addon(name: "Extra cheese", price: 5000),
        Addon(name: "Bacon", price: 5000),
        Addon(name: "Avocado", price: 1000),
      ],
    ),
    //sandwich
    Food(
      name: "Sandwich Mexicano",
      description:
          "Pan Francés, Salsa Qbano, Lechuga Batavia, Carne de Res Desmechada, Cebolla cabezona roja, Frijol Negro, Pico de Gallo, Guacamole, Salsa Queso Cheddar, Nachos.",
      imagPhat: "assets/images/salads/sandwich-mexicano.png",
      price: 23.600,
      category: FoodCategory.sandwich,
      availableAddons: [
        Addon(name: "Extra carne", price: 7.000),
        Addon(name: "Pico de Gallo", price: 3.000),
        Addon(name: "Nachos", price: 3.000),
      ],
    ),
    Food(
      name: "Sandwich Ropa Vieja Combo",
      description:
          "Pan Francés, Carne de Res Desmechada, Queso Amarillo, Lechuga, Tomate, Pimentón, Apio, Mostaza, Salsa BBQ, Pasta de Tomate, Cebolla Roja y Salsa Qbano..",
      imagPhat: "assets/images/salads/sandwich-ropa-vieja-combo.png",
      price: 29.900,
      category: FoodCategory.sandwich,
      availableAddons: [
        Addon(name: "Extra carne", price: 7.000),
        Addon(name: "papas", price: 3.000),
        Addon(name: "Queso Amarillo", price: 6.000),
      ],
    ),
    Food(
      name: "Sandwich Hawaiano",
      description:
          "Pan Francés, Jamon de Cerdo, Piña Calada, Queso Mozzarella y Mayonesa.",
      imagPhat: "assets/images/salads/sandwich-hawaiano.png",
      price: 15.600,
      category: FoodCategory.sandwich,
      availableAddons: [
        Addon(name: "Extra carne", price: 7.000),
        Addon(name: "Piña Calada", price: 5.000),
        Addon(name: "Queso Mozzarella", price: 5.000),
      ],
    ),
    Food(
      name: "Sandwich Especial",
      description:
          "Mix de jamones (res y cerdo), queso mozzarella, lechuga batavia y salsa Qbano.",
      imagPhat: "assets/images/salads/sandwich-especial.png",
      price: 16.900,
      category: FoodCategory.sandwich,
      availableAddons: [
        Addon(name: "Extra carne", price: 7.000),
        Addon(name: "jamon", price: 2.000),
        Addon(name: "queso mozzarella", price: 5.000),
      ],
    ),
    Food(
      name: "Sandwich Burger",
      description:
          "Pan Francés, Carne Hamburguesa de Res y Cerdo, Queso Mozzarella, Tocineta, Lechuga Batavia, Tomate, Pepinillos, Salsa BBQ, Salsa Qbano.",
      imagPhat: "assets/images/salads/sandwich-burger.png",
      price: 22.600,
      category: FoodCategory.sandwich,
      availableAddons: [
        Addon(name: "Extra carne", price: 7.000),
        Addon(name: "Tocineta", price: 5.000),
        Addon(name: "Queso Mozzarella", price: 5.000),
      ],
    ),
    //Helados y mateadas
    Food(
      name: "Helado De Chocolate",
      description:
          "Preparadas con helado de chocolate y ralladura de chocolate.",
      imagPhat: "assets/images/sides/chocolate.png",
      price: 15.000,
      category: FoodCategory.helado,
      availableAddons: [
        Addon(name: "335 ml", price: 17.000),
        Addon(name: "473 ml", price: 18.000),
        Addon(name: "550 ml", price: 23.000),
      ],
    ),
    Food(
      name: "Helado Brownie",
      description:
          "Brownie con cobertura de chocolate o arequipe. Acompañado de una bola de helado y ralladura de chocolate.",
      imagPhat: "assets/images/sides/browni.png",
      price: 12.000,
      category: FoodCategory.helado,
      availableAddons: [
        Addon(name: "Bolas Helado", price: 3.000),
        Addon(name: "salsa", price: 2.000),
        Addon(name: "chips", price: 2.000),
      ],
    ),
    Food(
      name: "Helado De cvainilla y café",
      description: "Preparadas con helado de vainilla y café.",
      imagPhat: "assets/images/sides/helados-café.png",
      price: 12.000,
      category: FoodCategory.helado,
      availableAddons: [
        Addon(name: "335 ml", price: 15.000),
        Addon(name: "473 ml", price: 17.000),
        Addon(name: "550 ml", price: 20.000),
      ],
    ),
    Food(
      name: "Helado De fresa",
      description: "Preparadas con helado de fresa y ralladura de chocolate.",
      imagPhat: "assets/images/sides/helados-fresa.png",
      price: 12.000,
      category: FoodCategory.helado,
      availableAddons: [
        Addon(name: "335 ml", price: 15.000),
        Addon(name: "473 ml", price: 17.000),
        Addon(name: "550 ml", price: 20.000),
      ],
    ),
    Food(
      name: "Helado De Frutos Rojos",
      description: "Preparadas con helado de frutos rojos y salsa de mora.",
      imagPhat: "assets/images/sides/frutos-del-bosque.png",
      price: 14.000,
      category: FoodCategory.helado,
      availableAddons: [
        Addon(name: "335 ml", price: 16.000),
        Addon(name: "473 ml", price: 19.000),
        Addon(name: "550 ml", price: 25.000),
      ],
    ),

    //pizza
    Food(
      name: "Pizza 3 Estaciones",
      description:
          "Nuestra versión especial de pollo y champiñones con chorizo.",
      imagPhat: "assets/images/desserts/pizza-3-estaciones.png",
      price: 15.000,
      category: FoodCategory.pizza,
      availableAddons: [
        Addon(name: "Queso", price: 5.000),
        Addon(name: "Champiñones", price: 2.000),
        Addon(name: "Chorizo", price: 2.000),
      ],
    ),
    Food(
      name: "Pizza Americana",
      description: "Maíz tierno y tocineta con un toque picantico de pepperon.",
      imagPhat: "assets/images/desserts/Americana.png",
      price: 18.000,
      category: FoodCategory.pizza,
      availableAddons: [
        Addon(name: "Maíz tierno", price: 2.000),
        Addon(name: "Tocineta", price: 5.000),
        Addon(name: "Pepperon", price: 3.000),
      ],
    ),
    Food(
      name: "Pizza Honolulu",
      description: "Una combinación increíble con piña, tocineta y jalapeño.",
      imagPhat: "assets/images/desserts/Honolulu.png",
      price: 18.900,
      category: FoodCategory.pizza,
      availableAddons: [
        Addon(name: "Piña", price: 2.000),
        Addon(name: "Tocineta", price: 5.000),
        Addon(name: "Jalapeño", price: 2.000),
      ],
    ),
    Food(
      name: "Pizza Triple Pepperoni",
      description:
          "Perfectamente horneada con el sabor del pepperoni en su máxima expresión.",
      imagPhat: "assets/images/desserts/Triple-Pepperoni.png",
      price: 12.000,
      category: FoodCategory.pizza,
      availableAddons: [
        Addon(name: "Pepperoni", price: 3.000),
        Addon(name: "Queso", price: 5.000),
        Addon(name: "Chorizo", price: 2.000),
      ],
    ),
    Food(
      name: "Pizza Hawaiian Chick",
      description:
          "Queso Mozarella, trocitos de pollo, piña, tocineta y salsa B.B.Q..",
      imagPhat: "assets/images/desserts/Hawaiian-Chick.png",
      price: 22.000,
      category: FoodCategory.pizza,
      availableAddons: [
        Addon(name: "Pollo", price: 5.000),
        Addon(name: "Tocineta", price: 5.000),
        Addon(name: "Piña", price: 2.000),
      ],
    ),

    //bebidas
    Food(
      name: "Coca-Cola sabor original 600 ml",
      description:
          "El auténtico sabor de la bebida Coca-Cola®, una refrescante manera de compartir los mejores momentos.",
      imagPhat: "assets/images/drinks/Coca-Cola-sabor-original.png",
      price: 4.000,
      category: FoodCategory.bebidas,
      availableAddons: [
        Addon(name: "1 lt", price: 7.500),
        Addon(name: "1.5 lt", price: 10.500),
        Addon(name: "3 lt", price: 15.000),
      ],
    ),
    Food(
      name: "Coca-Cola Zero 600 ml",
      description:
          "El auténtico sabor de la bebida Coca-Cola® Zero, una refrescante manera de compartir los mejores momentos.",
      imagPhat: "assets/images/drinks/Coca-Cola-Zero.png",
      price: 3.000,
      category: FoodCategory.bebidas,
      availableAddons: [
        Addon(name: "1 lt", price: 6.500),
        Addon(name: "1.5 lt", price: 8.500),
        Addon(name: "3 lt", price: 12.000),
      ],
    ),
    Food(
      name: "Quatro Toronja 400 ml",
      description:
          "El auténtico sabor de la bebida Quatro Toronja, una refrescante manera de compartir los mejores momentos.",
      imagPhat: "assets/images/drinks/Quatro-Toronja.png",
      price: 3.000,
      category: FoodCategory.bebidas,
      availableAddons: [
        Addon(name: "1 lt", price: 6.000),
        Addon(name: "1.5 lt", price: 8.500),
        Addon(name: "3 lt", price: 11.800),
      ],
    ),
    Food(
      name: "Sprite Limón 500 ml",
      description:
          "El auténtico sabor de la bebida Sprite Limón, una refrescante manera de compartir los mejores momentos.",
      imagPhat: "assets/images/drinks/Sprite-Limón.png",
      price: 12.000,
      category: FoodCategory.bebidas,
      availableAddons: [
        Addon(name: "1.5 lt", price: 6.000),
        Addon(name: "2 lt", price: 8.000),
        Addon(name: "3 lt", price: 12.000),
      ],
    ),
    Food(
      name: "Club Colombia 330 ml",
      description:
          "La cerveza Club Colombia es de tipo lager de color dorado, elaborada con cebada malteada y malta de caramelo. Es una cerveza para las personas que disfruten de experiencias perfectas.",
      imagPhat: "assets/images/drinks/InternaDorada.png",
      price: 3.500,
      category: FoodCategory.bebidas,
      availableAddons: [
        Addon(name: "Dorada", price: 3.500),
        Addon(name: "Roja", price: 3.500),
        Addon(name: "Negra", price: 3.500),
      ],
    ),
  ];

//user cart
  final List<CartItem> _cart = [];

  // delivery address (which user can change/update)

  String _deliveryAddress = 'Carrera 6 # 21-64';

  /*

  G E T T E R S  

 */

  List<Food> get menu => _menu;
  List<CartItem> get cart => _cart;
  String get deliveryAddress => _deliveryAddress;

/*

  O P E R A T I O N S 

 */

// add to cart
  void addToCart(Food food, List<Addon> selectedAddons) {
    //see if there is a cart item already with the same food and selected addons
    CartItem? cartItem = _cart.firstWhereOrNull((item) {
      // check if the food items are the same
      bool isSameFood = item.food == food;

      // check if the list of selected addons are the same
      bool isSameAddons =
          const ListEquality().equals(item.selectedAddons, selectedAddons);

      return isSameFood && isSameAddons;
    });

    // if item already exists, increase it's quantity
    if (cartItem != null) {
      cartItem.quantity++;
    }

    // otherwise, add a new cart item to the cart
    else {
      _cart.add(
        CartItem(
          food: food,
          selectedAddons: selectedAddons,
        ),
      );
    }
    notifyListeners();
  }

// remove from crat
  void removeFormCart(CartItem cartItem) {
    int cartIndex = _cart.indexOf(cartItem);

    if (cartIndex != -1) {
      if (_cart[cartIndex].quantity > 1) {
        _cart[cartIndex].quantity--;
      } else {
        _cart.removeAt(cartIndex);
      }
    }
    notifyListeners();
  }

// get total price of cart
  double getTotalPrice() {
    double total = 0.0;

    for (CartItem cartItem in _cart) {
      double itemTotal = cartItem.food.price;

      for (Addon addon in cartItem.selectedAddons) {
        itemTotal += addon.price;
      }
      total += itemTotal * cartItem.quantity;
    }
    return total;
  }

// get total number of items in cart
  int getTotalItemCount() {
    int totalItemCount = 0;

    for (CartItem cartItem in _cart) {
      totalItemCount += cartItem.quantity;
    }
    return totalItemCount;
  }

//clear cart
  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

// update delivery address

  void updateDeliveryAddress(String newaddress) {
    _deliveryAddress = newaddress;
    notifyListeners();
  }
/*

  H E L P E R S

 */

//generate a recept
  String displayCartReceipt() {
    final receipt = StringBuffer();
    receipt.writeln("Aquí está tu recibo.");
    receipt.writeln();

    // format the date to include up to seconds only
    String formattedDate =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    receipt.writeln(formattedDate);
    receipt.writeln();
    receipt.writeln("-----------------------------------------------------");

    for (final CartItem in _cart) {
      receipt.writeln(
          "${CartItem.quantity} x ${CartItem.food.name} - ${_formatPrice(CartItem.food.price)}");
      if (CartItem.selectedAddons.isNotEmpty) {
        receipt.writeln(
            " Complementos: ${_formatAddons(CartItem.selectedAddons)}");
      }
      receipt.writeln();
    }
    receipt.writeln("-----------------------------------------------------");
    receipt.writeln();
    receipt.writeln("Artículos totales: ${getTotalItemCount()}");
    receipt.writeln("Precio total: ${_formatPrice(getTotalPrice())}");
    receipt.writeln();
    receipt.writeln("Entregar en: $deliveryAddress");

    return receipt.toString();
  }

//format double value into money
  String _formatPrice(double price) {
    return "\$${price.toStringAsFixed(2)}";
  }

//format list of addons into a string summary
  String _formatAddons(List<Addon> addons) {
    return addons
        .map((addon) => "${addon.name}(${_formatPrice(addon.price)})")
        .join(",");
  }
}
