// ignore_for_file: non_constant_identifier_names

import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/models/cart_item.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'food.dart';

class Restaurant extends ChangeNotifier {
  // list of food menu
  final List<Food> _menu = [
    //burgers
    Food(
      id: '',
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
      id: '',
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
      id: '',
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
      id: '',
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
      id: '',
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
      id: '',
      name: "Sandwich Mexicano",
      description:
          "Pan Francés, Salsa Qbano, Lechuga Batavia, Carne de Res Desmechada, Cebolla cabezona roja, Frijol Negro, Pico de Gallo, Guacamole, Salsa Queso Cheddar, Nachos.",
      imagPhat: "assets/images/salads/sandwich-mexicano.png",
      price: 23600,
      category: FoodCategory.sandwich,
      availableAddons: [
        Addon(name: "Extra carne", price: 7000),
        Addon(name: "Pico de Gallo", price: 3000),
        Addon(name: "Nachos", price: 3000),
      ],
    ),
    Food(
      id: '',
      name: "Sandwich Ropa Vieja Combo",
      description:
          "Pan Francés, Carne de Res Desmechada, Queso Amarillo, Lechuga, Tomate, Pimentón, Apio, Mostaza, Salsa BBQ, Pasta de Tomate, Cebolla Roja y Salsa Qbano..",
      imagPhat: "assets/images/salads/sandwich-ropa-vieja-combo.png",
      price: 29000,
      category: FoodCategory.sandwich,
      availableAddons: [
        Addon(name: "Extra carne", price: 7000),
        Addon(name: "papas", price: 3000),
        Addon(name: "Queso Amarillo", price: 6000),
      ],
    ),
    Food(
      id: '',
      name: "Sandwich Hawaiano",
      description:
          "Pan Francés, Jamon de Cerdo, Piña Calada, Queso Mozzarella y Mayonesa.",
      imagPhat: "assets/images/salads/sandwich-hawaiano.png",
      price: 15600,
      category: FoodCategory.sandwich,
      availableAddons: [
        Addon(name: "Extra carne", price: 7000),
        Addon(name: "Piña Calada", price: 5000),
        Addon(name: "Queso Mozzarella", price: 5000),
      ],
    ),
    Food(
      id: '',
      name: "Sandwich Especial",
      description:
          "Mix de jamones (res y cerdo), queso mozzarella, lechuga batavia y salsa Qbano.",
      imagPhat: "assets/images/salads/sandwich-especial.png",
      price: 16900,
      category: FoodCategory.sandwich,
      availableAddons: [
        Addon(name: "Extra carne", price: 7000),
        Addon(name: "jamon", price: 2000),
        Addon(name: "queso mozzarella", price: 5000),
      ],
    ),
    Food(
      id: '',
      name: "Sandwich Burger",
      description:
          "Pan Francés, Carne Hamburguesa de Res y Cerdo, Queso Mozzarella, Tocineta, Lechuga Batavia, Tomate, Pepinillos, Salsa BBQ, Salsa Qbano.",
      imagPhat: "assets/images/salads/sandwich-burger.png",
      price: 22600,
      category: FoodCategory.sandwich,
      availableAddons: [
        Addon(name: "Extra carne", price: 7000),
        Addon(name: "Tocineta", price: 5000),
        Addon(name: "Queso Mozzarella", price: 5000),
      ],
    ),
    //Helados y mateadas
    Food(
      id: '',
      name: "Helado De Chocolate",
      description:
          "Preparadas con helado de chocolate y ralladura de chocolate.",
      imagPhat: "assets/images/sides/chocolate.png",
      price: 15000,
      category: FoodCategory.helado,
      availableAddons: [
        Addon(name: "335 ml", price: 17000),
        Addon(name: "473 ml", price: 18000),
        Addon(name: "550 ml", price: 23000),
      ],
    ),
    Food(
      id: '',
      name: "Helado Brownie",
      description:
          "Brownie con cobertura de chocolate o arequipe. Acompañado de una bola de helado y ralladura de chocolate.",
      imagPhat: "assets/images/sides/browni.png",
      price: 12000,
      category: FoodCategory.helado,
      availableAddons: [
        Addon(name: "Bolas Helado", price: 3000),
        Addon(name: "salsa", price: 2000),
        Addon(name: "chips", price: 2000),
      ],
    ),
    Food(
      id: '',
      name: "Helado De cvainilla y café",
      description: "Preparadas con helado de vainilla y café.",
      imagPhat: "assets/images/sides/helados-café.png",
      price: 12000,
      category: FoodCategory.helado,
      availableAddons: [
        Addon(name: "335 ml", price: 15000),
        Addon(name: "473 ml", price: 17000),
        Addon(name: "550 ml", price: 20000),
      ],
    ),
    Food(
      id: '',
      name: "Helado De fresa",
      description: "Preparadas con helado de fresa y ralladura de chocolate.",
      imagPhat: "assets/images/sides/helados-fresa.png",
      price: 12000,
      category: FoodCategory.helado,
      availableAddons: [
        Addon(name: "335 ml", price: 15000),
        Addon(name: "473 ml", price: 17000),
        Addon(name: "550 ml", price: 20000),
      ],
    ),
    Food(
      id: '',
      name: "Helado De Frutos Rojos",
      description: "Preparadas con helado de frutos rojos y salsa de mora.",
      imagPhat: "assets/images/sides/frutos-del-bosque.png",
      price: 14000,
      category: FoodCategory.helado,
      availableAddons: [
        Addon(name: "335 ml", price: 16000),
        Addon(name: "473 ml", price: 19000),
        Addon(name: "550 ml", price: 25000),
      ],
    ),

    //pizza
    Food(
      id: '',
      name: "Pizza 3 Estaciones",
      description:
          "Nuestra versión especial de pollo y champiñones con chorizo.",
      imagPhat: "assets/images/desserts/pizza-3-estaciones.png",
      price: 15000,
      category: FoodCategory.pizza,
      availableAddons: [
        Addon(name: "Queso", price: 5000),
        Addon(name: "Champiñones", price: 2000),
        Addon(name: "Chorizo", price: 2000),
      ],
    ),
    Food(
      id: '',
      name: "Pizza Americana",
      description: "Maíz tierno y tocineta con un toque picantico de pepperon.",
      imagPhat: "assets/images/desserts/Americana.png",
      price: 18000,
      category: FoodCategory.pizza,
      availableAddons: [
        Addon(name: "Maíz tierno", price: 2000),
        Addon(name: "Tocineta", price: 5000),
        Addon(name: "Pepperon", price: 3000),
      ],
    ),
    Food(
      id: '',
      name: "Pizza Honolulu",
      description: "Una combinación increíble con piña, tocineta y jalapeño.",
      imagPhat: "assets/images/desserts/Honolulu.png",
      price: 18900,
      category: FoodCategory.pizza,
      availableAddons: [
        Addon(name: "Piña", price: 2000),
        Addon(name: "Tocineta", price: 5000),
        Addon(name: "Jalapeño", price: 2000),
      ],
    ),
    Food(
      id: '',
      name: "Pizza Triple Pepperoni",
      description:
          "Perfectamente horneada con el sabor del pepperoni en su máxima expresión.",
      imagPhat: "assets/images/desserts/Triple-Pepperoni.png",
      price: 12000,
      category: FoodCategory.pizza,
      availableAddons: [
        Addon(name: "Pepperoni", price: 3000),
        Addon(name: "Queso", price: 5000),
        Addon(name: "Chorizo", price: 2000),
      ],
    ),
    Food(
      id: '',
      name: "Pizza Hawaiian Chick",
      description:
          "Queso Mozarella, trocitos de pollo, piña, tocineta y salsa B.B.Q..",
      imagPhat: "assets/images/desserts/Hawaiian-Chick.png",
      price: 22000,
      category: FoodCategory.pizza,
      availableAddons: [
        Addon(name: "Pollo", price: 5000),
        Addon(name: "Tocineta", price: 5000),
        Addon(name: "Piña", price: 2000),
      ],
    ),

    //bebidas
    Food(
      id: '',
      name: "Coca-Cola sabor original 600 ml",
      description:
          "El auténtico sabor de la bebida Coca-Cola®, una refrescante manera de compartir los mejores momentos.",
      imagPhat: "assets/images/drinks/Coca-Cola-sabor-original.png",
      price: 4000,
      category: FoodCategory.bebidas,
      availableAddons: [
        Addon(name: "1 lt", price: 7500),
        Addon(name: "1.5 lt", price: 10500),
        Addon(name: "3 lt", price: 15000),
      ],
    ),
    Food(
      id: '',
      name: "Coca-Cola Zero 600 ml",
      description:
          "El auténtico sabor de la bebida Coca-Cola® Zero, una refrescante manera de compartir los mejores momentos.",
      imagPhat: "assets/images/drinks/Coca-Cola-Zero.png",
      price: 3000,
      category: FoodCategory.bebidas,
      availableAddons: [
        Addon(name: "1 lt", price: 6500),
        Addon(name: "1.5 lt", price: 8500),
        Addon(name: "3 lt", price: 12000),
      ],
    ),
    Food(
      id: '',
      name: "Quatro Toronja 400 ml",
      description:
          "El auténtico sabor de la bebida Quatro Toronja, una refrescante manera de compartir los mejores momentos.",
      imagPhat: "assets/images/drinks/Quatro-Toronja.png",
      price: 3000,
      category: FoodCategory.bebidas,
      availableAddons: [
        Addon(name: "1 lt", price: 6000),
        Addon(name: "1.5 lt", price: 8500),
        Addon(name: "3 lt", price: 11800),
      ],
    ),
    Food(
      id: '',
      name: "Sprite Limón 500 ml",
      description:
          "El auténtico sabor de la bebida Sprite Limón, una refrescante manera de compartir los mejores momentos.",
      imagPhat: "assets/images/drinks/Sprite-Limón.png",
      price: 12000,
      category: FoodCategory.bebidas,
      availableAddons: [
        Addon(name: "1.5 lt", price: 6000),
        Addon(name: "2 lt", price: 8000),
        Addon(name: "3 lt", price: 12000),
      ],
    ),
    Food(
      id: '',
      name: "Club Colombia 330 ml",
      description:
          "La cerveza Club Colombia es de tipo lager de color dorado, elaborada con cebada malteada y malta de caramelo. Es una cerveza para las personas que disfruten de experiencias perfectas.",
      imagPhat: "assets/images/drinks/InternaDorada.png",
      price: 3500,
      category: FoodCategory.bebidas,
      availableAddons: [
        Addon(name: "Dorada", price: 3500),
        Addon(name: "Roja", price: 3500),
        Addon(name: "Negra", price: 3500),
      ],
    ),
  ];

//user cart

