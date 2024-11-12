// food item
class Food {
  final String name; // cheese burger
  final String description; // a burger full of cheese
  final String imagPhat; // lib/images/cheese_burger.png
  final double price; // 4.99
  final FoodCategory category; // burger
  List<Addon> availableAddons; // [ extra cheese, sauce, extra patty]

  Food({
    required this.name,
    required this.description,
    required this.imagPhat,
    required this.price,
    required this.category,
    required this.availableAddons,
  });
}

//food category
enum FoodCategory {
  hamburguesa,
  sandwich,
  helado,
  pizza,
  bebidas,
}

//food addons
class Addon {
  final String name;
  final double price;

  Addon({
    required this.name,
    required this.price,
  });
}