  final List<CartItem> _cart = [];

  // delivery address (which user can change/update)

  String _deliveryAddress = 'Carrera 6 # 21-64';
  String? _selectedTable;
  List<String> availableTables = []; // Lista dinámica de mesas

  bool _isPaid = false;

  // Getter de pago
  bool get isPaid => _isPaid;

  // Lista para almacenar los pedidos realizados
  List<Map<String, dynamic>> _orders = [];

  // Getter de pedidos
  List<Map<String, dynamic>> get orders => _orders;

  void addOrder(String userEmail, String table) {
    if (_cart.isEmpty) return; // No se puede agregar un pedido vacío

    final totalPrice = getTotalPrice();
    final newOrder = {
      'id': DateTime.now().toString(),
      'total': totalPrice,
      'items': _cart
          .map((cartItem) => {
                'name': cartItem.food.name,
                'addons': cartItem.selectedAddons.isNotEmpty
                    ? cartItem.selectedAddons
                        .map((addon) => addon.name)
                        .toList()
                    : [], // Lista de nombres de los adicionales
              })
          .toList(),
      'status': 'Pendiente',
      'userEmail': userEmail,
      'table': table,
      'date': DateFormat('yyyy-MM-dd hh:mm a').format(DateTime.now()),
    };

    _orders.add(newOrder);
    notifyListeners();

    // Limpiar el carrito después de agregar el pedido
    clearCart();
  }

  String _formatDate(String date) {
    final DateTime parsedDate =
        DateFormat('yyyy-MM-dd').parse(date); // Parsear la fecha original
    return DateFormat('dd-MM-yyyy')
        .format(parsedDate); // Formatearla en el formato deseado
  }

  // Método para limpiar el carrito después de realizar un pago o agregar un pedido
  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  /*

  G E T T E R S  

 */

  List<Food> get menu => _menu;
  List<CartItem> get cart => _cart;
  String get deliveryAddress => _deliveryAddress;
  String? get selectedTable => _selectedTable;

/*

  O P E R A T I O N S 

 */

  void updateOrderStatus(String orderId, String newStatus) {
    final order = _orders.firstWhere((order) => order['id'] == orderId);

    if (order['status'] == 'Completado') {
      return; // No permitir cambios si el estado es "Completado"
    }

    order['status'] = newStatus;

    if (newStatus == 'Completado') {
      order['completedTime'] = DateFormat('hh:mm a').format(DateTime.now());
    }

    notifyListeners();
  }

  // En el modelo Restaurant, dentro de los métodos addToCart y removeFromCart

// Método para agregar al carrito
  void addToCart(Food food, List<Addon> selectedAddons) {
    // Verificar si ya existe el item en el carrito
    CartItem? cartItem = _cart.firstWhereOrNull((item) {
      bool isSameFood = item.food == food;
      bool isSameAddons =
          const ListEquality().equals(item.selectedAddons, selectedAddons);
      return isSameFood && isSameAddons;
    });

    // Si el item ya existe, incrementar la cantidad
    if (cartItem != null) {
      cartItem.quantity++;
    } else {
      // Si no existe, agregar un nuevo item al carrito
      _cart.add(CartItem(food: food, selectedAddons: selectedAddons));
    }

    // Notificar a los listeners para actualizar la UI
    notifyListeners();
  }

// Método para remover del carrito
  void removeFromCart(CartItem cartItem) {
    int cartIndex = _cart.indexOf(cartItem);

    if (cartIndex != -1) {
      if (_cart[cartIndex].quantity > 1) {
        _cart[cartIndex].quantity--;
      } else {
        _cart.removeAt(cartIndex);
      }
    }

    // Notificar a los listeners para actualizar la UI
    notifyListeners();
  }

  // Método para incrementar la cantidad de un artículo
  void incrementCartItem(CartItem cartItem) {
    int index = _cart.indexOf(cartItem);
    if (index != -1) {
      _cart[index].quantity++;
      notifyListeners();
    }
  }

  // Método para decrementar la cantidad de un artículo
  void decrementCartItem(CartItem cartItem) {
    int index = _cart.indexOf(cartItem);
    if (index != -1) {
      if (_cart[index].quantity > 1) {
        _cart[index].quantity--;
      } else {
        _cart.removeAt(index);
      }
      notifyListeners();
    }
  }

  // Método para obtener el precio total del carrito
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

  // Método para obtener el total de artículos en el carrito
  int getTotalItemCount() {
    int totalItemCount = 0;
    for (CartItem cartItem in _cart) {
      totalItemCount += cartItem.quantity;
    }
    return totalItemCount;
  }

//clear cart
  // void clearCart() {
  //   _cart.clear();

  //   notifyListeners();
  // }

// update delivery address

  void updateDeliveryAddress(String newaddress) {
    _deliveryAddress = newaddress;
    notifyListeners();
  }
/*

  H E L P E R S

 */

  // Método para realizar el pago
  void makePayment() {
    if (_cart.isEmpty) {
      // Si el carrito está vacío, no se puede pagar
      return;
    }

    // Aquí podrías agregar la lógica para procesar el pago, como conectar con una API de pagos.

    // Simulamos el proceso de pago
    _isPaid = true;
    _clearCartAfterPayment();
    notifyListeners();
  }

  // Método para limpiar el carrito después de un pago
  void _clearCartAfterPayment() {
    _cart.clear();
    notifyListeners();
  }

// Crear un formateador de moneda para los precios en pesos colombianos
  final currencyFormatter = NumberFormat.currency(
    locale: 'es_CO', // Locale para Colombia
    symbol: '\$', // Símbolo de pesos colombianos
    decimalDigits: 0, // Sin decimales
    customPattern: '\u00A4 #,###', // Mostrar el símbolo antes
  );

  get userEmail => null;

// Generar el recibo
  String displayCartReceipt() {
    final receipt = StringBuffer();
    receipt.writeln("=======================================");
    receipt.writeln(_centerText("FACTURA DE COMPRA"));
    receipt.writeln("=======================================");

    String formattedDate =
        DateFormat('yyyy-MM-dd hh:mm a').format(DateTime.now());
    receipt.writeln("Fecha y hora: $formattedDate\n");

    receipt.writeln("Mesa: ${_selectedTable ?? 'Ninguna'}");
    receipt.writeln("---------------------------------------");

    for (final cartItem in _cart) {
      receipt.writeln(
          "${cartItem.quantity} x ${cartItem.food.name.padRight(20)} ${_formatPrice(cartItem.food.price)}");

      if (cartItem.selectedAddons.isNotEmpty) {
        receipt.writeln(
            "  Complementos: ${_formatAddons(cartItem.selectedAddons)}");
      }
    }

    receipt.writeln("---------------------------------------");
    receipt.writeln("Total artículos: ${getTotalItemCount()}");
    receipt.writeln("Total a pagar: ${_formatPrice(getTotalPrice())}\n");

    receipt.writeln("Entrega en: $deliveryAddress");
    receipt.writeln("=======================================");
    receipt.writeln(_centerText("¡Gracias por tu compra!"));
    receipt.writeln("=======================================");

    return receipt.toString();
  }

// Función para centrar el texto en el recibo
  String _centerText(String text) {
    int maxLength = 45; // Longitud máxima de la línea
    int padding =
        (maxLength - text.length) ~/ 2; // Calcula el espacio necesario
    return ' ' * padding +
        text; // Añade espacios antes del texto para centrarlo
  }

// Formatear precio como moneda (en pesos colombianos con el símbolo ₱)
  String _formatPrice(double price) {
    return currencyFormatter.format(price); // Utiliza el formateador de moneda
  }

// Formatear lista de complementos en un resumen
  String _formatAddons(List<Addon> addons) {
    return addons
        .map((addon) => "${addon.name}(${_formatPrice(addon.price)})")
        .join(", ");
  }

  void updateSelectedTable(String table) {
    _selectedTable = table;
    notifyListeners(); // Notifica cambios a los listeners
  }

  // Función para agregar una nueva mesa
  void addTable(String tableName) {
    availableTables.add(tableName);
    notifyListeners();
  }

  // Función para eliminar una mesa
  void removeTable(String tableName) {
    availableTables.remove(tableName);
    notifyListeners();
  }
}

// Obtener la hora actual
final currentTime = DateTime.now();
// Sumar 20 minutos
final deliveryTime = currentTime.add(const Duration(minutes: 20));

// Formatear la hora de entrega
final formattedTime = DateFormat('hh:mm a').format(deliveryTime);

// modelo para el usuario

class UserModel extends ChangeNotifier {
  String _name = '';
  String _email = '';

  String get name => _name;
  String get email => _email;

  void updateUser(String name, String email) {
    _name = name;
    _email = email;
    notifyListeners();
  }
}

void logout(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  context
      .read<UserModel>()
      .updateUser('Usuario predeterminado', 'usuario@ejemplo.com');
}
